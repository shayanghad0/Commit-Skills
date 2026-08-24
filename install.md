# Installation

## Requirements

Before installing this skill, ensure you have:

* Git
* A supported AI CLI with Custom Skills support
* Access to your CLI's skills directory

---

# Option 1 — Install from GitHub

Clone the repository:

```bash
git clone https://github.com/shayanghad0/git-commit-assistant.git
```

Move the `skill.md` file into your CLI's skills directory.

---

# Option 2 — Manual Installation

1. Download `skill.md`.
2. Open your AI CLI skills folder.
3. Copy `skill.md` into that directory.
4. Restart the CLI if required.

---

# Verify Installation

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

---

# Updating

Pull the latest changes:

```bash
git pull
```

Or download the latest `skill.md` and replace the existing one.

---

# Uninstall

Simply remove the skill file:

```text
skill.md
```

from your CLI's skills directory.

---

# Repository Structure

```text
git-commit-assistant/
├── README.md
├── INSTALL.md
├── LICENSE
└── skill.md
```

---

# Documentation

* **README.md** — Overview and usage
* **INSTALL.md** — Installation guide
* **skill.md** — The AI skill definition

---

# Support

If you encounter issues, open an issue in the GitHub repository or submit a pull request with improvements.
