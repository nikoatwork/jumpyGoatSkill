---
description: Guidelines for working through task lists to track progress
globs:
alwaysApply: false
---
# Working Through Task Lists

## Execution Protocol

### Default Mode (One at a time)
- **One sub-task at a time:** Do NOT start the next sub-task until user says "yes" or "y"
- Stop after each sub-task and wait for go-ahead

### Batch Mode
If user says "batch", "do a few", or similar:
- Execute 2-3 related sub-tasks before pausing
- Summarize what was done and pause for approval
- Return to default mode after batch completes

## Task Marking

### Completion States

| Marker | Meaning | When to use |
|--------|---------|-------------|
| `[ ]` | Pending | Not started |
| `[x]` | Complete | Fully done |
| `[~]` | Skipped | Not needed, with reason |
| `[/]` | Partial | In progress, needs more work |

### Examples
```markdown
- [x] 2.1 Write landing page copy
- [~] 2.2 Create video script - Skipped: using existing video instead
- [/] 2.3 Design email sequence (3 of 5 emails done)
- [ ] 2.4 Set up tracking
```

### Marking Rules
1. When you finish a sub-task, immediately mark it `[x]`
2. When ALL sub-tasks under a parent are `[x]` or `[~]`, mark the parent `[x]`
3. When skipping, always add reason after the dash: `[~] Task - Reason`
4. For partial completion, note progress in parentheses

## Blockers Log

When you encounter a blocker during execution, add it to a `### Blockers` section under Notes:

```markdown
### Blockers

- **2024-01-15:** Waiting on API credentials from Sarah
- **2024-01-16:** Design assets not ready, proceeding with placeholder
```

Continue with other tasks if possible. Return to blocked tasks when resolved.

## Maintenance

1. **Update as you work:**
   - Mark tasks complete per protocol above
   - Add new tasks as they emerge
   - Log blockers when encountered

2. **Keep "Relevant Files" current:**
   - List every file created or modified
   - One-line description for each

## Finalization

### Detecting Completion

After marking any task complete:

1. **Count status:** Total parent tasks vs completed parent tasks
2. **Check for 100%:** If all parent tasks are `[x]`, trigger finalization
3. **Ask user:** "Should we finalize this task list? Seems like we've done all tasks."

### Finalization Workflow

When user confirms (responds "y" or "yes"):

1. **Add TL;DR to Context section:**

   At the end of the `# Context` section, add:
   ```markdown
   ## TL;DR

   **Completed:** [Date]

   **What we did:**
   - [1-3 bullet summary of main accomplishments]

   **What changed along the way:**
   - [Any scope changes, pivots, or discoveries]

   **Skipped/Deferred:**
   - [Any tasks skipped and why, or "None"]
   ```

2. **Add metadata** to top of file:
   ```markdown
   ---
   STATUS: COMPLETED
   COMPLETED_DATE: 2024-01-15
   TOPIC: [topic-name]
   ---
   ```

3. **Move file:**
   - From: `/todo/tasks-[topic].md`
   - To: `/done/YYYY-MM-DD_tasks-[topic].md`

4. **Confirm:** "Completed on [date]. Files moved to done folder."

## Working Instructions

1. **Before starting:** Check which sub-task is next
2. **After each sub-task:** Update file, pause for approval (unless batch mode)
3. **When blocked:** Log blocker, move to next unblocked task
4. **When skipping:** Mark `[~]` with reason, continue
5. **After marking complete:** Check if ALL parent tasks are now `[x]`
6. **New requirements:** Add to task list and continue workflow

## Error Handling

- If file movement fails, keep originals and report error
- If user declines finalization, continue normal workflow
- If uncertain about completion, ask user to verify
