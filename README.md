# Jumpy Goat Task Manager

A Claude Code skill for structured task management. Break down goals into actionable task lists and execute them incrementally with AI assistance.

## Why Use This?

Most AI interactions are one-shot: you ask, it answers, done. But real work is iterative — feature builds, marketing campaigns, sales processes, research projects all require multiple steps, context preservation, and checkpoints.

This skill brings structure to AI-assisted work:

- **Break down goals** into parent tasks and sub-tasks
- **Execute incrementally** in small logical chunks, pausing before risky or ambiguous actions
- **Review Git commits** and capture important findings as focused follow-up tasks
- **Track progress** with markdown task lists you can review and share
- **Archive completed work** for future reference
- **Preserve shared language** in `glossary.md` and only significant user-facing/architectural highlights in `tasks/changelog.md`

Works for any domain: engineering, marketing, GTM, sales, operations, research, content creation.

## Prerequisites

- [Claude Code](https://claude.ai/download) installed
- Anthropic API key configured (or Claude Max subscription)

## Installation

### Global (recommended) — available in every repo

```bash
mkdir -p ~/.claude/skills
cp -r /path/to/jumpy-goat-skill ~/.claude/skills/
```

### Per-project — only available in this repo

Copy the `jumpy-goat-skill` folder into your project's `.claude/skills/` directory:

```
your-project/
├── .claude/
│   └── skills/
│       └── jumpy-goat-skill/
│           ├── SKILL.md
│           └── resources/
│               ├── how-to-create-task-list.md
│               ├── how-to-work-task-list.md
│               ├── how-to-review-commit.md
│               └── how-to-maintain-project-memory.md
├── glossary.md
├── tasks/
│   ├── todo/
│   ├── done/
│   └── changelog.md
└── ...
```

## Folder Structure

Create the task folders in your project root:

```bash
mkdir -p tasks/todo tasks/done
```

- **`glossary.md`** - Shared project language, domain terms, and naming conventions
- **`/tasks/todo`** - Active task lists live here (e.g., `tasks-launch-campaign.md`)
- **`/tasks/done`** - Completed task lists are archived here with date prefix (e.g., `2024-01-15_tasks-launch-campaign.md`)
- **`/tasks/changelog.md`** - Highly selective highlights of significant implemented user-facing or major architectural changes; not a task history or decision journal

## Quick Start

### 1. Create a Task List

Start with a brain dump or brief. Create a file in `/tasks/todo/`:

```markdown
# tasks/todo/tasks-product-launch.md

We need to launch the new product next month. Target audience is SMBs.
Need landing page, email sequence, social posts, and sales deck.
Budget is limited so focus on organic channels first.
```

Then tell Claude:

> "Create a task list from @tasks/todo/tasks-product-launch.md"

Claude will:
1. Read `glossary.md` if present
2. Ask six short clarifying questions, one at a time, building on each answer
3. Create parent tasks and actionable sub-tasks without a separate approval step unless the plan is high-risk or uncertain
4. Save the structured task list

### 2. Work Through Tasks

Tell Claude:

> "Let's work on @tasks/todo/tasks-product-launch.md"

Claude will:
1. Pick up the next logical chunk, usually 1-3 related sub-tasks
2. Execute it (or guide you through it)
3. Update task status and record decisions or blockers
4. Pause before risky or ambiguous actions; wait after each sub-task if you request one-at-a-time execution

### 3. Complete and Archive

When all tasks are done, Claude will prompt:

> "All tasks complete! Ready to move files to done folder? (y/n)"

Say "y" and the file moves to `/tasks/done/2024-01-15_tasks-product-launch.md` with a short completion summary. The agent also attempts a Git commit for the finalized work unless you opt out, staging only intentionally touched files. Archiving does not require a changelog entry; the dated task archive already preserves the work history.

### Review a Commit

> "Review HEAD and create follow-up tasks for important findings."

Claude inspects the requested commit (or `HEAD`), reports evidence-backed findings, and creates a focused list in `tasks/todo/` only when warranted. Commit reviews skip the six-question planning flow and do not modify implementation code.

## Tips

- **Be messy in your brief** - Brain dumps are fine. Claude will ask clarifying questions and structure it for you.
- **Use the clarification flow** - Each of the six questions sharpens boundaries, architecture, or assumptions before planning.
- **Add context as you go** - If requirements change mid-task, just tell Claude. It will update the task list.
- **Name things once** - If a term matters, add it to `glossary.md` so future sessions reuse it.
- **Keep the changelog selective** - Default to no entry. Only significant implemented user-facing or architectural changes deserve one short dated sentence; task links are optional. Keep decisions, investigations, tests, and routine work in task lists or owning docs. See `resources/how-to-maintain-project-memory.md` for the significance gate.
- **Choose your pace** - Ask for one-at-a-time execution for approval after each sub-task, or batch mode for larger related groups.
- **Reference files with @** - Use `@tasks/todo/tasks-xyz.md` to point Claude to specific task lists.
