# Claude Code Hermes Adapter

Bring Hermes-style operating discipline, reusable skills, and project conventions into Claude Code.

This repository is a small, portable adapter layer for people who like Hermes Agent's workflow:

- explicit tool-use discipline
- persistent project instructions
- reusable skill documents
- systematic debugging and testing habits
- project-specific operating rules, such as worktree workflows

It does not bypass Claude or Anthropic policy. It only gives Claude Code better context and better procedures.

## What this installs

The installer copies a Claude Code configuration pack into your Claude config directory:

```text
~/.claude/
  CLAUDE.md                  # global Hermes-style operating guide
  skills/
    systematic-debugging.md
    test-driven-development.md
    github-pr-workflow.md
    hermes-skill-porting.md
  agents/
    hermes-planner.md
    hermes-reviewer.md
    hermes-implementer.md
```

You can also install into a project instead of your global home config:

```text
<project>/.claude/
  rules/hermes-operating-rules.md
  skills/*.md
  agents/*.md
```

## Quick start

Clone the repo, then run:

```bash
./scripts/install.sh --global
```

Or install into a specific project:

```bash
./scripts/install.sh --project /path/to/project
```

Then start Claude Code:

```bash
claude
```

For a one-shot task:

```bash
claude -p "Use the Hermes-style workflow to inspect this repository and suggest improvements" --max-turns 5
```

## Important limitations

This adapter does not turn Claude Code into Hermes Agent.

Claude Code still uses:

- Claude Code's own system prompt
- Claude Code's own tools
- Anthropic model behavior and safety policy
- Claude Code's memory, skill, agent, MCP, and permission systems

The adapter can improve task quality and project awareness. It cannot override higher-priority model or product policies.

## Recommended usage pattern

1. Install globally with `./scripts/install.sh --global`.
2. Install project rules into important repositories with `./scripts/install.sh --project /path/to/repo`.
3. Add project-specific details to `<project>/CLAUDE.md` or `<project>/.claude/rules/*.md`.
4. Convert only the Hermes skills that are genuinely useful in Claude Code.
5. Keep skills short, concrete, and tool-name compatible with Claude Code.

## Porting Hermes skills

Hermes skills often mention Hermes-only tools such as `skill_view`, `todo`, `delegate_task`, `memory`, `session_search`, `terminal`, `patch`, and `read_file`.

When porting them to Claude Code, translate those ideas to Claude Code primitives:

| Hermes concept | Claude Code equivalent |
| --- | --- |
| `skill_view(name)` | Read `.claude/skills/<name>.md` or rely on Claude Code skill loading |
| `todo` tool | Use Claude Code's todo planning capability |
| `terminal()` | Use Bash |
| `read_file` | Use Read |
| `patch` | Use Edit / MultiEdit |
| `write_file` | Use Write |
| `delegate_task` | Use Claude Code subagents / custom agents when available |
| `memory` | Update CLAUDE.md, `.claude/rules/*.md`, or Claude Code memory intentionally |
| `session_search` | Not directly portable; summarize important durable context in project rules |

See `docs/porting-guide.md` for the full process.

## Repository layout

```text
.
├── agents/              # Claude Code custom agents
├── docs/                # Design notes and porting guide
├── scripts/             # Installer and helpers
├── skills/              # Claude Code skill documents
├── templates/           # Global and project CLAUDE/rules templates
├── LICENSE
└── README.md
```

## Security note

Do not blindly copy private memories, secrets, tokens, customer details, or internal repository paths into public prompts or skills.

Project-specific workflow rules can be useful, but public templates should stay generic. Keep private rules in your own `.claude/` files.

## License

MIT
