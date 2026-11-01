# JPG2PDF for Linux

A Linux packaging and release project for **JPG2PDF**, a desktop application that converts JPG/JPEG images into PDF files.

The application is based on the upstream project: [rishabh3354/JPG2PDF](https://github.com/rishabh3354/JPG2PDF). This repository adds Linux-focused AppImage packaging and release resources. Upstream attribution and its MIT license are retained.

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

## License and attribution

This project retains the upstream application's MIT license and copyright notice. See [LICENSE](LICENSE) for the applicable terms and attribution.
