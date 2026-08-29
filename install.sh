#!/usr/bin/env bash
# ============================================================
# Commit Skills Installer (Linux/macOS)
# Installs the commit-skills skill to all supported CLI tools.
#
# Supported CLI tools:
# - Claude Code (~/.claude/skills/)
# - OpenCode (~/.agents/skills/)
# - OpenCode Config (~/.config/opencode/skills/)
#
# Usage:
#   bash install.sh                  Install to all detected CLI tools
#   bash install.sh --dir /path      Install to a custom directory
#   bash install.sh --uninstall      Remove the skill from all CLI tools
# ============================================================

set -e

SKILL_DIR="commit-skills"
SKILL_FILES="skill.md Ai-commit.md Ai-list.md"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${YELLOW}→${NC} $1"; }

install_one() {
    local target_dir="$1/$SKILL_DIR"

    mkdir -p "$target_dir"

    for file in $SKILL_FILES; do
        if [ -f "$SCRIPT_DIR/$file" ]; then
            cp "$SCRIPT_DIR/$file" "$target_dir/"
            print_success "$file"
        else
            print_error "$file (not found)"
            return 1
        fi
    done

    print_success "Installed to: $target_dir"
    return 0
}

uninstall_one() {
    local target_dir="$1/$SKILL_DIR"

    if [ -d "$target_dir" ]; then
        rm -rf "$target_dir"
        print_success "Removed from: $1"
        return 0
    fi
    return 1
}

install_all() {
    echo "=================================================="
    echo "Commit Skills Installer"
    echo "=================================================="
    echo

    # Check source files
    print_info "Checking source files..."
    for file in $SKILL_FILES; do
        if [ ! -f "$SCRIPT_DIR/$file" ]; then
            print_error "$file (not found)"
            echo
            echo "Error: Missing source files."
            echo "Make sure you run this script from the commit-skills directory."
            exit 1
        fi
    done
    print_success "All source files found"
    echo

    # Detect CLI tools
    local count=0

    # Claude Code
    if [ -d "$HOME/.claude/skills" ]; then
        print_info "Detected: Claude Code"
        install_one "$HOME/.claude/skills"
        count=$((count + 1))
    fi

    # OpenCode
    if [ -d "$HOME/.agents/skills" ]; then
        print_info "Detected: OpenCode"
        install_one "$HOME/.agents/skills"
        count=$((count + 1))
    fi

    # OpenCode Config
    if [ -d "$HOME/.config/opencode/skills" ]; then
        print_info "Detected: OpenCode Config"
        install_one "$HOME/.config/opencode/skills"
        count=$((count + 1))
    fi

    if [ "$count" -eq 0 ]; then
        echo "No CLI tools detected."
        echo "Use --dir /path/to/skills to install to a custom directory."
        exit 1
    fi

    echo
    echo "=================================================="
    print_success "Successfully installed to $count location(s)"
    echo "=================================================="
    echo "Restart your CLI if needed, then test with: commit"
}

install_custom() {
    local dir="$1"

    echo "=================================================="
    echo "Commit Skills Installer"
    echo "=================================================="
    echo
    print_info "Installing to custom directory: $dir"
    install_one "$dir"
    echo
    echo "=================================================="
    print_success "Done"
}

uninstall_all() {
    echo "=================================================="
    echo "Commit Skills Uninstaller"
    echo "=================================================="
    echo

    local count=0

    # Claude Code
    if uninstall_one "$HOME/.claude/skills"; then
        count=$((count + 1))
    fi

    # OpenCode
    if uninstall_one "$HOME/.agents/skills"; then
        count=$((count + 1))
    fi

    # OpenCode Config
    if uninstall_one "$HOME/.config/opencode/skills"; then
        count=$((count + 1))
    fi

    echo
    echo "=================================================="
    print_success "Removed from $count location(s)"
    echo "=================================================="
}

# Parse arguments
case "${1:-}" in
    --uninstall|-u)
        uninstall_all
        ;;
    --dir|-d)
        if [ -z "${2:-}" ]; then
            echo "Error: --dir requires a path."
            echo "Usage: bash install.sh --dir /path/to/skills"
            exit 1
        fi
        install_custom "$2"
        ;;
    *)
        install_all
        ;;
esac
