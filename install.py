#!/usr/bin/env python3
"""
Commit Skills Installer
Installs the commit-skills skill to all supported CLI tools.

Supported CLI tools:
- Claude Code (~/.claude/skills/)
- OpenCode (~/.agents/skills/)
- Custom directory (if specified)

Usage:
    python install.py                  # Install to all detected CLI tools
    python install.py --dir /path      # Install to a custom directory
    python install.py --uninstall      # Remove the skill from all CLI tools
"""

import os
import sys
import shutil
import argparse
from pathlib import Path

# Skill files to install
SKILL_FILES = [
    "skill.md",
    "Ai-commit.md",
    "Ai-list.md",
]

# CLI tool skills directories (relative to home)
CLI_SKILLS_PATHS = [
    Path(".claude") / "skills",
    Path(".agents") / "skills",
    Path(".config") / "opencode" / "skills",
]

SKILL_DIR_NAME = "commit-skills"


def get_home_dir() -> Path:
    """Get the user's home directory."""
    return Path.home()


def get_script_dir() -> Path:
    """Get the directory where this script is located."""
    return Path(__file__).parent.resolve()


def find_cli_tools() -> list[Path]:
    """Detect which CLI tools are installed and return their skills directories."""
    home = get_home_dir()
    detected = []

    for rel_path in CLI_SKILLS_PATHS:
        full_path = home / rel_path
        if full_path.exists():
            detected.append(full_path)

    return detected


def install_to_directory(skills_dir: Path, source_dir: Path) -> bool:
    """Install skill files to a specific skills directory."""
    target = skills_dir / SKILL_DIR_NAME

    try:
        # Create target directory
        target.mkdir(parents=True, exist_ok=True)

        # Copy each skill file
        for filename in SKILL_FILES:
            src = source_dir / filename
            dst = target / filename

            if src.exists():
                shutil.copy2(src, dst)
                print(f"  ✓ {filename}")
            else:
                print(f"  ✗ {filename} (not found in source)")
                return False

        return True

    except PermissionError:
        print(f"  ✗ Permission denied: {target}")
        return False
    except Exception as e:
        print(f"  ✗ Error: {e}")
        return False


def uninstall_from_directory(skills_dir: Path) -> bool:
    """Remove skill files from a specific skills directory."""
    target = skills_dir / SKILL_DIR_NAME

    if not target.exists():
        return True

    try:
        shutil.rmtree(target)
        return True
    except Exception as e:
        print(f"  ✗ Error removing {target}: {e}")
        return False


def install(custom_dir: str | None = None) -> None:
    """Main install function."""
    source_dir = get_script_dir()

    print("=" * 50)
    print("Commit Skills Installer")
    print("=" * 50)
    print()

    # Verify source files exist
    print("Checking source files...")
    missing = [f for f in SKILL_FILES if not (source_dir / f).exists()]
    if missing:
        print(f"Error: Missing source files: {', '.join(missing)}")
        print(f"Make sure you run this script from the commit-skills directory.")
        sys.exit(1)
    print("✓ All source files found")
    print()

    # Determine target directories
    targets = []

    if custom_dir:
        custom_path = Path(custom_dir).resolve()
        targets.append(("Custom directory", custom_path))
    else:
        detected = find_cli_tools()
        if not detected:
            print("No CLI tools detected.")
            print("Use --dir /path/to/skills to install to a custom directory.")
            sys.exit(1)
        for path in detected:
            targets.append((str(path), path))

    # Install to each target
    print(f"Installing to {len(targets)} location(s):")
    print()

    success_count = 0
    for name, skills_dir in targets:
        print(f"📁 {name}")
        if install_to_directory(skills_dir, source_dir):
            print(f"  ✓ Installed to {skills_dir / SKILL_DIR_NAME}")
            success_count += 1
        print()

    # Summary
    print("=" * 50)
    if success_count == len(targets):
        print(f"✓ Successfully installed to {success_count} location(s)")
    else:
        print(f"⚠ Installed to {success_count}/{len(targets)} locations")
    print()
    print("Restart your CLI if needed, then test with: commit")
    print("=" * 50)


def uninstall() -> None:
    """Main uninstall function."""
    print("=" * 50)
    print("Commit Skills Uninstaller")
    print("=" * 50)
    print()

    detected = find_cli_tools()
    if not detected:
        print("No CLI tools detected.")
        sys.exit(1)

    print(f"Checking {len(detected)} location(s):")
    print()

    removed_count = 0
    for skills_dir in detected:
        target = skills_dir / SKILL_DIR_NAME
        if target.exists():
            print(f"🗑️  Removing {target}")
            if uninstall_from_directory(skills_dir):
                print(f"  ✓ Removed")
                removed_count += 1
        else:
            print(f"  - Not installed in {skills_dir}")
        print()

    print("=" * 50)
    print(f"✓ Removed from {removed_count} location(s)")
    print("=" * 50)


def main():
    parser = argparse.ArgumentParser(
        description="Install commit-skills to CLI tools"
    )
    parser.add_argument(
        "--dir", "-d",
        help="Install to a custom directory instead of auto-detecting"
    )
    parser.add_argument(
        "--uninstall", "-u",
        action="store_true",
        help="Remove the skill from all CLI tools"
    )

    args = parser.parse_args()

    if args.uninstall:
        uninstall()
    else:
        install(args.dir)


if __name__ == "__main__":
    main()
