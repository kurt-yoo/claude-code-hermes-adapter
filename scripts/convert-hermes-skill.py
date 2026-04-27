#!/usr/bin/env python3
"""Small helper to draft a Claude Code skill from a Hermes SKILL.md.

This is intentionally conservative. It performs mechanical replacements and
prints a draft for human review.
"""
from __future__ import annotations

import argparse
import re
from pathlib import Path

REPLACEMENTS = {
    "skill_view": "read the relevant .claude/skills file",
    "todo tool": "Claude Code todo/planning capability",
    "todo": "Claude Code todo/planning capability",
    "delegate_task": "Claude Code custom agents or subagents",
    "memory tool": "CLAUDE.md or .claude/rules/*.md",
    "memory": "CLAUDE.md or .claude/rules/*.md",
    "session_search": "project notes or summarized prior context",
    "terminal": "Bash",
    "read_file": "Read",
    "write_file": "Write",
    "patch": "Edit/MultiEdit",
}


def strip_frontmatter(text: str) -> str:
    if text.startswith("---"):
        parts = text.split("---", 2)
        if len(parts) == 3:
            return parts[2].lstrip()
    return text


def convert(text: str) -> str:
    text = strip_frontmatter(text)
    for old, new in REPLACEMENTS.items():
        text = re.sub(rf"\b{re.escape(old)}\b", new, text)
    banner = "# Draft Claude Code skill\n\n> Generated from a Hermes skill. Review before installing.\n\n"
    return banner + text


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("input", help="Path to Hermes SKILL.md")
    parser.add_argument("-o", "--output", help="Output path. Defaults to stdout.")
    args = parser.parse_args()

    text = Path(args.input).read_text()
    out = convert(text)
    if args.output:
        Path(args.output).parent.mkdir(parents=True, exist_ok=True)
        Path(args.output).write_text(out)
    else:
        print(out)


if __name__ == "__main__":
    main()
