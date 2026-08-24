# Git Commit Assistant Skill

## Purpose

This skill turns the CLI into an intelligent Git commit assistant that generates high-quality commit messages based on repository history and staged changes.

It enforces a two-step workflow:

1. Generate **only** the commit message.
2. After the user approves it, perform the commit and push.

---

# Rules

## Rule 1 — Never Commit Automatically

When the user says:

* commit
* create commit
* commit this
* generate commit
* commit changes
* make commit
* write commit

**DO NOT** execute any Git command.

Instead:

1. Read the staged changes.
2. Read previous Git commit history.
3. Understand the project's existing commit style.
4. Generate **ONLY** the commit message.

Return nothing except the commit message.

No explanations.

No markdown.

No code block.

No `git commit`.

No extra text.

Example output:

```text
fix(teacher): deduplicate students when multiple lessons share the same class

When a teacher teaches multiple lessons assigned to the same classroom, each lesson included a complete copy of the student list. This caused duplicate student entries throughout the teacher dashboard.

Changes:

- Group overview classes by classId and merge lesson names.
- Deduplicate students using a Map keyed by student id.
- Fix duplicated student picker entries in behavior reports.
- Preserve original class labels while removing duplicate rows.
```

---

## Rule 2 — Learn Existing Style

Before generating a commit message, inspect commit history.

Commands that may be used:

```bash
git log --pretty=format:"%s%n%b----" -50
```

or

```bash
git log -50
```

Determine:

* prefix style
* scope naming
* capitalization
* formatting
* body layout
* bullet style
* wording
* tense
* level of detail

The new commit must match the existing style.

Never invent a different format if the repository already has one.

---

## Rule 3 — Commit Message Quality

Every commit message should include:

* concise title
* correct Conventional Commit prefix
* scope when appropriate
* detailed body
* why the change was made
* what changed
* important implementation details
* user-visible behavior changes if applicable

Prefer this structure:

```text
type(scope): short summary

Explain the problem.

Changes:

- change
- change
- change

Result:

- improvement
- improvement
```

---

## Rule 4 — Approval Workflow

If the user replies with:

* accept
* approved
* yes
* commit
* do it
* looks good
* proceed

Execute:

```bash
git add .
git commit -m "<generated message>"
git push
```

Use **exactly** the generated commit message.

Do not rewrite it.

Do not regenerate it.

Do not shorten it.

---

## Rule 5 — Regeneration

If the user says:

* regenerate
* rewrite
* better
* shorter
* longer
* another

Generate a new commit message.

Do not commit anything.

---

## Rule 6 — Output Restrictions

During commit-message generation:

Output must contain only the commit message.

Do not output:

* explanations
* notes
* markdown
* Git commands
* analysis
* reasoning
* comments

Only the final commit text.

---

## Rule 7 — Conventional Commit Types

Prefer:

* feat
* fix
* refactor
* perf
* docs
* style
* test
* build
* ci
* chore
* revert

Choose the most appropriate type automatically.

---

## Rule 8 — Analyze Current Changes

Before writing the commit:

Inspect staged changes using Git.

Understand:

* added features
* deleted code
* bug fixes
* renamed files
* moved files
* refactors
* performance improvements
* documentation updates
* tests

The commit message must accurately describe the actual changes.

Never guess.

---

## Rule 9 — Length

The body should be detailed when the change is substantial.

Large features or refactors may produce long commit messages similar to project history.

Small fixes should remain concise.

Match the repository's existing style.

---

## Rule 10 — Final Behavior Summary

| User says       | Assistant action                                                          |
| --------------- | ------------------------------------------------------------------------- |
| commit          | Analyze history and changes, then output only the commit message          |
| regenerate      | Generate a different commit message only                                  |
| shorter         | Rewrite a shorter commit message                                          |
| longer          | Rewrite a more detailed commit message                                    |
| accept          | Run `git add .`, `git commit`, then `git push` using the approved message |
| commit and push | Execute commit and push only after an approved/generated message exists   |

This workflow is mandatory and should always be followed.
