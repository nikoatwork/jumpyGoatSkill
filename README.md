# Jumpy Goat Task Manager

A simple way to break big goals into small steps. Then work through them one at a time with Claude's help.

## What's This For?

You know how AI chats are usually one-and-done? Ask a question, get an answer, move on.

But real work isn't like that. Projects have multiple steps. You need to keep track of progress. Sometimes you want to pause and review before continuing.

That's what this does:

- **Break down goals** into bite-sized tasks
- **Work through them** one step at a time
- **Track your progress** in simple markdown files
- **Archive finished work** so you can reference it later

Works for anything: marketing campaigns, content creation, research projects, you name it.

## What You'll Need

1. **Claude Code** - Download it from [claude.ai/download](https://claude.ai/download)
2. **An API key** - Either an Anthropic API key or a Claude Max subscription

Don't have Claude Code yet? No worries. Install it first, then come back here.

## How to Install

### Step 1: Find your project folder

Open your project in Claude Code. Or create a new folder for it.

### Step 2: Create the skills folder

In your terminal (inside Claude Code), run:

```bash
mkdir -p .claude/skills
```

This creates a hidden folder where skills live. The `-p` flag just means "create parent folders if needed."

### Step 3: Copy this skill into that folder

If you downloaded this repo, copy the whole `jumpy-goat-skill` folder:

```bash
cp -r /path/to/jumpy-goat-skill .claude/skills/
```

Replace `/path/to/` with wherever you saved it.

Your folder structure should look like this:

```
your-project/
├── .claude/
│   └── skills/
│       └── jumpy-goat-skill/
│           ├── SKILL.md
│           └── resources/
│               ├── how-to-create-task-list.md
│               └── how-to-work-task-list.md
├── todo/
├── done/
└── ... your other files
```

### Step 4: Create folders for your task lists

```bash
mkdir todo done
```

- **todo/** - Where active task lists live
- **done/** - Where completed ones get archived

That's it. You're set up.

## How to Use It

### Creating a Task List

Start with a brain dump. Just write down what you're trying to do. Messy is fine.

Save it in your `todo/` folder. Something like `todo/tasks-my-project.md`.

Then tell Claude:

> "Create a task list from @todo/tasks-my-project.md"

Claude will:
1. Ask a few clarifying questions
2. Show you the main tasks (you say "Go" when ready)
3. Break those into smaller sub-tasks
4. Save everything nice and organized

### Working Through Tasks

When you're ready to start doing the work:

> "Let's work on @todo/tasks-my-project.md"

Claude will:
1. Pick up the next task
2. Help you do it (or do it for you)
3. Mark it done
4. Wait for you to say "y" before moving on

That pause is intentional. Gives you a chance to review before continuing.

### When You're Done

Once all tasks are complete, Claude will ask if you want to archive it.

Say "y" and it moves to your `done/` folder with the date. Nice and tidy.

## Tips

- **Don't overthink the brain dump.** Just write what's in your head. Claude will help organize it.
- **Review the main tasks before saying "Go."** That's your chance to adjust scope.
- **Use the pauses.** The "wait for y" thing keeps you in control.
- **Point to files with @** - Like `@todo/tasks-xyz.md`. Makes it easy for Claude to find them.

## Questions?

Open an issue on GitHub. Happy to help.
