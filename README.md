# Jumpy Goat Skills

Two [Agent Skills](https://agentskills.io/specification) for **Claude Code, Pi, and Codex**. No plugins, MCP servers, or runtime dependencies.

| Skill | Say | What it does |
| --- | --- | --- |
| `jumpy-goat-skill` | "create a task list", "work through tasks/todo/…", "unattended" | Turns a brief into a Markdown task list, executes it with proof and a done gate, then archives and commits. Also reviews commits into follow-up lists. |
| `jumpy-loop` | "jumpy loop" | Reviews a code change with one read-only reviewer from another model provider, in rounds, until it approves. |

Each skill works on its own. `jumpy-goat-skill` uses `jumpy-loop` for code review when it is installed and falls back to a plain subagent review otherwise.

## Install and update

One command installs both skills, and re-running it updates them to the latest `master`:

```bash
# Personal: every project on this machine
curl -fsSL https://raw.githubusercontent.com/nikoatwork/jumpyGoatSkill/master/install.sh | sh -s -- --global

# Project: commit the skills so every contributor gets them
curl -fsSL https://raw.githubusercontent.com/nikoatwork/jumpyGoatSkill/master/install.sh | sh -s -- --project .
git add .agents/skills .claude/skills && git commit -m "Update jumpy goat skills"
```

The script copies each skill to `.agents/skills/<name>` (read by Codex and Pi) and links it from `.claude/skills/<name>` (read by Claude Code). Each copy records its source commit in `.installed-from`. Options: `--ref <branch-or-tag>` pins a version; `--source <local-clone>` installs from a working copy.

If a project has committed copies and you also installed them personally, Claude Code prefers the personal copy. Re-run the project install to bring the committed copy up to date.

## Activate

Start the agent in the project you want to work on. Agents pick the skills from matching requests, or invoke them explicitly:

| Agent | Example |
| --- | --- |
| Claude Code | `/jumpy-goat-skill Create a task list for the product launch` |
| Pi | `/skill:jumpy-goat-skill Create a task list for the product launch` |
| Codex | `$jumpy-goat-skill Create a task list for the product launch` |

After installing or updating, start a new Claude Code session, run `/reload` in Pi, or restart Codex.

## Use

**Create a task list.** "Use jumpy-goat-skill to create a task list from tasks/todo/launch-brief.md." The agent reads `glossary.md` if present, asks up to six short questions one at a time (only those that would change the plan; none when the brief is clear), and saves `tasks/todo/tasks-[topic].md`.

**Execute.** "Work through tasks/todo/tasks-product-launch.md." The agent works in small chunks and pauses before risky actions. Ask for **one at a time** to approve each subtask, or say **unattended** to let it run to the end: it decides defaults itself, records them under `## Decisions`, and asks only when it cannot continue.

**Finish.** A list is finalized only after the done gate: every change has proof, required checks pass, code changes got the review their weight calls for (self-check for small ones, `jumpy-loop` for risky or large ones), and no blocker is open. The agent then adds a summary, moves the list to `tasks/done/YYYY-MM-DD_tasks-[topic].md`, commits the task's changes, and reports every decision it made for you. It never pushes unless asked.

**Review a commit.** "Use jumpy-goat-skill to review HEAD." Reports evidence-backed findings and creates a follow-up list only when warranted.

**Review loop.** "jumpy loop" before you merge a risky or large code change; agents also start it on their own for those, not for small fixes. Up to 3 rounds (5 for security or data-loss risks); findings are blocker, should, or nit; the agent fixes or pushes back with evidence.

## Project files

Paths are relative to the target project root. Existing repository instructions take precedence.

```text
your-project/
├── glossary.md          # Optional shared language
└── tasks/
    ├── todo/            # Active task lists
    ├── done/            # Dated completed lists
    └── changelog.md     # Optional, significant highlights only
```

## Agent documentation

- [Claude Code skills](https://code.claude.com/docs/en/skills)
- [Pi skills](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/skills.md)
- [Codex skills](https://developers.openai.com/codex/skills)
