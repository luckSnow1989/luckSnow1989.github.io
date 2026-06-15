#!/bin/bash
# render.sh — HTML → PDF using Playwright headless Chromium
# Usage: render.sh <input.html> [paper] [orientation]
# Default: A4 portrait

set -e

INPUT="$1"
PAPER="${2:-A4}"
ORIENT="${3:-portrait}"

if [ -z "$INPUT" ]; then
  echo "Usage: $0 <input.html> [A4|A5|A3|Letter] [portrait|landscape]"
  exit 1
fi

# Resolve absolute path for the input file
ABS_INPUT=$(readlink -f "$INPUT")
BASENAME=$(basename "$INPUT" .html)
DIRNAME=$(dirname "$ABS_INPUT")
OUTPUT="${DIRNAME}/${BASENAME}.pdf"

# Find chromium (try Playwright's bundled first, then system fallback)
CHROMIUM=""
for path in \
  "/root/.cache/ms-playwright/chromium-1223/chrome-linux/chrome" \
  "/usr/bin/chromium" \
  "/usr/bin/google-chrome" \
  "/usr/bin/chromium-browser"; do
  if [ -x "$path" ]; then
    CHROMIUM="$path"
    break
  fi
done

if [ -z "$CHROMIUM" ]; then
  echo "Error: No chromium found. Tried:"
  echo "  /root/.cache/ms-playwright/chromium-1223/chrome-linux/chrome"
  echo "  /usr/bin/chromium, /usr/bin/google-chrome, /usr/bin/chromium-browser"
  exit 1
fi

# Find playwright module
PLAYWRIGHT_PATH="/usr/local/lib/node_modules/playwright"
if [ ! -d "$PLAYWRIGHT_PATH" ]; then
  echo "Error: playwright not found at $PLAYWRIGHT_PATH"
  exit 1
fi

# Build the render command
LANDSCAPE_FLAG=""
if [ "$ORIENT" = "landscape" ]; then
  LANDSCAPE_FLAG="landscape: true,"
fi

cat > /tmp/_render_html2pdf.cjs <<EOF
const { chromium } = require('$PLAYWRIGHT_PATH');
const path = require('path');
(async () => {
  const browser = await chromium.launch({
    executablePath: '$CHROMIUM',
    args: ['--no-sandbox']
  });
  const ctx = await browser.newContext();
  const page = await ctx.newPage();
  await page.goto('file://$ABS_INPUT', { waitUntil: 'networkidle' });
  await page.pdf({
    path: '$OUTPUT',
    format: '$PAPER',
    $LANDSCAPE_FLAG
    printBackground: true,
    margin: { top: '0', right: '0', bottom: '0', left: '0' }
  });
  console.log('✓ PDF: $OUTPUT');
  await browser.close();
})();
EOF

node /tmp/_render_html2pdf.cjs
rm -f /tmp/_render_html2pdf.cjs
