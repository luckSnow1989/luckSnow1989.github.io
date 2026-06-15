# Pitfalls & fixes from real renderings

Issues hit while generating 10+ cheatsheets for the AI Coding Frameworks tutorial. Each entry: symptom → root cause → fix.

## 1. "Executable doesn't exist" from Playwright

**Symptom**:
```
browserType.launch: Executable doesn't exist at /workspace/.home/.cache/ms-playwright/chromium_headless_shell-1223/chrome-headless-shell-linux64/chrome-headless-shell
```

**Root cause**: Playwright expects a special "headless shell" build. The system has a full `chromium` build but not the headless shell variant.

**Fix**: pass `executablePath` to `chromium.launch()` pointing at the full Chromium:
```js
chromium.launch({
  executablePath: '/root/.cache/ms-playwright/chromium-1223/chrome-linux/chrome',
  args: ['--no-sandbox']
})
```

`render.sh` in this skill handles this automatically.

## 2. Content overflows to page 2

**Symptom**: HTML looks fine in browser preview, but PDF has 2 pages with a tiny amount of overflow on page 2.

**Root cause**: Browser preview doesn't enforce page boundaries the way `print()` does. Content that "fits" on screen spills onto page 2 in print.

**Fix**: 
- Drop `font-size` by 1pt globally
- Reduce section `padding` and `margin` by ~20%
- Shorten text
- For cheatsheets: 9pt body, 10pt h2, 16pt h1 is the magic combo for A4 portrait

**Test fix**: re-render and `identify *.png` — should see only `*-1.png`, no `*-2.png`.

## 3. Chinese characters become boxes

**Symptom**: Latin characters render fine, but Chinese is `□□□`.

**Root cause**: Font fallback not configured; Linux Chromium doesn't have CJK fonts by default, or the font stack doesn't list them.

**Fix**: Use a font stack that lists CJK fonts:
```css
font-family: -apple-system, "PingFang SC", "Microsoft YaHei", "Noto Sans CJK SC", "WenQuanYi Micro Hei", sans-serif;
```

For Linux without CJK fonts, install Noto:
```bash
sudo apt install fonts-noto-cjk
```

## 4. Background colors don't print

**Symptom**: HTML in browser has colored boxes / sections; PDF is all white.

**Root cause**: Chromium's `printBackground` defaults to `false` in some configs.

**Fix**: Ensure `printBackground: true` in the PDF call. Already set in `render.sh`.

## 5. Margins are bigger than expected

**Symptom**: Content is squished even though `@page margin: 5mm` is set.

**Root cause**: `page.pdf()` overrides `@page` margin with its own default if not explicitly set.

**Fix**: Pass `margin: 0` to `page.pdf()` to let `@page` CSS win, OR set both to the same value:
```js
await page.pdf({
  margin: { top: '0', right: '0', bottom: '0', left: '0' }  // uses @page
})
```

## 6. PDF is huge (> 10 MB)

**Symptom**: 5 MB+ for a single A4 page.

**Root cause**: DPI too high (300+) or too many embedded fonts.

**Fix**: 
- Use `-r 150` instead of `-r 200` for the PNG
- Avoid importing many Google Fonts (each is ~100KB embedded)
- Stick to system fonts

## 7. Multi-page output is intended

**Symptom**: User wants 2+ pages of output.

**Fix**: Don't fight it. The pipeline naturally produces `*-1.png`, `*-2.png`, etc. Bundle all of them in `<deliver-assets>` and label the order. But **first check if the user actually wants 1 page** — usually they do.

## 8. Special characters in HTML break the page

**Symptom**: Icons like 🚨 ✅ ❌ show as boxes or `?`.

**Root cause**: Chromium can't render the emoji font on the Linux system.

**Fix**: 
- Install `fonts-noto-color-emoji` on Linux
- Or use text alternatives: `[!]` `[OK]` `[X]`
- Or use Unicode safe symbols: `▲ ● ■` etc.

## 9. Tables overflow page width

**Symptom**: A 6-column table is cut off on the right.

**Root cause**: Table width exceeds A4 width minus margins.

**Fix**:
- Reduce `font-size` in the table (8pt is minimum readable)
- Reduce column count (split into 2 stacked 3-column tables)
- Use `table-layout: fixed; width: 100%;`

## 10. The page is white in preview but colored in print

**Symptom**: User opens the HTML in a regular browser tab, sees no background colors, complains. But the PDF/PNG looks correct.

**Root cause**: CSS in `@media print` block was set up wrong, OR the user is just looking at the wrong thing.

**Fix**: Use backgrounds outside `@media print` so they show in both. The `render.sh` script uses `printBackground: true` which honors CSS backgrounds regardless of `@media`.

## Quick diagnostic command

```bash
# If a render went wrong, check:
ls -la output-*.png       # how many pages?
file output-1.png         # correct dimensions?
identify output-1.png     # DPI and color depth
```

## Performance tips

- A single A4 render takes ~3-5 seconds
- Batching 5 cards sequentially: ~30 seconds total
- For larger batches (> 20), consider running `render.sh` in parallel (one per file)
- `waitUntil: 'networkidle'` is slow for local files; `'load'` is 2x faster with no visible quality loss
