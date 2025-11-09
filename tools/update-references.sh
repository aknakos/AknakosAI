#!/bin/bash

# Update all path references in documentation and skills
# Changes:
# - products/{ → .aknakos/products/{
# - .claude/templates/ → .aknakos/templates/
# - .claude/standards/ → .aknakos/standards/
# - .claude/docs/agents/ → .claude/agents/

set -e

echo "Updating path references..."
echo ""

# Find all markdown files (excluding node_modules, .git, etc.)
files=$(find . -name "*.md" -not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/dist/*" -type f)

count=0

for file in $files; do
    # Check if file has any references to update
    if grep -q -E "products/\{|\.claude/templates/|\.claude/standards/|\.claude/docs/agents/|\.claude/references/" "$file"; then
        echo "Updating: $file"

        # Create temporary file
        sed -e 's|products/{|.aknakos/products/{|g' \
            -e 's|\.claude/templates/|.aknakos/templates/|g' \
            -e 's|\.claude/standards/|.aknakos/standards/|g' \
            -e 's|\.claude/references/|.aknakos/references/|g' \
            -e 's|\.claude/docs/agents/|.claude/agents/|g' \
            "$file" > "$file.tmp"

        # Replace original
        mv "$file.tmp" "$file"
        count=$((count + 1))
    fi
done

echo ""
echo "========================================="
echo "✓ Updated $count files"
echo "========================================="
