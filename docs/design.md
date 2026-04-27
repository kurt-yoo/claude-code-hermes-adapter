# Design

## Goals

- Make Hermes-style workflows usable in Claude Code.
- Keep the adapter readable and auditable.
- Avoid private, machine-specific assumptions in the public repository.
- Provide templates that users can customize.

## Non-goals

- Reimplement Hermes Agent inside Claude Code.
- Bypass model safety policy.
- Provide a universal conversion for every Hermes tool.
- Copy private memories or organization-specific secrets.

## Adapter layers

1. Global `CLAUDE.md`: always-on operating style.
2. Project rules: repository-specific durable context.
3. Skills: reusable task procedures.
4. Agents: role-specific prompts.
5. Optional MCP: future bridge for actual Hermes capabilities.

## Why not copy the full Hermes prompt?

A full prompt copy is usually worse:

- It wastes context.
- It mentions tools Claude Code does not have.
- It can conflict with Claude Code's own system prompt.
- It may accidentally publish private memory.

A small compatibility layer is easier to maintain and safer to share.
