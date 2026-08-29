---
name: commitskillsh
description: >
  Git commit message assistant for CLI programming workflows. Trigger this skill whenever the user invokes /commitskillsh, says "commit", "commit text only", "what should I commit", "give me a commit message", "suggest commit", or "ready to commit". The skill reads git history and staged changes to generate a conventional-commit message — never committing until the user approves. Also handles in-session commands: "regenerate" (new message), "shorter", "longer", "accept", "commit and push". Use this skill any time the user is working in a terminal/CLI context and wants help crafting, reviewing, or approving a git commit message.
---

# /commitskillsh — Git Commit Text Assistant

## Purpose

Help the user craft a high-quality `git commit -m "…"` message by:
1. Inspecting the **full git commit history** to learn the project's commit style and conventions.
2. Inspecting the **current staged diff** to understand what changed.
3. Proposing **commit text only** — no commit is made yet.
4. Waiting for explicit approval before running `git commit && git push`.

---

## Trigger

Invoked when the user types `/commitskillsh` **or** says any of:
- `commit`
- `commit text only`
- `what should I commit`
- `give me a commit message`
- `suggest commit`
- `ready to commit`
- `commit with ai {name}` → activates **AI-Assisted Commit Mode** (see Parameters)

---

## Parameters

### `commit with ai {name}` — AI-Assisted Commit Mode

When the user says **`commit with ai {name}`** (e.g. `commit with ai gpt`, `commit with ai gemini`, `commit with ai claude`):

1. **Read `Ai-commit.md`** from the project root:
   ```bash
   cat Ai-commit.md
   ```
   This file contains instructions, rules, or a custom prompt template that the named AI model should follow when generating the commit message (e.g. tone, format overrides, domain-specific conventions).

2. **Read `Ai-list.md`** from the project root:
   ```bash
   cat Ai-list.md
   ```
   This file contains a list of registered/allowed AI names and their roles or configurations. Check that `{name}` appears in this list. If it does **not**, stop and tell the user:
   > "`{name}` is not in `Ai-list.md`. Please add it first or use a registered AI name."

3. **Apply the instructions from `Ai-commit.md`** on top of the normal workflow — they override or extend the default commit style rules. The `{name}` parameter is passed as context so the instructions in `Ai-commit.md` can be name-specific if the file is written that way.

4. **Proceed with the normal workflow** (Steps 1–5) using the merged ruleset: git history style + `Ai-commit.md` instructions.

5. **Label the proposed message** so the user knows which mode generated it:
   > 🤖 **AI Mode: `{name}`** — generated using rules from `Ai-commit.md`

**Error cases for AI mode:**

| Situation | Response |
|-----------|----------|
| `Ai-commit.md` not found | "Could not find `Ai-commit.md` in the project root. Please create it with your AI commit instructions." |
| `Ai-list.md` not found | "Could not find `Ai-list.md` in the project root. Please create it and add your registered AI names." |
| `{name}` not in `Ai-list.md` | "`{name}` is not registered in `Ai-list.md`. Add it to the list before using this mode." |

---

## Commands (available after a message is proposed)

| Command | Action |
|---------|--------|
| `commit` | Analyze history + staged changes → generate commit message |
| `regenerate` | Generate a completely different commit message for the same diff |
| `shorter` | Rewrite the current message with a shorter body |
| `longer` | Rewrite the current message with more detail and context |
| `accept` | Commit and push using the currently displayed message |
| `commit and push` | Same as `accept` — execute commit and push |

---

## Workflow

### Step 1 — Read Commit History

Run the following to understand the project's commit conventions (scope format, emoji use, length, language, etc.):

```bash
git log --oneline -40
```

Then fetch a few full commit messages to study body style:

```bash
git log --format="%B%n---" -10
```

Identify patterns:
- Conventional Commits? (`fix(scope):`, `feat:`, `chore:`, …)
- Emoji prefixes?
- Bullet-point bodies?
- Language (English, Farsi/Persian mixed, etc.)
- Average subject line length

### Step 2 — Read Staged Diff

```bash
git diff --cached --stat
git diff --cached
```

If nothing is staged, also check unstaged:

```bash
git status
git diff --stat
```

> If nothing is staged AND nothing is modified, tell the user there is nothing to commit and stop.

### Step 3 — Propose Commit Text Only

Using the history style as a template, write a commit message that:

- Has a **subject line** ≤ 72 characters following the project's type/scope convention (e.g. `fix(module): short imperative summary`)
- Has a **body** (when the change is non-trivial) that explains:
  - **Why** the change was needed (the problem)
  - **What** changed (brief technical summary)
  - Bullet points for multiple sub-changes, matching the project's bullet style
- Is written in the **same language** as the rest of the project's history

Output format — show the proposed message in a fenced code block:

```
<type>(<scope>): <short summary>

<body paragraph explaining the problem / motivation>

Changes:

* <change 1>
* <change 2>
* <change 3>
```

Then say:

> **Commands: `accept` · `regenerate` · `shorter` · `longer` — or paste your own text.**

---

### Step 4 — Handle Commands

Do **not** run `git commit` yet. Wait for the user's next message and respond as follows:

| User says | Action |
|-----------|--------|
| `accept` / `yes` / `ok` / `lgtm` / `push it` / `commit and push` | Proceed to Step 5 with the current message |
| `regenerate` | Produce a new, distinct message for the same diff — different angle, different wording. Show it and repeat Step 4 |
| `shorter` | Rewrite the current message with a condensed body (or subject-only if trivial). Show it and repeat Step 4 |
| `longer` | Rewrite the current message with a more detailed body — expand the why, add more bullet points, explain edge cases. Show it and repeat Step 4 |
| Pastes edited text | Use the user's version as the commit message, proceed to Step 5 |
| `no` / `cancel` / `stop` | Abort; tell the user no commit was made |

---

### Step 5 — Commit and Push

Run:

```bash
git add .
git commit -m "<subject line>" -m "<body if present>"
git push
```

> Use two `-m` flags: first for the subject, second for the body. This keeps `git log --oneline` clean.

Report the result:

```
✅ Committed and pushed.
Commit: <short SHA from git rev-parse --short HEAD>
Branch: <current branch>
```

---

## Style Reference — Example Commit

Use this as a length and structure benchmark when the change is significant:

```
fix(teacher): deduplicate students when multiple lessons share the same class

When a teacher teaches multiple lessons (e.g. xs and xx) in the same class
(e.g. پایه هفتم — الف), the data.classes array contains one entry per
lesson×class assignment, each carrying the full student list of that class.
This caused every student to appear duplicated (once per lesson) in three
places across the teacher dashboard:

1. Overview "کلاس‌ها و دروس" — same class card appeared twice with identical
   student lists, one per lesson name.
2. MyStudents table — each student appeared N times (N = number of lessons
   taught in their class).
3. Behavior report dropdown — same duplication in the student picker.

Changes:

* Overview: group data.classes by classId using a useMemo, merging lesson
  names with " + " separator so each class renders a single card with
  combined lesson names (e.g. "xs + xx — پایه هفتم — الف").
* MyStudents: deduplicate students by id via a Map, keeping one row per
  student with the classLabel from the first assignment encountered.
* Behavior: same Map-based deduplication for the student dropdown, ensuring
  each student appears exactly once regardless of how many lessons they are
  assigned to in that class.
```

---

## Conventional Commit Types Reference

| Type | When to use |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Code restructure, no behavior change |
| `perf` | Performance improvement |
| `docs` | Documentation only |
| `style` | Formatting, whitespace (no logic change) |
| `test` | Adding or fixing tests |
| `build` | Build system or dependency changes |
| `ci` | CI/CD configuration |
| `chore` | Maintenance tasks |
| `revert` | Reverting a previous commit |

---

## Rules

1. **Never commit without explicit user approval.**
2. **Never invent changes** — only describe what the diff actually shows.
3. **Mirror the project's commit language** (check history — it may be English, Persian, or mixed).
4. **Subject line is imperative mood**, not past tense. ("fix bug" not "fixed bug")
5. If the diff is very small (e.g. a single typo fix), a subject-only commit is fine — no body needed.
6. If the diff touches many unrelated files, warn the user and suggest splitting into multiple commits before proceeding.

---

## Error Handling

| Situation | Response |
|-----------|----------|
| Not a git repo | "This directory is not a git repository. Run `git init` first." |
| Nothing staged or modified | "Nothing to commit. All files are clean." |
| Push fails (no upstream) | Run `git push --set-upstream origin <branch>` and report the result |
| Merge conflict markers in diff | Warn the user to resolve conflicts before committing |
