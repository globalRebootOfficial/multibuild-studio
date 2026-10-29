# multibuild-studio

Cross-platform build-studio scaffold built with Flutter and Rust.

> Status: early scaffold. This repository is not yet a production-ready compiler or APK/EXE builder. Toolchain integrations and end-to-end tests are still being implemented.

## Layout
- app/ — Flutter UI
- core/ — Rust build orchestration core
- docs/ — architecture and security notes
- .github/workflows/ — CI checks

## Run Flutter
    cd app
    flutter pub get
    flutter run

## Test Rust
    cd core
    cargo test

The Flutter UI and Rust core are currently separate; Dart FFI packaging is not wired end-to-end yet. A build request must not be treated as a successful compilation until a real target toolchain is connected and the output is validated.

## Security
Toolchain downloads must use trusted HTTPS sources and verified SHA-256 checksums. Root access is optional and must require visible, explicit user confirmation.

## License
MIT — see LICENSE.