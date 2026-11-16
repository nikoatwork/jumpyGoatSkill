---
description: Guidelines for working through task lists to track progress
globs:
alwaysApply: false
---
# Working Through Task Lists

## Execution Modes

- **Default:** Work the next logical chunk, usually 1-3 related subtasks. Update the task file as you go. Pause before destructive, irreversible, expensive, or ambiguous actions.
- **One at a time:** When the user asks, complete one subtask and wait.
- **Unattended:** When the user says they are away or asks you to finish without them ("unattended", "full send", "finish it"), work every remaining subtask through the done gate and finalize without pausing. See [Unattended](#unattended).

In every mode, read `glossary.md` if present before changing names, workflows, or user-facing concepts. Sharpen fuzzy language as it appears.

## Scope

Fix the case that happened, not every case that could. Make the smallest change that meets the brief. Add new ideas outside the brief as follow-up tasks instead of doing them.

## Proof

Proof is evidence you observed in this session: command output, a reproduction, a screenshot. Use the most direct proof the change allows:

- Reproduce the failure, apply the fix, and watch the same reproduction pass.
- Run the checks the project names for the changed behavior.
- Add one focused test that fails without the fix, when the behavior has no test and the project has a test setup.
- For UI and runtime behavior, run it and look. Green mocked tests do not prove the experience works.

Record one `Proof:` line under each completed parent task. Without proof, the task is not done.

## Review

Size the review to the change (see "Match Effort to the Job" in `SKILL.md`):

- **Light and medium code changes:** reread the full diff against the intent yourself before finalizing, fix what you find, and say you did. No subagent.
- **Heavy code changes** (security, sign-in or permissions, data loss or migrations, money, concurrency, shared calculations, or a large diff): get an independent, read-only review and fix or decline each finding with a reason. Use the `jumpy-loop` skill when it is installed. Otherwise, brief a fresh subagent (ideally another provider's model) to review the diff against the intent and report bugs, broken callers, and unneeded code. Without subagents, reread the full diff yourself and say so.
- **Any size, on request:** when the user asks for a review or a loop, run it.

Skip review for docs-only, task-list-only, and formatting-only changes.

## Done Gate

Finalize only when all of these are true:

- Every required subtask is `[x]`, or `[~]` with a reason.
- Proof covers every change in the diff.
- The checks the project requires pass, or pre-existing failures are recorded.
- The review the change's weight calls for is done, and its findings are fixed or declined with a reason (code changes).
- No blocker is open.
- `Relevant Files` matches what actually changed.

Never mark unfinished validation complete just to pass the gate.

## Unattended

The user is not reading progress messages, and a question in an ordinary message makes the thread look finished.

- Ask only when you cannot continue alone: you cannot prove a change, the next step deletes data, touches production, or changes things outside the project, or the goal is ambiguous in a way that changes the result.
- Ask with the host's question tool when it has one. Include the task file, the blocker, and the options with your recommendation first. Without one, stop and put the question first in your final message.
- Decide everything else with sensible defaults. Record each decision under `## Decisions` in the task list.
- Keep working until the list is finalized or a question is pending. Wait for running checks instead of ending your turn.
- Unattended mode grants no extra permissions. Host approval rules still apply.

## Task Marking

| Marker | Meaning | When to use |
|--------|---------|-------------|
| `[ ]` | Pending | Not started |
| `[x]` | Complete | Fully done |
| `[~]` | Skipped | Not needed; include reason |
| `[/]` | Partial | In progress; note remaining work |

```markdown
- [x] 2.0 Fix duplicate invoice emails
  - Proof: reproduced two sends with `npm test -- invoices`; after the fix the same test sends one.
  - [x] 2.1 Add idempotency key to the send job
  - [~] 2.2 Rework retry queue - Skipped: not needed for this bug
  - [/] 2.3 Update docs (setup done, API page left)
```

## Maintenance Rules

1. Mark completed subtasks immediately.
2. Mark a parent `[x]` when all subtasks are `[x]` or `[~]` and its proof is recorded.
3. Add newly discovered work to the task list.
4. Keep `Relevant Files` current when files are created or modified.
5. Log blockers in `## Blockers`, then continue with unblocked work.
6. Update `glossary.md` when the work introduces or clarifies reusable project language.
7. Keep progress, decisions, scope changes, tradeoffs, and verification in the task list or owning docs. Update `tasks/changelog.md` only for significant implemented user-facing or major architectural changes that pass the gate in `how-to-maintain-project-memory.md`; default to no entry. Use a different canonical changelog if the project names one; do not create duplicates.

## Completion

When the done gate passes, finalize, archive, and commit in the same turn unless the user opted out. Do not ask for separate archive or commit approval.

1. Add a short completion summary near the top of the file: what changed, proof, decisions made for the user, and anything skipped or deferred.
2. Update `glossary.md` with any durable language discovered during the work.
3. Apply the changelog significance gate in `how-to-maintain-project-memory.md`. Completion or archiving alone does not qualify. Mark boilerplate changelog subtasks skipped when the gate is not met.
4. Move the list from `tasks/todo/tasks-[topic].md` to `tasks/done/YYYY-MM-DD_tasks-[topic].md`.
5. Commit when inside a git repo and host and repository instructions allow it. Stage only the task's implementation, tests, docs, and archived list; preserve unrelated changes. A commit does not authorize a push or release.
6. Report the archive path, the commit hash or the exact blocker, and every decision you made on the user's behalf.

If a `deep-dives/[topic]/` folder exists, leave it in place.

## Error Handling

- If archiving or committing fails, keep the original file and report the exact error.
- If uncertain whether the work is complete, ask the user to verify.
