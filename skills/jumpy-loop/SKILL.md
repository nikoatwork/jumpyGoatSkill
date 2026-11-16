---
name: jumpy-loop
description: Review a code change in a loop with one independent, read-only reviewer from another model provider until it approves or the round budget ends. Use when the user says "jumpy loop" or asks for a review loop, or before finalizing a code change.
---

# Jumpy Loop

Make a change more correct with the smallest possible edits. One reviewer, a few rounds, no scope creep. Push back on findings you disagree with. This skill grants no extra permissions and never pushes, opens PRs, or comments unless the user asks.

## Reviewer

- Use one strong model from a different provider than your own, at high effort, unless the user names one. Example: GPT Sol when you are Claude, Claude Opus when you are GPT. Pick the newest model of that family the host lists; never hardcode a version.
- Start it with the host's delegation or subagent tool. In T3 Code: `orchestrator_capabilities`, then `delegate_task` with `role: "review"`. Start a new request every round with the full brief; the reviewer has no history.
- If no other provider is available, use a fresh subagent of your own model and say so. If the host has no subagents, report that instead of calling a self-review a loop.
- Do not edit the scoped files while the reviewer runs. A timeout, error, or empty reply is not approval.

## Budget

- 3 rounds. Round 1 reviews the full change; later rounds cover only changed code and open findings.
- Up to 5 rounds for security, auth, permissions, data loss, or concurrency while a blocker or should is open with evidence, or when the user asks.
- Stop early when only nits remain. Fixes to comments, docs, or formatting need no new round.

## 1. Scope

- Run `git status --short`. Do not stash, discard, or include unrelated changes. Limit the review to the change's paths; if they do not separate cleanly, ask.
- Base: after `git fetch`, `git merge-base HEAD origin/<default-branch>`; or a base the user names; or `HEAD` for uncommitted changes only. The change is base to working tree, including untracked files. Use the same diff command every round.
- Run the checks that cover the change first. Note missing or already-failing checks in the brief.

## 2. Brief

```text
Review only. Do not edit, commit, push, comment, or start subagents.
Repo: <abs path>  Base: <sha>
Intent: <1-2 sentences>  Out of scope: <...>  Checks: <results>
Diff: git diff <base> [-- <paths>]; git status --short (read untracked files).
Read surrounding code. Find bugs, broken callers, and mismatches with the intent.
Skip style unless it hides a bug. Flag code, tests, or guards the intent does not need.
blocker = the intended case is wrong. should = a real bug callers will hit. nit = everything else.
Reply:
VERDICT: APPROVE or CHANGES
R1 [blocker|should|nit] <file>:<line> <claim>. Fix: <suggestion>
```

From round 2, add the ledger (`fixed` / `disagree` / `declined`, each with evidence) and the changes since the last round. Ask the reviewer to mark each old id `resolved` or `still open: <reason>`.

## 3. Answer Findings

Check each finding and its severity yourself. Another path, a rare case, or a small cost is a nit, whatever its label.

- **Agree:** make the smallest fix. Prefer deleting or narrowing over adding helpers, options, caches, or locks. Add one focused test only if the intent needs it.
- **Disagree:** say why, with evidence (file:line, test, output).
- **Nit or out of scope:** decline in one line and list it as a follow-up.

Keep a ledger: id, severity, outcome. Re-run the checks. If the diff grew, cut first. Never agree just to end the loop.

## 4. Stop

- **Approved:** APPROVE on the current diff, no blocker or should open, and no concern of your own.
- **Stuck:** an item is still disputed after two replies, or the budget ran out. Show both sides in 2-3 lines each and let the user decide. Running out of budget is not approval.

Report in your reply: rounds, reviewer model, what changed, diff size before and after, and fixed and declined findings with reasons. Do not put review results or model names in commits, tags, or PR text.
