---
name: jumpy-goat-skill
description: Create and work through structured task lists, attended or unattended, with proof and a done gate before archiving; review Git commits into follow-up lists; maintain project changelogs. Use for planning, todos, commit reviews, incremental or unattended execution, and task completion.
---

## Overview

A lightweight productivity system for turning goals into actionable task lists, executing them incrementally, and preserving project language/decisions in reusable docs.

## Agent Compatibility

Use the same skill in Claude Code, Pi, and Codex; no agent-specific tools, plugins, or API keys are required by the skill itself.

- Follow the host agent's system instructions, repository instructions (such as `AGENTS.md` or `CLAUDE.md`), permissions, and approval rules. This skill does not grant additional permissions.
- Use the host's available file-reading, editing, and shell tools; do not assume particular tool names or slash commands during execution.
- Resolve `resources/...` relative to this `SKILL.md`. Resolve sibling resource links relative to the resource file containing them.
- Resolve project files (`tasks/...`, `glossary.md`, `deep-dives/...`) relative to the target project root, never the installed skill directory or filesystem root. Follow the project's canonical locations when defined.
- Read the relevant resource before planning, executing, reviewing, or maintaining project language and highlights. Ask clarification questions in ordinary chat, one at a time for the planning flow. In unattended mode, use the host's question tool when it has one.
- Perform writes and Git operations only when allowed by the host and user instructions. If blocked by sandboxing, permissions, or unavailable tools, report the blocker rather than claiming success.

## Voice

Be concise, direct, and action-oriented. Treat the user as the orchestrator. Ask when blocked or when assumptions could cause rework. Prefer doing over explaining.

## Match Effort to the Job

Size the process to the change, not the other way round. Most work is small; treat it as small.

- **Light** (a typo, a docs or copy tweak, a small fix in one place, low risk): just do it. No task list, no clarifying round, no review subagent. Run the project's checks and reread your own diff.
- **Medium** (several steps or files, ordinary risk): a task list if it helps to track the steps. Ask only what you cannot find out yourself. Reread the full diff against the intent before finishing, and say you did.
- **Heavy** (security, sign-in or permissions, data loss or migrations, money, concurrency, shared calculations many features rely on, or a large diff): the full flow. Clarify the plan, record proof per parent task, and get an independent review with `jumpy-loop`.

When in doubt, pick the lighter level and step up as soon as a risk shows. The user can always ask for more ("jumpy loop", "full review") or less. A project can set its own thresholds in `AGENTS.md` or `CLAUDE.md`; those win.

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
- `resources/how-to-work-task-list.md` - Execution modes (default, one at a time, unattended), scope, proof, review, done gate, and completion
- `resources/how-to-review-commit.md` - Review a Git commit and create a follow-up task list when warranted
- `resources/how-to-maintain-project-memory.md` - Protocol for shared language and the significance gate for changelog entries

## Quick Reference

**Creating:** Read `glossary.md` if present, then ask up to six clarifying questions, one at a time, only where the answer would change the plan (none when the brief is clear), and create a practical task list in `tasks/todo/` (see `resources/how-to-create-task-list.md`).

**Executing:** Work in small logical chunks, update task status, and pause before risky or ambiguous actions. One at a time on request. **Unattended** ("unattended", "full send", "finish it"): run to the done gate and finalize, deciding defaults yourself and asking only through the host's question tool. Fix the case that happened, not every case that could. Record proof per parent task; review code changes in proportion to their weight before finalizing (see Match Effort to the Job).

**Commit review:** Inspect `HEAD` or a requested commit using `resources/how-to-review-commit.md`. Create a focused follow-up list only for findings important enough to track; skip the normal six-question planning flow unless blocked.

**Project memory:** Maintain `glossary.md` for shared language. Treat `tasks/changelog.md` as a highly selective highlights log, not task/decision history: only significant implemented user-facing changes or major architectural changes qualify. Default to no entry; keep routine work, investigations, decisions, and verification in the task list or owning docs.

**Completion:** When the done gate passes, finalize, archive to `tasks/done/` with a date prefix, and commit the task's scoped changes in the same turn unless the user opted out. Report the commit hash and every decision made on the user's behalf. Completion, archiving, or committing does not require a changelog entry; apply the significance gate in `resources/how-to-maintain-project-memory.md`.
