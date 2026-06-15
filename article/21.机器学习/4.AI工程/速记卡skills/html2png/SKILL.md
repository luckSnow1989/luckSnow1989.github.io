---
name: html2png
description: Render local HTML (with CSS) into high-quality PNG images via headless Chromium and pdftoppm. Use when the user wants to export an HTML snippet / page / styled document / report / cheatsheet / poster / one-pager as a printable image, especially when the content is text-heavy, multilingual (Chinese / Japanese / Korean), or requires precise layout. Triggers: "把这段 HTML 导出成图片", "做张速查卡", "生成 A4 报告", "HTML 转 PNG", "render this as image", "make a cheatsheet image". Do NOT use for: creative/artistic images (use DALL-E / Midjourney), PDF editing, video / animation, raster image manipulation, or when the user just wants to screenshot a website (use Playwright `page.screenshot()` instead).
---

# html2png — HTML → PDF → PNG pipeline

Render an HTML file to a high-quality PNG image using headless Chromium + pdftoppm. Optimized for **text-heavy, multilingual, print-ready** output (cheatsheets, reports, posters, one-pagers, certificates).

## When to use vs not use

Use when:
- User has HTML (or markdown convertible to HTML) and wants an image
- Output must be printable at A4/A5/A3/Letter size
- Content includes Chinese / Japanese / Korean / other non-Latin scripts (AI image generators mangle these)
- Layout must be pixel-precise (tables, grids, code blocks, JSON, etc.)
- User wants a single A4/poster-style image, not a webpage screenshot

Don't use when:
- User wants a creative illustration → use DALL-E / image_synthesize
- User wants to screenshot an existing live website → use Playwright `page.screenshot()` directly
- User wants to edit an existing PDF → use pdf skill
- User wants video / GIF → out of scope

## Procedure

1. **Write the HTML** at `<workspace>/html2png-work/<name>.html`.
   - Use inline `<style>` for portability (no external CSS files).
   - Set paper size with `@page { size: A4 portrait; margin: X; }` at the top of the `<style>` block.
   - Use system font stack: `-apple-system, "PingFang SC", "Microsoft YaHei", sans-serif` for CJK fallback.
   - For mono code: `"SF Mono", Consolas, monospace`.
   - Keep total height under one page by tightening `font-size` (8-10pt) and `padding`/`margin` if content overflows. Test render and check page count.

2. **Render to PDF** using the bundled script:
   ```bash
   bash /workspace/.skills/html2png/scripts/render.sh <name>.html [A4|A5|A3|Letter] [portrait|landscape]
   ```
   - Output: `<name>.pdf` in the same directory.
   - This handles Playwright launch + chromium path automatically.

3. **Convert PDF to PNG**:
   ```bash
   pdftoppm -png -r <dpi> <name>.pdf <name>
   ```
   - Default `-r 200` (good for screen, prints at 200 DPI).
   - Use `-r 300` for high-quality print, `-r 150` for smaller files.
   - Output: `<name>-1.png` (one file per page). Delete extra pages with `rm <name>-2.png ...`.

4. **Clean up intermediates**:
   ```bash
   rm <name>.pdf
   ```

5. **Deliver** the final PNG via `<deliver-assets>` block with absolute path.

## Output contract

- A single PNG file at the requested paper size.
- Filename ends with `-1.png` (or `-N.png` for N pages — but multi-page is a failure signal; tighten the HTML instead).
- Resolution ≥ 150 DPI (default 200).
- All visible text legible at the target size (test by opening the PNG at 100% zoom).

## Failure handling

| Symptom | Cause | Fix |
|---|---|---|
| "Executable doesn't exist" error from Playwright | Playwright's bundled chromium-headless-shell missing | Use the system chromium via the `executablePath` in `render.sh` (already wired) |
| Content overflows to page 2 | HTML too tall for the paper | Reduce `font-size` 1pt, reduce `padding`/`margin` by 20%, or shorten text |
| Chinese characters missing / boxes | Font fallback not configured | Add `"PingFang SC", "Microsoft YaHei"` to font stack |
| PDF blank but HTML looks fine | `printBackground: false` (default in some configs) | Ensure `printBackground: true` is set in `render.sh` |
| Output too large (> 5 MB for one A4) | DPI too high | Drop to `-r 150` |
| Page is portrait when user wanted landscape | Forgot flag | Pass `landscape` as 3rd arg to `render.sh` |

## Common paper sizes

| Size | Dimensions (px at 200 DPI) | Typical use |
|---|---|---|
| A5 portrait | 1167 × 1656 | Cheatsheet, pocket card |
| A4 portrait | 1656 × 2342 | Report, one-pager |
| A4 landscape | 2342 × 1656 | Wide table, comparison |
| A3 landscape | 3300 × 2338 | Multi-column poster, 5+ items side-by-side |
| Letter portrait | 1700 × 2200 | US standard |

## Examples

**Minimal HTML template** (copy-paste starting point):
```html
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><style>
  @page { size: A4 portrait; margin: 8mm; }
  body { font-family: -apple-system, "PingFang SC", sans-serif; padding: 8mm; }
  h1 { color: #2d3748; border-bottom: 2px solid #3182ce; }
</style></head>
<body>
  <h1>Title</h1>
  <p>Content...</p>
</body></html>
```

**See** `references/html-template.md` for a richer A4 cheatsheet template with grid layout.

## Reference docs

- `references/html-template.md` — full A4 cheatsheet template (copy & adapt)
- `references/pitfalls.md` — known issues and fixes from real renderings
- `scripts/render.sh` — the one command to render HTML → PDF
