#!/usr/bin/env bash
set -Eeuo pipefail

APP="JPG2PDF"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT="$ROOT/release"
VENV="$ROOT/.venv"
APPIMAGETOOL="$HOME/Downloads/appimagetool-x86_64.AppImage"

echo "=== JPG2PDF AppImage Builder ==="

for path in "$VENV/bin/activate" "$APPIMAGETOOL" "$ROOT/src/jpg2pdf.py" "$ROOT/req.txt"; do
    [[ -e "$path" ]] || {
        echo "ERROR: Missing $path"
        exit 1
    }
done

mkdir -p "$OUT"
# shellcheck disable=SC1091
source "$VENV/bin/activate"

python -m pip install -r "$ROOT/req.txt" PyInstaller PyQt5
python -c "from PyQt5 import QtCore, QtGui, QtWidgets; from PIL import Image; import pikepdf"

TEMP="$(mktemp -d "$OUT/.build-XXXXXX")"
trap 'rm -rf "$TEMP"' EXIT

echo "[1/3] Building executable..."
pyinstaller --noconfirm --clean --windowed \
    --name "$APP" \
    --hidden-import=PyQt5.QtCore \
    --hidden-import=PyQt5.QtGui \
    --hidden-import=PyQt5.QtWidgets \
    --collect-all=PyQt5.Qt5 \
    --collect-all=pikepdf \
    --distpath "$TEMP/dist" \
    --workpath "$TEMP/work" \
    --specpath "$TEMP" \
    "$ROOT/src/jpg2pdf.py"

EXE="$TEMP/dist/$APP/$APP"
[[ -x "$EXE" ]] || {
    echo "ERROR: Executable not generated"
    exit 1
}

echo "[2/3] Preparing AppDir..."
APPDIR="$TEMP/$APP.AppDir"
mkdir -p "$APPDIR/usr/bin"
cp -r "$TEMP/dist/$APP/." "$APPDIR/usr/bin/"

cat > "$APPDIR/AppRun" <<'LAUNCHER'
#!/bin/sh
HERE="$(dirname "$(readlink -f "$0")")"
exec "$HERE/usr/bin/JPG2PDF" "$@"
LAUNCHER
chmod +x "$APPDIR/AppRun"

cat > "$APPDIR/JPG2PDF.desktop" <<'DESKTOP'
[Desktop Entry]
Name=JPG2PDF
Exec=AppRun
Icon=JPG2PDF
Type=Application
Categories=Graphics;
Terminal=false
DESKTOP

python -c "from PIL import Image; Image.new('RGBA',(256,256),(40,100,180,255)).save('$APPDIR/JPG2PDF.png')"

echo "[3/3] Generating AppImage..."
chmod +x "$APPIMAGETOOL"
ARCH=x86_64 "$APPIMAGETOOL" "$APPDIR" "$TEMP/JPG2PDF-x86_64.AppImage"

mv -f "$TEMP/JPG2PDF-x86_64.AppImage" "$OUT/JPG2PDF-x86_64.AppImage"

echo "================================"
echo "BUILD SUCCESSFUL!"
echo "================================"
ls -lh "$OUT/JPG2PDF-x86_64.AppImage"
