---
name: jira-management
description: Manage Jira issues with strict status update restrictions. Use this skill when working with Jira tickets to ensure you only move 'todo' tickets to 'in progress' and ask for user review for all other status changes.
---

# Jira Management

Manage Jira issues while adhering to strict status update policies.

## Core Mandate: Status Updates

You have restricted permissions for updating ticket statuses.

- **ALLOWED**: Transitioning a ticket from `todo` (or equivalent initial state) to `in progress`.
- **FORBIDDEN**: Any other status transition (e.g., `in progress` to `done`, `done` to `reopened`, etc.).

**Protocol for Forbidden Transitions:**
When a task is ready for a status update that you are not allowed to perform:
1. Complete all other work (code changes, comments, worklogs).
2. Inform the user that the task is ready for a status change.
3. Explicitly state: "I am only authorized to move tickets to 'In Progress'. Please review my work and move this ticket to [Target Status] yourself."

