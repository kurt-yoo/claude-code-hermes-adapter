# Porting guide: Hermes Agent to Claude Code

This guide explains how to reuse Hermes Agent prompts and skills inside Claude Code.

## Mental model

Hermes and Claude Code are both coding agents, but their extension points are different.

Hermes uses:

- system/persona prompt
- toolsets
- persistent memory
- skills under `~/.hermes/skills/`
- session search
- delegation
- cron jobs

Claude Code uses:

- `CLAUDE.md`
- `.claude/rules/*.md`
- `.claude/skills/*.md`
- `.claude/agents/*.md`
- MCP servers
- built-in tools such as Read, Edit, Write, Bash, WebSearch, and subagents

The goal is not a byte-for-byte copy. The goal is to preserve behavior.

## What belongs where

### CLAUDE.md

Use for always-on global or project guidance:

- user preferences
- repository conventions
- safety rules
- verification expectations
- high-level workflow discipline

### `.claude/rules/*.md`

Use for modular always-on rules in a project:

- branching workflow
- testing commands
- architecture notes
- release process

### `.claude/skills/*.md`

Use for procedures that should be invoked only when relevant:

- debugging
- writing PRs
- migrations
- reviews
- incident response

### `.claude/agents/*.md`

Use for specialized roles:

- planner
- reviewer
- implementer
- security reviewer
- database expert

## Conversion checklist

- [ ] Remove private memory and secrets.
- [ ] Replace Hermes tool names with Claude Code tool names.
- [ ] Keep commands explicit.
- [ ] Add verification steps.
- [ ] Keep the skill short enough to be useful.
- [ ] Test the skill on a small task before relying on it.

## Policy boundary

This adapter cannot bypass Claude Code or Anthropic restrictions. Do not present it as a jailbreak or refusal bypass. It is a context and workflow adapter.
