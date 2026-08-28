---
name: commitskillsh
description: >
  Git commit message assistant for CLI programming workflows. Trigger this skill whenever the user invokes /commitskillsh, asks for a commit message, says "what should I commit", wants to review git history for commit style, or says "commit text only". The skill reads the git diff/staged changes and full commit history, then proposes a single well-crafted conventional-commit message. It does NOT run git commit until the user explicitly approves the text. Use this skill any time the user is working in a terminal/CLI context and wants help crafting, reviewing, or approving a git commit message.
---

# /commitskillsh — Git Commit Text Assistant

## Purpose

Help the user craft a high-quality `git commit -m "…"` message by:
1. Inspecting the **full git commit history** to learn the project's commit style and conventions.
2. Inspecting the **current staged diff** to understand what changed.
3. Proposing **commit text only** — no commit is made yet.
4. Waiting for the user to say **"accept"** (or any affirmative) before running `git commit -m "…" && git push`.

---

## Trigger

Invoked when the user types `/commitskillsh` **or** says any of:
- "commit text only"
- "what should I commit"
- "give me a commit message"
- "suggest commit"
- "ready to commit"

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

Output format — show the proposed message in a fenced code block so the user can copy it easily:

```
<type>(<scope>): <short summary>

<body paragraph explaining the problem / motivation>

Changes:

* <change 1>
* <change 2>
* <change 3>
```

Then say:

> **Type "accept" to commit and push, or edit the text and I'll use your version.**

---

### Step 4 — Wait for Approval

Do **not** run `git commit` yet. Wait for the user's next message.

| User says | Action |
|-----------|--------|
| `accept` / `yes` / `ok` / `lgtm` / `push it` | Proceed to Step 5 with the proposed message |
| Pastes edited text | Use the user's version as the commit message, proceed to Step 5 |
| `no` / `cancel` / `stop` | Abort; tell the user no commit was made |
| Asks for changes | Revise the message and show it again; repeat Step 3–4 |

---

### Step 5 — Commit and Push

Run:

```bash
git commit -m "<approved message first line>" -m "<body if present>"
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

Below is a high-quality commit message in the conventional-commits style with a detailed body. Use this as a length and structure benchmark when the change is significant:

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
