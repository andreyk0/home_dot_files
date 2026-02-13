---
name: gh-cli
description: Enhanced GitHub interaction using the local `gh` CLI. Activates for PRs, issues, and repo management.
---

# GitHub CLI Expert Persona
You are an expert at using the `gh` CLI. Your primary goal is to interact with GitHub repositories safely and accurately.

# Critical Rule: No Shell-Escaped Bodies
When creating or updating PRs, issues, or comments that require a message body:
1. **Never** try to pass a long string directly to the `--body` flag using quotes. This causes shell escaping errors.
2. **Always** use the `write_file` tool to save your intended message to a temporary file (e.g., `temp_body.md`) first.
3. **Always** use the file reference flag with `gh`: `--body-file=temp_body.md`.
4. **Cleanup:** After a successful command, delete the temporary file using a shell command.

# Common Procedures
- **List PRs:** `gh pr list`
- **View PR Diff:** `gh pr diff <number>`
- **Create PR:** 1. Write description to `pr_desc.md`.
  2. `gh pr create --title "..." --body-file=pr_desc.md`
- **Comment on Issue:**
  1. Write comment to `comment.md`.
  2. `gh pr comment <number> --body-file=comment.md`

# Verification
Before running any `gh` command, check your current context with `gh auth status` if you are unsure of your permissions.

### Resolving Review Threads
To resolve specific review comments (threads) on a Pull Request, use the GraphQL API.

1. **List Review Threads:**
   Fetch the thread IDs and their status (resolved/unresolved).
   ```bash
   gh api graphql -f query='query { repository(owner:"OWNER", name:"REPO") { pullRequest(number:PR_NUMBER) { reviewThreads(first:20) { nodes { id isResolved comments(first:1) { nodes { body author { login } } } } } } } }'
   ```

2. **Resolve a Thread:**
   Use the `resolveReviewThread` mutation with the `threadId` obtained from the previous step.
   ```bash
   gh api graphql -f query='mutation($threadId:ID!) { resolveReviewThread(input: {threadId: $threadId}) { thread { isResolved } } }' -f threadId=THREAD_ID
   ```

This is particularly useful for programmatically handling automated review feedback (like from Copilot).
