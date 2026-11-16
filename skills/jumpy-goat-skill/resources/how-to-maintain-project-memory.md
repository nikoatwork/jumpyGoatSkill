---
description: Protocol for shared project language and a highly selective changelog
alwaysApply: false
---
# Maintaining Project Memory

## Purpose

Preserve reusable project understanding while working through tasks, without adding heavy process.

Use these project-relative files for distinct purposes:

- `glossary.md` — shared language, domain terms, repo-specific concepts, naming conventions, and non-obvious meanings.
- `tasks/changelog.md` — a highly selective, comprehensible log of significant implemented user-facing changes and major architectural changes, not an activity journal.

Task lists own progress, investigations, decisions, tradeoffs, and verification evidence. Dated archives under `tasks/done/` preserve detailed work history without a matching changelog entry.

Do not use `context.md` for this protocol. Prefer `glossary.md`.

## When to Read

At the start of task planning or execution:

1. Read `glossary.md` if it exists.
2. Read `tasks/changelog.md` if it exists and recent history may affect the work.
3. Use these docs to avoid re-asking already answered questions.

If the files do not exist, proceed normally. Create the glossary only for reusable language and the changelog only for a change that passes the significance gate below.

## Asking the Right Questions

Ask questions when the answer would change implementation, naming, task structure, or user-facing behavior.

Prioritize questions about:

- **Terms:** "What should we call this concept?" / "Is there already a name for this?"
- **Boundaries:** "Is X part of Y, or separate?"
- **Cardinality:** "Can one X have many Y? Can Y exist without X?"
- **Status/lifecycle:** "What states can this move through? Are transitions enforced or manual?"
- **Ownership/source of truth:** "Which file/system owns this?"
- **Reversibility:** "Is this easy to change later, or should we document the tradeoff?"
- **User-visible language:** "Will users see this term, or is it internal only?"

Keep questions batched and concise. Ask up to 3 at a time unless the user asks for a deeper grilling session.

## Updating `glossary.md`

Update the glossary when:

- A new reusable term is introduced.
- A fuzzy term is clarified.
- The user corrects naming or says "there's already a term for that."
- A term affects filenames, APIs, UI labels, content workflow, or future agent behavior.

Suggested format:

```markdown
# Glossary

Shared language for this project.

## Terms

### Term Name

Definition in plain language.

- **Use when:** When this term should be used.
- **Do not use for:** Nearby concepts this should not mean.
- **Notes:** Optional implementation, naming, or workflow notes.
```

Keep entries short. Prefer useful clarity over exhaustive documentation.

## Updating `tasks/changelog.md`

### Significance gate

Default to **no entry**. Add one only when implemented work:

- Substantially changes what users (including admins/moderators) can do or experience, such as a major workflow or capability; or
- Materially changes system architecture, such as service boundaries, data ownership, or the core execution model.

Ask: would someone skimming the repository's most important changes months later need this highlight? If unclear, omit it. Task completion, archiving, committing, or deployment alone never qualifies. A task's boilerplate instruction to update the changelog does not bypass this gate; mark it skipped when no qualifying change occurred, unless the user explicitly requests that entry.

Exclude planning/replanning, investigations, accepted tradeoffs, routine fixes/refactors, minor copy or policy tweaks, tests, tooling, documentation cleanup, operational checks, and incremental progress unless their actual impact independently meets the gate. Keep that detail in the task list or owning docs.

### Entry format

- One short dated sentence per significant outcome, newest first; aim for at most 30 words excluding an optional link.
- Describe what materially changed and why it matters, not the work performed.
- Consolidate related work into one highlight; do not log every implementation step or rollout check.
- Link to the implementing task only when it adds useful context. Links are optional; dated `tasks/done/` archives already provide traceability.
- No test counts, command transcripts, deployment IDs, sample statistics, commit status, or lists of things not changed.
- Use the project's canonical changelog and existing format; do not create a duplicate. Do not rewrite historical entries unless asked.

Example:

```markdown
# Changelog

Significant user-facing and architectural changes, newest first.

- 2026-05-17 — Moderators can now review and approve scheduling suggestions before they affect group meetings.
- 2026-05-10 — Separated message delivery from workflow orchestration, allowing each service to operate independently.
```

## During Execution

When a term or decision emerges:

1. Pause only if the ambiguity can cause rework.
2. Ask the smallest useful question.
3. Apply the answer to the task.
4. Update `glossary.md` for reusable language and the task list or owning docs for decisions. Update the changelog only when implemented impact passes the significance gate.

## Completion Checklist

Before archiving a completed task list:

- Task file statuses are current.
- `glossary.md` includes any new durable terms.
- The changelog significance gate was applied; leaving it unchanged is the normal result for routine work.
- The user has approved archiving when required by the execution protocol.
