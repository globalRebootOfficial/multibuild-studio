use serde::{Deserialize, Serialize};
use std::ffi::{c_char, CStr, CString};
use thiserror::Error;

#[derive(Debug, Deserialize)]
struct BuildRequest { target: String, language: String, source: String }

#[derive(Debug, Serialize)]
struct BuildResponse { ok: bool, message: String }

#[derive(Debug, Error)]
enum CoreError {
    #[error("invalid JSON request: {0}")]
    Json(#[from] serde_json::Error),
    #[error("request field '{0}' is empty")]
    Empty(&'static str),
}

fn handle_request(json: &str) -> Result<BuildResponse, CoreError> {
    let request: BuildRequest = serde_json::from_str(json)?;
    if request.target.trim().is_empty() { return Err(CoreError::Empty("target")); }
    if request.language.trim().is_empty() { return Err(CoreError::Empty("language")); }
    if request.source.trim().is_empty() { return Err(CoreError::Empty("source")); }
    Ok(BuildResponse {
        ok: false,
        message: format!("Validated {} source for target '{}'; compiler execution is not implemented yet.", request.language, request.target),
    })
}

/// Accepts a JSON request and returns a newly allocated JSON response.
/// The caller must release the returned pointer with mbs_string_free.
#[no_mangle]
pub unsafe extern "C" fn mbs_build_json(input: *const c_char) -> *mut c_char {
    if input.is_null() { return CString::new(r#"{"ok":false,"message":"null input"}"#).unwrap().into_raw(); }
    let input = CStr::from_ptr(input);
    let response = match input.to_str() {
        Ok(json) => match handle_request(json) {
            Ok(value) => serde_json::to_string(&value).unwrap_or_else(|_| r#"{"ok":false,"message":"serialization error"}"#.into()),
            Err(error) => serde_json::json!({"ok":false,"message":error.to_string()}).to_string(),
        },
        Err(_) => r#"{"ok":false,"message":"input is not valid UTF-8"}"#.into(),
    };
    CString::new(response).unwrap_or_else(|_| CString::new("{}").unwrap()).into_raw()
}

/// Frees a string returned by this library. Passing null is safe.
#[no_mangle]
pub unsafe extern "C" fn mbs_string_free(value: *mut c_char) {
    if !value.is_null() { drop(CString::from_raw(value)); }
}

#[no_mangle]
pub extern "C" fn mbs_version() -> u32 { 1 }

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn does_not_claim_to_build_without_a_compiler() {
        let result = handle_request(r#"{"target":"Lua bytecode","language":"Lua","source":"print(1)"}"#).unwrap();
        assert!(!result.ok);
        assert!(result.message.contains("not implemented"));
    }
    #[test]
    fn rejects_empty_source() {
        let error = handle_request(r#"{"target":"APK","language":"Java","source":" "}"#).unwrap_err();
        assert!(error.to_string().contains("source"));
    }
}