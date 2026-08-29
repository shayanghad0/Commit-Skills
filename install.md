# Installation

## Requirements

Before installing this skill, ensure you have:

* Git
* A supported AI CLI with Custom Skills support (e.g. Claude Code)
* Access to your CLI's skills directory

---

## Option 1 — One-Click Install (Recommended)

### Windows

```bash
install.bat
```

Or double-click `install.bat` in the repository.

### Linux / macOS

```bash
bash install.sh
```

### Python (All Platforms)

```bash
python install.py
```

The installer auto-detects your CLI tools and copies the skill files:

* `skill.md`
* `Ai-commit.md`
* `Ai-list.md`

### Installer Options

| Option | Description |
|--------|-------------|
| `--dir /path` | Install to a custom directory |
| `--uninstall` | Remove the skill from all CLI tools |

**Examples:**

```bash
# Windows
install.bat /dir "C:\my\skills"
install.bat /uninstall

# Linux/macOS
bash install.sh --dir ~/my/skills
bash install.sh --uninstall

# Python
python install.py --dir /path/to/skills
python install.py --uninstall
```

---

## Option 2 — Install from GitHub

Clone the repository:

```bash
git clone https://github.com/shayanghad0/Commit-Skills.git
```

Then run the installer:

```bash
cd Commit-Skills
python install.py
# or
bash install.sh
# or (Windows)
install.bat
```

---

## Option 3 — Manual Installation

1. Download the following files:
   * `skill.md`
   * `Ai-commit.md`
   * `Ai-list.md`
2. Open your AI CLI skills folder.
3. Copy all three files into that directory.
4. Restart the CLI if required.

---

## Supported CLI Tools

The installer automatically detects these CLI tools:

| CLI Tool | Skills Directory |
|----------|------------------|
| Claude Code | `~/.claude/skills/` |
| OpenCode | `~/.agents/skills/` |
| OpenCode Config | `~/.config/opencode/skills/` |

If your CLI tool is not listed, use `--dir /path/to/skills` to install manually.

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
commit with ai mimo
commit with ai claude
```

If AI mode is working, it will:

1. Read `Ai-commit.md` and `Ai-list.md`.
2. Save your current git account.
3. Propose a commit message labeled with the AI mode.
4. Wait for approval before switching identity.

---

## Updating

### With Installer

Pull the latest changes and run the installer again:

```bash
git pull
python install.py
```

### Manual Update

Download the latest files and replace the existing ones:

* `skill.md`
* `Ai-commit.md`
* `Ai-list.md`

---

## Uninstall

### With Installer

```bash
python install.py --uninstall
# or
bash install.sh --uninstall
# or (Windows)
install.bat /uninstall
```

### Manual Uninstall

Remove the `commit-skills` folder from your CLI's skills directory:

```text
~/.claude/skills/commit-skills/
~/.agents/skills/commit-skills/
~/.config/opencode/skills/commit-skills/
```

---

## Repository Structure

```text
Commit-Skills/
├── README.md        — Overview and usage
├── install.md       — Installation guide (this file)
├── install.py       — Python installer (cross-platform)
├── install.bat      — Windows installer
├── install.sh       — Linux/macOS installer
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
| `install.py` | Python installer script (cross-platform) |
| `install.bat` | Windows batch installer |
| `install.sh` | Linux/macOS shell installer |

---

## AI Provider Setup

To use `commit with ai {name}`, you need registered providers in `Ai-list.md`.

### Current Providers

| Provider | Email | Name | Models |
|----------|-------|------|--------|
| DeepSeek | deepseekcustmgithub@atomicmail.io | DeepSeek | V4, V3, R1, Coder, Janus, VL2, Prover |
| Mimo AI | mimoai@atomicmail.io | Mimo Ai | V2.5, V2-Flash, Audio |
| Claude AI | claudeaimodels@atomicmail.io | Claude Ai | Fable, Opus, Sonnet, Haiku |

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
