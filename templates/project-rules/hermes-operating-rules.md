# Hermes-style project operating rules

Use these project-local rules when working in this repository with Claude Code.

## Repository-first workflow

1. Inspect repository layout before making assumptions.
2. Read existing code and tests before editing.
3. Follow the project's package manager, formatter, test runner, and commit conventions.
4. Prefer the smallest safe change that solves the user's request.
5. Run the narrowest relevant verification first, then broader checks when appropriate.

## Planning

Use a short plan for tasks with three or more steps. Update it as work completes.

## Debugging

When debugging, do not guess. Capture the exact failing command, error, expected behavior, and actual behavior. Form a hypothesis, test it, then change code.

## Final response

Include:

- What changed
- Files changed
- Verification commands run
- Any remaining risks or follow-up work
