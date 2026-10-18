# Jumpy Goat Task Manager

One [Agent Skill](https://agentskills.io/specification) for **Claude Code, Pi, and Codex**. Break goals into actionable Markdown task lists, execute in small chunks, review Git commits, and archive completed work.

The same `SKILL.md` and resources work in all three agents. No plugins, MCP servers, or runtime dependencies are needed. Install and authenticate your chosen agent separately; Git is needed only for commit reviews and commits.

## Install

Clone this repository, then run the copy commands from its root:

```bash
git clone https://github.com/nikoatwork/jumpyGoatSkill.git jumpy-goat-skill
cd jumpy-goat-skill
```

Choose a location:

| Agent | Personal: all projects | Project: shared with the repo |
| --- | --- | --- |
| Claude Code | `~/.claude/skills/jumpy-goat-skill` | `.claude/skills/jumpy-goat-skill` |
| Pi | `~/.agents/skills/jumpy-goat-skill` | `.agents/skills/jumpy-goat-skill` |
| Codex | `~/.agents/skills/jumpy-goat-skill` | `.agents/skills/jumpy-goat-skill` |

Pi and Codex share the `.agents/skills` installation. Pi also supports its native `~/.pi/agent/skills/` and `.pi/skills/` directories; choose one location to avoid duplicate skill names.

### Personal installation

```bash
# Pi and Codex (one copy serves both):
target="$HOME/.agents/skills/jumpy-goat-skill"
mkdir -p "$target"
cp SKILL.md "$target/"
cp -R resources "$target/"

# Claude Code (skip if you don't use it):
target="$HOME/.claude/skills/jumpy-goat-skill"
mkdir -p "$target"
cp SKILL.md "$target/"
cp -R resources "$target/"
```

### Project installation

From this skill repository, set `project` to the project that should use it:

```bash
project="/absolute/path/to/your-project"

# Pi and Codex:
target="$project/.agents/skills/jumpy-goat-skill"
mkdir -p "$target"
cp SKILL.md "$target/"
cp -R resources "$target/"

# Claude Code (skip if you don't use it):
target="$project/.claude/skills/jumpy-goat-skill"
mkdir -p "$target"
cp SKILL.md "$target/"
cp -R resources "$target/"
```

These commands copy only the skill and its resources, not this repository's Git history. Re-run them after pulling updates. Avoid installing both personal and project copies unless you intentionally manage their precedence.

## Activate

Start the agent in the **project you want to work on**, not the installed skill directory. All three agents can select the skill automatically from a matching request. To invoke it explicitly:

| Agent | Example |
| --- | --- |
| Claude Code | `/jumpy-goat-skill Create a task list for the product launch` |
| Pi | `/skill:jumpy-goat-skill Create a task list for the product launch` |
| Codex | `$jumpy-goat-skill Create a task list for the product launch` |

After installation or updates, start a new Claude Code session, run `/reload` in Pi, or restart Codex if the skill does not appear. In Codex, `/skills` also opens the skill selector. These are chat inputs, not shell commands.

## Project Files

Project paths are relative to the **target project root**, never the skill installation or filesystem root. Existing repository instructions and canonical locations take precedence.

```text
your-project/
├── glossary.md                 # Optional shared language
└── tasks/
    ├── todo/                   # Active task lists
    ├── done/                   # Dated completed lists
    └── changelog.md            # Optional significant highlights only
```

Create folders as needed with `mkdir -p tasks/todo tasks/done`. Do not create a glossary or changelog unless there is useful content for it.

## Use

These plain-language requests work in any of the three agents; no `@` file-mention syntax is required.

### Create a task list

> Use jumpy-goat-skill to create a task list from tasks/todo/launch-brief.md.

Start with a brief or a messy brain dump. The agent reads `glossary.md` if present, asks **six short questions one at a time**, and saves parent tasks and executable subtasks in `tasks/todo/tasks-[topic].md`. A separate parent-task approval step is needed only for high-risk or uncertain plans.

### Execute tasks

> Use jumpy-goat-skill to work through tasks/todo/tasks-product-launch.md.

The agent works in small logical chunks, usually 1–3 related subtasks, updates status, records decisions or blockers, and pauses before risky or ambiguous actions. Ask for **one-at-a-time execution** to approve each subtask, or **batch mode** for larger groups. Host permissions and approval rules always apply.

### Complete and archive

Once the work is complete, the agent asks before archiving. With approval, it adds a short summary and moves the list to `tasks/done/YYYY-MM-DD_tasks-[topic].md`.

It attempts a Git commit only when host/repository instructions allow it and you have not opted out, staging only intentionally touched files. It reports blocked operations and does not push unless you request it. Completion and archiving do not require a changelog entry.

### Review a commit

> Use jumpy-goat-skill to review HEAD and create follow-up tasks for important findings.

Specify a commit instead of `HEAD` when needed. The agent reports evidence-backed findings and creates a focused follow-up list only when warranted. Reviews skip the six-question planning flow and do not modify implementation code.

### Preserve useful context

- **`glossary.md`:** reusable terms, naming conventions, and shared project language.
- **Task lists and owning docs:** progress, decisions, tradeoffs, and verification.
- **`tasks/changelog.md`:** only significant implemented user-facing or major architectural changes. Default to no entry; qualifying entries are one short dated sentence.

## Skill Resources

- [Create task lists](resources/how-to-create-task-list.md)
- [Execute and archive tasks](resources/how-to-work-task-list.md)
- [Review a commit](resources/how-to-review-commit.md)
- [Maintain project language and highlights](resources/how-to-maintain-project-memory.md)

## Agent Documentation

- [Claude Code skills](https://code.claude.com/docs/en/skills)
- [Pi skills](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/skills.md)
- [Codex skills](https://developers.openai.com/codex/skills)
