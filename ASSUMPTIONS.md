# Assumptions and limitations

- This is an early development scaffold, not a completed compiler suite.
- Flutter UI and Rust core build independently; FFI packaging remains to be integrated.
- Official toolchain URLs and real SHA-256 checksums must be verified before automatic downloads are enabled.
- Android root operations are not implemented yet and must remain opt-in.
- APK builds require Android SDK build tools and a valid Android project.
- EXE, Lua bytecode, and JavaScript bundle outputs need real target-specific toolchains.
- CI validates the scaffold, not the complete requested feature set.