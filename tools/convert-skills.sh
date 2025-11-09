#!/bin/bash

# Convert Aknakos skills to valid Claude Code skill format
# Each skill needs:
# 1. YAML frontmatter with name and description
# 2. Directory structure: .claude/skills/{skill-name}/SKILL.md

set -e

# Create base directory
mkdir -p .claude/skills

# Function to extract skill name from filename
get_skill_name() {
    basename "$1" .md
}

# Function to create description from Purpose and When to Use
create_description() {
    local file="$1"

    # Try to extract clean description from various formats
    # Look for Purpose: line or section
    local purpose=""
    local when=""

    # Extract purpose (more flexible pattern)
    if grep -q "^## Purpose" "$file"; then
        purpose=$(awk '/^## Purpose/ {getline; while (NF && !/^##/ && !/^---/ && !/^\*\*/) {print; getline}}' "$file" | head -3 | tr '\n' ' ')
    elif grep -q "^\*\*Purpose\*\*:" "$file"; then
        purpose=$(grep "^\*\*Purpose\*\*:" "$file" | sed 's/^\*\*Purpose\*\*: *//')
    fi

    # If no purpose found, try to get first meaningful paragraph
    if [ -z "$purpose" ]; then
        purpose=$(head -30 "$file" | grep -v '^#' | grep -v '^---' | grep -v '^$' | grep -v '^\*\*Phase\*\*' | grep -v '^\*\*When to Use\*\*' | head -1)
    fi

    # Extract when to use (more flexible)
    if grep -q "^## When to Use" "$file"; then
        when=$(awk '/^## When to Use/ {getline; getline; if (NF) print}' "$file")
    elif grep -q "^\*\*When to Use\*\*:" "$file"; then
        when=$(grep "^\*\*When to Use\*\*:" "$file" | sed 's/^\*\*When to Use\*\*: *//')
    fi

    # Combine and clean up
    local description="$purpose"
    if [ -n "$when" ]; then
        description="$description Use when: $when"
    fi

    # Clean up and limit
    description=$(echo "$description" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//; s/  */ /g' | cut -c1-1020)

    # Fallback if empty
    if [ -z "$description" ]; then
        description=$(head -20 "$file" | grep -v '^#' | grep -v '^---' | grep -v '^$' | head -1 | cut -c1-1020)
    fi

    echo "$description"
}

# Function to convert a skill file
convert_skill() {
    local source_file="$1"
    local skill_name=$(get_skill_name "$source_file")
    local description=$(create_description "$source_file")

    # Create skill directory
    local target_dir=".claude/skills/$skill_name"
    mkdir -p "$target_dir"

    # Create SKILL.md with frontmatter
    local target_file="$target_dir/SKILL.md"

    echo "Converting: $skill_name"

    # Write frontmatter
    cat > "$target_file" << EOF
---
name: $skill_name
description: $description
---

EOF

    # Append original content (remove old header if it's "# Skill: Name" or "# Name Skill")
    sed -E '/^# (Skill: |.*Skill$)/d' "$source_file" >> "$target_file"

    echo "  ✓ Created: $target_file"
}

# Convert all skills
echo "Converting Aknakos skills to Claude Code format..."
echo ""

skill_count=0
for skill_file in .aknakos/skills/*.md; do
    if [ -f "$skill_file" ]; then
        convert_skill "$skill_file"
        skill_count=$((skill_count + 1))
    fi
done

echo ""
echo "========================================="
echo "✓ Converted $skill_count skills"
echo "✓ Location: .claude/skills/"
echo ""
echo "Skills are now in valid Claude Code format and ready to use!"
echo "========================================="
