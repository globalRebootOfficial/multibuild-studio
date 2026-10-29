# Building

## Flutter
Install Flutter stable, then run:
    cd app
    flutter pub get
    flutter analyze
    flutter test
    flutter run

## Rust
Install Rust stable, then run:
    cd core
    cargo fmt --check
    cargo test
    cargo build

The native library is not yet wired to Flutter through FFI. Rust tests validate request parsing only; they do not compile source into APK, EXE, Lua bytecode, or JavaScript bundles.