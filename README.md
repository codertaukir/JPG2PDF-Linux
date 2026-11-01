# JPG2PDF for Linux

A desktop application for converting JPG/JPEG images into PDF files.

This repository contains Linux packaging and release resources for JPG2PDF, including an AppImage build script.

## Current packaging

- Portable AppImage package for x86_64 Linux.
- PyInstaller-based application bundle.
- AppImage can be launched without installing Python packages separately.

> **Compatibility note:** An AppImage built on a recent distribution may not run on older Linux distributions because some system libraries, especially glibc, are not bundled. Build on an appropriately old compatible Linux baseline and test on the distributions you intend to support.

## Build locally

The build script expects the application source tree to contain `src/jpg2pdf.py` and `req.txt`, and expects an AppImageTool binary at:

```text
~/Downloads/appimagetool-x86_64.AppImage
```

Run:

```bash
chmod +x build-all.sh
./build-all.sh
```

The resulting package is written to:

```text
release/JPG2PDF-x86_64.AppImage
```

Run it:

```bash
chmod +x release/JPG2PDF-x86_64.AppImage
./release/JPG2PDF-x86_64.AppImage
```

## Runtime dependencies

The Python application currently uses:

- PyQt5
- Pillow
- fpdf2
- pikepdf

The build script installs Python dependencies from `req.txt` and installs PyInstaller and PyQt5 in the project's virtual environment.

## Releases

Download published AppImage builds from the repository's **Releases** page. Large binary packages should be attached to GitHub Releases rather than committed to Git history.

## Contributing

Bug reports and improvements are welcome. Please include your Linux distribution, architecture, and relevant error output when reporting packaging issues.

## License

The upstream application's license and required attribution must be preserved. This packaging repository does not change the license of the upstream project.
