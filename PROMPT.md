# Project brief

Create a cross-platform Flutter app with a Rust build orchestration core.

Principles:
- Keep platform-specific code behind interfaces.
- Never run privileged commands without an explicit user action and confirmation.
- Verify downloaded toolchains using SHA-256 before extraction or execution.
- Report build success only when the real process exits successfully and the expected output exists.
- Show unsupported target/language combinations instead of generating fake artifacts.
- Add tests and CI checks as each integration becomes real.