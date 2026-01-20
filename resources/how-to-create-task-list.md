---
description: Instructions for generating structured task lists from briefs
globs:
alwaysApply: false
---
# Creating Task Lists

## Purpose

Generate a detailed, step-by-step task list in Markdown format from a brief. Briefs are often brain dumps or unstructured notes that need to be transformed into actionable task lists. The output guides execution while keeping desired outcomes front and center.

## Output

- **Format:** Markdown (`.md`)
- **Location:** `/todo/` folder in project root
- **Filename:** `tasks-[topic].md` (e.g., `tasks-launch-campaign.md`)

## Process

1. **Receive Brief:** User points to a tasks file containing the brief at the top
2. **Analyze Brief:** Read and understand the desired outcome
3. **Ask Clarifying Questions:** Ask 1-3 clarifying questions to fill gaps, resolve ambiguities, or confirm assumptions in the brief. Wait for user response before proceeding.
4. **Create Context Section:** Write or edit the `# Context` section to preserve the original brief/brain dump. If the content exceeds ~500 words, summarize it while retaining key details, constraints, and requirements.
5. **Phase 1 - Parent Tasks:** Generate 4-6 high-level tasks required to achieve the brief's objective. Present these to the user and say: "I have generated the high-level tasks. Ready to generate sub-tasks? Respond with 'Go' to proceed."
6. **Wait for Confirmation:** Pause until user responds "Go"
7. **Phase 2 - Sub-Tasks:** Break each parent task into smaller, actionable sub-tasks. Include a **clarifying question** as the first sub-task of each parent (see below)
8. **Identify Relevant Files:** List files/assets that will be created or modified
9. **Save:** Save to `/todo/tasks-[topic].md`

## Output Format

```markdown
# Context

[Original brief/brain dump content. If exceeds ~500 words, summarize while preserving key details, constraints, requirements, and any specific instructions from the user.]

## Brief

[1-3 sentence description of the objective and desired outcome]

## Relevant Files

- `path/to/file.md` - Brief description of purpose
- `path/to/asset.png` - Brief description of purpose

### Notes

- Any context, constraints, or dependencies
- Tools or commands relevant to execution

## Tasks

- [ ] 1.0 Parent Task Title
  - [ ] 1.1 **Clarify:** [Short question about the critical element]?
  - [ ] 1.2 Sub-task description
  - [ ] 1.3 Sub-task description
- [ ] 2.0 Parent Task Title
  - [ ] 2.1 **Clarify:** [Short question]?
  - [ ] 2.2 Sub-task description
- [ ] 3.0 Parent Task Title
  - [ ] 3.1 **Clarify:** [Short question]?
```

## Clarifying Questions

Each parent task should have a **Clarify** sub-task as its first item. This ensures the orchestrator maintains control and the executing agent doesn't misinterpret intent.

**Purpose:** Reduce risk of wrong execution by surfacing the most critical assumption or decision point.

**Guidelines:**
- Keep it short (one sentence)
- Be unbiased - don't lead toward an answer
- Focus on the element most likely to cause wrong execution
- Ask about outcomes, not implementation

**Examples:**

| Task | Bad Question | Good Question |
|------|--------------|---------------|
| Write landing page | Should I use a modern design? | What action should visitors take? |
| Set up email sequence | Want me to use Mailchimp? | How many emails, and what's the goal of each? |
| Create sales deck | Should it be 10 slides? | Who's the audience and what's the ask? |

## Interaction Model

1. **After analyzing the brief:** Ask 1-3 clarifying questions to address gaps or ambiguities. Wait for answers before proceeding.
2. **After generating parent tasks:** Pause for user confirmation before adding sub-tasks. This ensures alignment before diving into details.
3. **During execution:** The Clarify sub-task is answered before other sub-tasks begin.

## Target Audience

Assume the reader needs clear, actionable steps without assumed context.
