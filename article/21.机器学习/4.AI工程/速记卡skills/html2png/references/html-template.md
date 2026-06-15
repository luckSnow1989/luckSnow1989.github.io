# A4 Cheatsheet HTML Template

Copy this, then adapt the colors / content. Designed to fit on **one A4 portrait** page when content is moderate (~10 sections).

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>Title</title>
<style>
  @page { size: A4 portrait; margin: 7mm; }
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    font-family: -apple-system, "PingFang SC", "Microsoft YaHei", sans-serif;
    color: #1a202c;
    background: white;
    padding: 7mm;
    font-size: 9pt;
    line-height: 1.3;
  }
  .header {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    border-bottom: 2px solid #3182ce;
    padding-bottom: 3pt;
    margin-bottom: 5pt;
  }
  h1 { font-size: 16pt; color: #2d3748; }
  .badge {
    background: #3182ce; color: white;
    padding: 2pt 6pt; border-radius: 3pt;
    font-size: 7.5pt; font-weight: 600;
  }
  h2 {
    font-size: 10pt; margin: 4pt 0 2pt;
    padding-left: 5pt; border-left: 3px solid #3182ce;
    color: #2d3748;
  }
  /* Emergency / alert box */
  .alert {
    border: 1.5px solid #ed8936;
    border-radius: 3pt;
    padding: 3pt 8pt;
    background: #fffaf0;
    margin-bottom: 4pt;
  }
  .alert h2 { border-left-color: #ed8936; color: #c05621; margin: 0 0 1pt; font-size: 9.5pt; }
  /* Standard box */
  .box {
    background: #ebf8ff;
    border-radius: 3pt;
    padding: 5pt 8pt;
    margin: 3pt 0;
  }
  /* Dark code/config block */
  .code {
    background: #1a202c; color: #e2e8f0;
    font-family: "SF Mono", Consolas, monospace;
    font-size: 8pt;
    padding: 4pt 8pt;
    border-radius: 2pt;
    margin: 2pt 0;
    line-height: 1.5;
  }
  /* Grid: 2 columns or 3 columns */
  .grid-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 4pt; }
  .grid-3 { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 4pt; }
  .grid-5 { display: grid; grid-template-columns: repeat(5, 1fr); gap: 4pt; }
  /* Table */
  table { width: 100%; border-collapse: collapse; font-size: 8.5pt; }
  td { padding: 1pt 4pt; }
  .cmd-table { font-family: "SF Mono", Consolas, monospace; font-size: 8pt; }
  .cmd-table td:first-child { color: #2b6cb0; font-weight: 600; }
  /* Wisdom line at bottom */
  .wisdom {
    text-align: center;
    font-style: italic;
    color: #4a5568;
    font-size: 9pt;
    margin: 4pt 0 2pt;
    padding: 3pt;
    border-top: 1px dashed #cbd5e0;
    border-bottom: 1px dashed #cbd5e0;
  }
  /* Footer */
  .footer {
    text-align: center;
    color: #718096;
    font-size: 7pt;
    margin-top: 2pt;
  }
</style>
</head>
<body>

<div class="header">
  <h1>Title</h1>
  <span class="badge">Badge</span>
</div>

<div class="alert">
  <h2>🚨 Alert Title</h2>
  <table>
    <tr><td>Issue 1</td><td>→ Solution 1</td><td>Issue 2</td><td>→ Solution 2</td></tr>
  </table>
</div>

<h2>Section Title</h2>
<div class="box">
  Content of the section...
</div>

<h2>Command Table</h2>
<table class="cmd-table">
  <tr><td>command 1</td><td>description 1</td></tr>
  <tr><td>command 2</td><td>description 2</td></tr>
</table>

<h2>Dark Code Block</h2>
<div class="code">
key: value<br>
key2: value2
</div>

<h2>Grid 2-Column</h2>
<div class="grid-2">
  <div>Left column</div>
  <div>Right column</div>
</div>

<div class="wisdom">
💡 Wisdom or motto here
</div>

<div class="footer">
github.com/owner/repo
</div>

</body>
</html>
```

## Customization knobs

- **Color theme**: change `#3182ce` (the main accent) to your project's color.
- **Paper size**: `@page { size: A4 portrait; }` → swap to `A3 landscape`, `A5 portrait`, `Letter`, etc.
- **Density**: `font-size: 9pt` is the sweet spot. Below 7.5pt becomes hard to read.
- **Page count**: if your content overflows, drop font-size by 1pt or reduce section padding.

## Color palettes that work well

| Theme | Primary | Background tint |
|---|---|---|
| Blue (default) | `#3182ce` | `#ebf8ff` |
| Purple | `#805ad5` | `#faf5ff` |
| Orange | `#dd6b20` | `#fffaf0` |
| Teal | `#319795` | `#e6fffa` |
| Magenta | `#d53f8c` | `#fff5f7` |
| Green | `#48bb78` | `#f0fff4` |
| Red (alert) | `#e53e3e` | `#fff5f5` |
| Yellow (warn) | `#d69e2e` | `#fef5e7` |
| Dark gray (code) | `#1a202c` | (dark) |
