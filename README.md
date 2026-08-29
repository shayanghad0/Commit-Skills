# Git Commit Assistant

Generate professional Git commit messages that match your repository's existing style — or commit under an AI model's identity.

---

## Overview

An AI-powered CLI skill that analyzes your Git history and staged changes to generate high-quality, consistent commit messages.

Instead of creating generic commit messages, this skill learns the style already used in your repository and produces commits that look like they were written by the same developer.

The workflow is intentionally safe:

1. Analyze repository history
2. Analyze staged changes
3. Generate a commit message
4. Wait for approval
5. Commit and push

Nothing is committed automatically.

---

## Features

* Automatically analyzes recent Git commit history
* Learns your project's writing style
* Follows Conventional Commits
* Generates detailed commit messages with subject + body
* Understands staged changes
* Never commits without approval
* In-session commands: `regenerate`, `shorter`, `longer`, `accept`
* Preserves repository consistency
* Safe two-step workflow

### AI-Assisted Commit Mode

* Commit under a registered AI model's git identity (`commit with ai {name}`)
* Automatic identity swap: save your account → switch to AI → commit → restore
* Register multiple AI providers in `Ai-list.md`
* Supported providers: **DeepSeek**, **Mimo AI**, and more

---

## Quick Start

```text
commit
```

The skill analyzes your history and staged changes, then proposes a commit message. Type `accept` to commit, or `regenerate` for a new message.

---

## AI-Assisted Mode

```text
commit with ai deepseek
commit with ai mimo
```

Commits under the AI model's git identity, then restores your original account.

---

## Workflow

```text
User
 │
 ▼
"commit"
 │
 ▼
Read Git History (git log)
 │
 ▼
Analyze Staged Changes (git diff)
 │
 ▼
Generate Commit Message
 │
 ▼
Wait For Approval
 │
 ├── regenerate → Generate New Message
 ├── shorter    → Condense Body
 ├── longer     → Expand Detail
 └── accept     → git add . && git commit && git push
```

---

## AI-Assisted Workflow

```text
User
 │
 ▼
"commit with ai deepseek"
 │
 ▼
Read Ai-commit.md (AI instructions)
 │
 ▼
Read Ai-list.md (find AI identity)
 │
 ▼
Save Original Git Account
 │
 ▼
Generate Commit Message (normal flow)
 │
 ▼
Wait For Approval
 │
 └── accept
      │
      ▼
Switch Git Account to AI Identity
      │
      ▼
git add . && git commit && git push
      │
      ▼
Restore Original Git Account
```

---

## Example

### User

```text
commit
```

### Assistant

```text
fix(teacher): deduplicate students when multiple lessons share the same class

When a teacher teaches multiple lessons in the same classroom, each lesson
duplicated the entire student list across several dashboard views.

Changes:

* Group classes by classId using a useMemo
* Merge lesson names with " + " separator
* Deduplicate students by id via a Map
* Fix duplicated behavior report dropdown
```

**Commands: `accept` · `regenerate` · `shorter` · `longer` — or paste your own text.**

### User

```text
accept
```

### Assistant

```bash
git add .
git commit -m "fix(teacher): deduplicate students..." -m "..."
git push
```

---

## Commands

| Command | Action |
|---------|--------|
| `commit` | Analyze history + staged changes → generate commit message |
| `regenerate` | Generate a completely different commit message for the same diff |
| `shorter` | Rewrite the current message with a shorter body |
| `longer` | Rewrite the current message with more detail and context |
| `accept` | Commit and push using the currently displayed message |
| `commit and push` | Same as `accept` — execute commit and push |

---

## AI Providers

Register AI models in `Ai-list.md`. Each provider has a name and email for git identity.

### Current Providers

| Provider | Email | Name | Models |
|----------|-------|------|--------|
| DeepSeek | deepseekcustmgithub@atomicmail.io | DeepSeek | V4 Pro, V4 Flash, V3, R1, Coder, Janus, VL2, Prover |
| Mimo AI | mimoai@atomicmail.io | Mimo Ai | V2.5 Pro, V2.5, V2-Flash, Audio 7B |

### Adding a Provider

Append to `Ai-list.md`:

```markdown
## New Provider — All Models

| Provider | Email | Name |
|----------|-------|------|
| New Provider (all models) | email@domain.com | Provider Name |

### Series Name

| Model ID | Full Name | Series | Type |
|----------|-----------|--------|------|
| `provider-model-name` | Model Full Name | Series | Description |
```

---

## Commit Style

The assistant automatically learns the style of your repository by inspecting recent commits.

It adapts to:

* Conventional Commit prefixes (`feat`, `fix`, `chore`, etc.)
* Scope names
* Formatting and capitalization
* Bullet style
* Body structure
* Writing tone (English, Persian, mixed)
* Level of detail

No configuration is required.

---

## Conventional Commit Types

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

## Safety

The assistant **never** commits automatically.

Every workflow follows:

```
Generate Commit Message
        ↓
User Reviews
        ↓
User Approves (type "accept")
        ↓
Commit
        ↓
Push
```

For AI-assisted mode, the original git identity is **always** restored after the push — even if the push fails.

---

## Requirements

* Git
* A Git repository with staged or unstaged changes
* An AI CLI that supports custom skills (e.g. Claude Code)

---

## Philosophy

A commit message should document **why** a change exists — not just **what** changed.

This skill is designed to keep commit history:

* Consistent
* Professional
* Informative
* Readable
* Easy to search
* Easy to review

Whether you're working on a personal project or a large team repository, your Git history remains clean and meaningful.

---

## Repository Structure

```text
commit-skills/
├── README.md
├── install.md
├── skill.md
├── Ai-Commit.md
└── Ai-list.md
```

---

## License

MIT License
