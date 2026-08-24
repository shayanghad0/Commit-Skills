# Git Commit Assistant

Generate professional Git commit messages that match your repository's existing style before committing anything.

---

# Git Commit Assistant

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
* Generates detailed commit messages
* Understands staged changes
* Never commits without approval
* Supports commit regeneration
* Supports long descriptive commit bodies
* Preserves repository consistency
* Safe two-step workflow

---

## Workflow

```text
User
 │
 ▼
"commit"

 │
 ▼
Read Git History
(git log)

 │
 ▼
Analyze Staged Changes

 │
 ▼
Generate Commit Message

 │
 ▼
Wait For Approval

 │
 ├── regenerate
 │        │
 │        ▼
 │   Generate New Message
 │
 └── accept
          │
          ▼
git add .
git commit
git push
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

When a teacher teaches multiple lessons in the same classroom, each lesson duplicated the entire student list across several dashboard views.

Changes:

- Group classes by classId.
- Merge lesson names.
- Remove duplicated students using a Map.
- Fix duplicated behavior report dropdown.
- Preserve original class labels.

Result:

- One class card per classroom.
- One student row per student.
- Cleaner teacher dashboard.
```

---

### User

```text
accept
```

### Assistant

Runs:

```bash
git add .
git commit -m "<generated message>"
git push
```

---

## Commands

| Command           | Action                                        |
| ----------------- | --------------------------------------------- |
| `commit`          | Analyze history and generate a commit message |
| `regenerate`      | Generate a different commit message           |
| `shorter`         | Rewrite with a shorter body                   |
| `longer`          | Rewrite with more detail                      |
| `accept`          | Commit and push using the approved message    |
| `commit and push` | Execute the approved commit and push          |

---

## Commit Style

The assistant automatically learns the style of your repository by inspecting recent commits.

It adapts to:

* Conventional Commit prefixes
* Scope names
* Formatting
* Capitalization
* Bullet style
* Body structure
* Writing tone
* Level of detail

No configuration is required.

---

## Conventional Commit Types

The assistant automatically chooses the correct type:

* `feat`
* `fix`
* `refactor`
* `perf`
* `docs`
* `style`
* `test`
* `build`
* `ci`
* `chore`
* `revert`

---

## Safety

The assistant **never** commits automatically.

Every workflow follows:

```
Generate Commit Message
        ↓
User Reviews
        ↓
User Approves
        ↓
Commit
        ↓
Push
```

---

## Requirements

* Git
* A Git repository
* Staged or unstaged changes
* An AI CLI that supports custom skills

---

## Philosophy

A commit message should document **why** a change exists—not just **what** changed.

This skill is designed to keep commit history:

* Consistent
* Professional
* Informative
* Readable
* Easy to search
* Easy to review

Whether you're working on a personal project or a large team repository, your Git history remains clean and meaningful.

---

## License

MIT License
