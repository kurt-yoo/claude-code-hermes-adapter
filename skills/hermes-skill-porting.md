# Porting Hermes skills to Claude Code

Use this skill when converting a Hermes Agent skill into a Claude Code skill, rule, or custom agent.

## Goal

Preserve the reusable procedure while replacing Hermes-specific mechanics with Claude Code-compatible instructions.

## Conversion steps

1. Read the Hermes `SKILL.md`.
2. Remove Hermes metadata that Claude Code does not need.
3. Keep the trigger condition: when should the skill be used?
4. Convert tool references:
   - `terminal()` -> Bash
   - `read_file` -> Read
   - `write_file` -> Write
   - `patch` -> Edit/MultiEdit
   - `todo` -> Claude Code planning/todo capability
   - `delegate_task` -> custom agents or subagents, if available
   - `memory` -> CLAUDE.md or `.claude/rules/*.md`
   - `session_search` -> not directly portable; summarize durable context
5. Remove private paths, secrets, and organization-specific details unless the skill is project-local.
6. Make commands explicit and copy-pasteable.
7. Add a verification section.
8. Keep the final skill concise.

## Output locations

- Global reusable skill: `~/.claude/skills/<name>.md`
- Project reusable skill: `<project>/.claude/skills/<name>.md`
- Always-on project rule: `<project>/.claude/rules/<name>.md`
- Specialized persona: `<project>/.claude/agents/<name>.md` or `~/.claude/agents/<name>.md`
