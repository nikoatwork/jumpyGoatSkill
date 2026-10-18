---
name: jumpy-goat-skill
description: Create and work through structured task lists, review Git commits into actionable follow-up lists, and maintain project changelogs. Use for planning, todos, commit reviews, incremental execution, and task completion.
---

## Overview

A lightweight productivity system for turning goals into actionable task lists, executing them incrementally, and preserving project language/decisions in reusable docs.

## Agent Compatibility

Use the same skill in Claude Code, Pi, and Codex; no agent-specific tools, plugins, or API keys are required by the skill itself.

- Follow the host agent's system instructions, repository instructions (such as `AGENTS.md` or `CLAUDE.md`), permissions, and approval rules. This skill does not grant additional permissions.
- Use the host's available file-reading, editing, and shell tools; do not assume particular tool names or slash commands during execution.
- Resolve `resources/...` relative to this `SKILL.md`. Resolve sibling resource links relative to the resource file containing them.
- Resolve project files (`tasks/...`, `glossary.md`, `deep-dives/...`) relative to the target project root, never the installed skill directory or filesystem root. Follow the project's canonical locations when defined.
- Read the relevant resource before planning, executing, reviewing, or maintaining project language and highlights. Ask clarification questions in ordinary chat, one at a time for the planning flow; no special question tool is required.
- Perform writes and Git operations only when allowed by the host and user instructions. If blocked by sandboxing, permissions, or unavailable tools, report the blocker rather than claiming success.

## Voice

Be concise, direct, and action-oriented. Treat the user as the orchestrator. Ask when blocked or when assumptions could cause rework. Prefer doing over explaining.

## When to Use

- User wants to plan a project or goal
- User has a brief/objective to break into tasks
- User wants to work through an existing task list
- User wants to review a Git commit and capture important follow-up work
- User wants the agent to ask better planning questions before implementation
- User wants to capture or refine shared project language, glossary terms, or task history
- User mentions "task list", "todo", "glossary", "changelog", or working incrementally

## Resources

- `resources/how-to-create-task-list.md` - Instructions for generating task lists from goals or brief
- `resources/how-to-work-task-list.md` - Protocol for incremental execution and optional one-at-a-time checkpoints
- `resources/how-to-review-commit.md` - Review a Git commit and create a follow-up task list when warranted
- `resources/how-to-maintain-project-memory.md` - Protocol for shared language and the significance gate for changelog entries

## Quick Reference

**Creating:** Read `glossary.md` if present, then ask the 6-question sequential clarification flow from `resources/how-to-create-task-list.md` before creating a practical task list in `tasks/todo/`.

**Executing:** Work in small logical chunks, update task status, sharpen unclear language, and pause before risky or ambiguous actions.

**Commit review:** Inspect `HEAD` or a requested commit using `resources/how-to-review-commit.md`. Create a focused follow-up list only for findings important enough to track; skip the normal six-question planning flow unless blocked.

**Project memory:** Maintain `glossary.md` for shared language. Treat `tasks/changelog.md` as a highly selective highlights log, not task/decision history: only significant implemented user-facing changes or major architectural changes qualify. Default to no entry; keep routine work, investigations, decisions, and verification in the task list or owning docs.

**Completion:** Archive approved completed task lists to `tasks/done/` with a date prefix. Completion, archiving, or committing does not require a changelog entry. Apply the significance gate in `resources/how-to-maintain-project-memory.md`; qualifying entries are one short dated sentence with an optional task link.
