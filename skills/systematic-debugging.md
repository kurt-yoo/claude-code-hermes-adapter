# Systematic debugging

Use this skill when a command, test, build, integration, or user-reported behavior fails unexpectedly.

## Process

1. Reproduce or observe the failure.
   - Capture the exact command, input, stack trace, and exit code.
   - If the user supplied logs, quote the relevant lines.
2. Define expected vs actual behavior.
3. Inspect the smallest relevant code path.
4. Form one hypothesis at a time.
5. Test the hypothesis with a focused command or code inspection.
6. Make the smallest safe fix.
7. Re-run the failing check.
8. Run adjacent regression checks when practical.

## Anti-patterns

- Do not edit code before understanding the failure.
- Do not make several unrelated fixes at once.
- Do not claim a root cause without evidence.
- Do not stop at "it should work now" without verification.

## Final report

Report:

- Root cause
- Fix
- Verification command and result
- Any remaining uncertainty
