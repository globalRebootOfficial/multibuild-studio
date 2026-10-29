# Architecture

Current scaffold:
- Flutter UI lives in app/ and manages editor state and build logs.
- Rust core in core/ validates JSON build requests.
- Target-specific adapters and toolchain manifests will be added only with verified upstream sources.
- CI checks formatting, tests, and static analysis where SDKs are available.

Planned integration: stabilize the request schema, wire Dart FFI per platform, implement real target adapters, validate artifacts, and add project archive support.

Root operations must be opt-in and confirmed. Do not pass untrusted source text into shell commands; invoke processes using argument arrays and explicit working directories.