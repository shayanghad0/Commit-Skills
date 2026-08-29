# Ai-commit.md — AI Account Commit Instructions

This file is read by the `/commitskillsh` skill whenever the user runs:

```
commit with ai {name}
```

It defines the **full workflow** for committing under an AI model's git identity,
then restoring the user's original git account.

---

## Workflow

### 1 — Read This File First
The skill always reads this file (`Ai-commit.md`) before doing anything else in AI mode.

### 2 — Read `Ai-list.md`
Read the AI model registry:

```bash
cat Ai-list.md
```

`Ai-list.md` is a markdown table with columns:

| Provider | Email | Name |
|----------|-------|------|
| deepseek | deepseekcustmgithub@atomicmail.io | DeepSeek |
| … | … | … |

Find the row where **Provider** matches the `{name}` the user provided (case-insensitive).
Extract:
- `AI_EMAIL` — the email column value
- `AI_NAME` — the name column value

If no matching row is found, stop and tell the user:

> "`{name}` is not listed in `Ai-list.md`. Add a row for it before using this mode."

---

### 3 — Save the User's Current Git Account

Before touching anything, snapshot the user's real identity:

```bash
ORIGINAL_NAME=$(git config user.name)
ORIGINAL_EMAIL=$(git config user.email)
```

Display it so the user can confirm:

```
👤 Your current git account:
   Name:  <ORIGINAL_NAME>
   Email: <ORIGINAL_EMAIL>
```

---

### 4 — Generate the Commit Text

Run the normal commit workflow:
- Read git log history (`git log --oneline -40`, `git log --format="%B%n---" -10`)
- Read staged diff (`git diff --cached`)
- Propose the commit message text

Label it clearly:

```
🤖 AI Mode: {name}
   Committing as: <AI_NAME> <AI_EMAIL>
```

Show the proposed commit message in a fenced code block and wait for the user to say **`accept`**.

---

### 5 — Switch Git Account to AI Identity

Once the user accepts, switch the local git config to the AI's identity:

```bash
git config user.name  "<AI_NAME>"
git config user.email "<AI_EMAIL>"
```

Confirm the switch:

```
🔄 Git account switched to:
   Name:  <AI_NAME>
   Email: <AI_EMAIL>
```

---

### 6 — Commit and Push

```bash
git add .
git commit -m "<subject line>" -m "<body if present>"
git push
```

Report the result:

```
✅ Committed and pushed as <AI_NAME> (<AI_EMAIL>)
   Commit: <git rev-parse --short HEAD>
   Branch: <current branch>
```

---

### 7 — Restore the User's Original Git Account

**Always** restore the original identity after the push, even if push failed:

```bash
git config user.name  "<ORIGINAL_NAME>"
git config user.email "<ORIGINAL_EMAIL>"
```

Confirm the restore:

```
🔙 Git account restored to:
   Name:  <ORIGINAL_NAME>
   Email: <ORIGINAL_EMAIL>
```

---

## Full Example

**User runs:**
```
commit with ai deepseek
```

**Skill executes:**

```bash
# Step 3 — save original
ORIGINAL_NAME=$(git config user.name)   # → User name use Git
ORIGINAL_EMAIL=$(git config user.email) # → User Email use Git

# Step 4 — read Ai-list.md → find deepseek row
# AI_NAME  = DeepSeek
# AI_EMAIL = deepseekcustmgithub@atomicmail.io

# Step 4 — generate + show commit text, wait for accept

# Step 5 — after accept, switch account
git config user.name  "DeepSeek"
git config user.email "deepseekcustmgithub@atomicmail.io"

# Step 6 — commit and push
git add .
git commit -m "fix(auth): handle token expiry on refresh" -m "..."
git push

# Step 7 — restore original account
git config user.name  "User name use Git"
git config user.email "User Email use Git"
```

**Final console output:**

```
👤 Your current git account:
   Name:  User name use Git
   Email: User Email use Git

🤖 AI Mode: deepseek
   Committing as: DeepSeek <deepseekcustmgithub@atomicmail.io>

[proposed commit text shown here]

🔄 Git account switched to:
   Name:  DeepSeek
   Email: deepseekcustmgithub@atomicmail.io

✅ Committed and pushed as DeepSeek (deepseekcustmgithub@atomicmail.io)
   Commit: a3f91bc
   Branch: main

🔙 Git account restored to:
   Name:  User name use Git
   Email: User Email use Git
```

---

## Rules

1. **Always save the original git account before switching** — never leave the user on the AI identity.
2. **Always restore the original account after push** — even if the push fails (use a try/finally mindset).
3. **Never commit before the user types `accept`** — the account switch happens only after approval.
4. **Use `git config` (local, no `--global`)** — only affects this repo, never the user's global git config.
5. **The commit message itself follows the normal commitskillsh style rules** — `Ai-commit.md` only controls the identity swap, not the message format.

---

## Error Handling

| Situation | Action |
|-----------|--------|
| `Ai-list.md` not found | Stop. Tell user to create `Ai-list.md` with Provider / Email / Name columns. |
| `{name}` not in `Ai-list.md` | Stop. Tell user to add the AI row before using this mode. |
| Push fails | Restore git account anyway, then report the push error. |
| Original name/email is empty | Warn the user their git identity was not set before starting, and skip the restore step. |
