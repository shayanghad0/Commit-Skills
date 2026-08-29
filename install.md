# Installation

## Requirements

Before installing this skill, ensure you have:

* Git
* A supported AI CLI with Custom Skills support (e.g. Claude Code)
* Access to your CLI's skills directory

---

## Option 1 — Install from GitHub

Clone the repository:

```bash
git clone https://github.com/shayanghad0/Commit-Skills.git
```

Copy the following files into your CLI's skills directory:

* `skill.md` — the main skill definition
* `Ai-commit.md` — AI-assisted commit workflow instructions
* `Ai-list.md` — AI model identity registry

---

## Option 2 — Manual Installation

1. Download the following files:
   * `skill.md`
   * `Ai-commit.md`
   * `Ai-list.md`
2. Open your AI CLI skills folder.
3. Copy all three files into that directory.
4. Restart the CLI if required.

---

## Verify Installation

Ask your CLI:

```text
commit
```

If the skill is installed correctly, it will:

1. Analyze Git history.
2. Analyze staged changes.
3. Generate a commit message.
4. Wait for approval.

Nothing will be committed automatically.

### Test AI-Assisted Mode

```text
commit with ai deepseek
```

If AI mode is working, it will:

1. Read `Ai-commit.md` and `Ai-list.md`.
2. Save your current git account.
3. Propose a commit message labeled with the AI mode.
4. Wait for approval before switching identity.

---

## Updating

Pull the latest changes:

```bash
git pull
```

Or download the latest files and replace the existing ones:

* `skill.md`
* `Ai-commit.md`
* `Ai-list.md`

---

## Uninstall

Remove these files from your CLI's skills directory:

```text
skill.md
Ai-commit.md
Ai-list.md
```

---

## Repository Structure

```text
Commit-Skills/
├── README.md        — Overview and usage
├── install.md       — Installation guide (this file)
├── skill.md         — The AI skill definition
├── Ai-Commit.md     — AI identity swap workflow
└── Ai-list.md       — AI model registry
```

---

## File Descriptions

| File | Purpose |
|------|---------|
| `skill.md` | Main skill definition — triggers, workflow, commands, rules |
| `Ai-commit.md` | Instructions for AI-assisted commit mode (identity swap workflow) |
| `Ai-list.md` | Registry of AI providers and their git identities |

---

## AI Provider Setup

To use `commit with ai {name}`, you need registered providers in `Ai-list.md`.

### Current Providers

| Provider | Email | Name |
|----------|-------|------|
| DeepSeek | deepseekcustmgithub@atomicmail.io | DeepSeek |
| Mimo AI | mimoai@atomicmail.io | Mimo Ai |

### Adding a New Provider

Add a section to `Ai-list.md`:

```markdown
## New Provider — All Models

All New Provider models share the same git provider identity:

| Provider | Email | Name |
|----------|-------|------|
| New Provider (all models) | email@domain.com | Provider Name |
```

---

## Support

If you encounter issues, open an issue in the GitHub repository or submit a pull request with improvements.
