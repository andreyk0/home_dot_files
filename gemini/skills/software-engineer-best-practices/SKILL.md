---
name: software-engineer-best-practices
description: General best practices for software engineering across any language. Use when writing code, debugging, or designing systems to ensure reliability, observability, and maintainability.
---

# Software Engineer Best Practices

## Core Mandate: Observability & Transparency

### 1. No Silent Skips
**NEVER** skip processing a data item, row, or event silently.
- If a data point is invalid or filtered out, you **MUST** log it.
- **Minimum:** Log a warning (WARN) or info (INFO) message explaining *why* it was skipped and *which* item it was.
- **Example:**
  ```javascript
  // BAD
  if (!user.email) return;

  // GOOD
  if (!user.email) {
    logger.warn({ msg: "Skipping user due to missing email", userId: user.id });
    return;
  }
  ```

### 2. Verbose Logging Context
Logs must provide enough context to reconstruct the execution flow without needing to step through code.
- **Debug Level:** Use `debug` level generously for internal state transitions, loop iterations, and variable values.
- **Structure:** Prefer structured logging (JSON) over plain text when possible (e.g., `logger.info({ key: value })`).
- **Context:** Include IDs (User ID, Request ID, Transaction ID) in all relevant logs to allow tracing.

### 3. Explicit Execution Flow
When performing complex operations (like data imports, migrations, or multi-step logic):
- Log the **start** and **end** of major phases.
- Log summary statistics at the end (e.g., "Processed 100 items, 5 skipped, 0 errors").

## General Coding Standards

- **Defensive Coding:** Validate inputs early. Fail fast with clear error messages.
- **Error Handling:** Catch errors specifically. Avoid empty `catch` blocks. Always log the full stack trace of unexpected errors.
