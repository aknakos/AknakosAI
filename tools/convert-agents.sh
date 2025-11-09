#!/bin/bash

# Convert agent documentation to Claude Code agent format
# Claude Code agents: .claude/agents/{agent-name}.md with YAML frontmatter

set -e

mkdir -p .claude/agents

# Function to extract agent description
get_agent_description() {
    local file="$1"

    # Try to get from "Agent Purpose" section
    local desc=$(awk '/^## Agent Purpose/ {getline; while (NF && !/^##/ && !/^---/) {print; getline}}' "$file" | head -2 | tr '\n' ' ' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')

    if [ -z "$desc" ]; then
        # Fallback: first non-header line
        desc=$(head -20 "$file" | grep -v '^#' | grep -v '^---' | grep -v '^\*\*' | grep -v '^$' | head -1)
    fi

    echo "$desc" | cut -c1-1020
}

# Function to convert an agent file
convert_agent() {
    local source_file="$1"
    local agent_name=$(basename "$source_file" .md)
    local description=$(get_agent_description "$source_file")

    echo "Converting agent: $agent_name"

    # Determine tools based on agent type
    local tools="Read, Write, Bash, Glob, Grep"
    if [[ "$agent_name" == *"research"* ]] || [[ "$agent_name" == *"exploration"* ]]; then
        tools="WebSearch, WebFetch, Read, Write, Glob, Grep"
    fi

    # Create agent file with YAML frontmatter
    cat > ".claude/agents/$agent_name.md" << EOF
---
name: $agent_name
description: $description
tools: $tools
model: sonnet
---

EOF

    # Append agent instructions (skip old headers)
    sed -E '/^# .* Agent$/d; /^\*\*Type\*\*:/d; /^\*\*Execution\*\*:/d; /^\*\*Phase\*\*:/d' "$source_file" >> ".claude/agents/$agent_name.md"

    echo "  ✓ Created: .claude/agents/$agent_name.md"
}

echo "Converting agents to Claude Code format..."
echo ""

# Convert research agents
for agent_file in .claude/docs/agents/*.md; do
    if [ -f "$agent_file" ]; then
        convert_agent "$agent_file"
    fi
done

# Convert review agents
for agent_file in .claude/docs/agents/review/*.md; do
    if [ -f "$agent_file" ]; then
        convert_agent "$agent_file"
    fi
done

echo ""
echo "========================================="
echo "✓ Converted agents to Claude Code format"
echo "✓ Location: .claude/agents/"
echo ""
echo "Agents are now in valid Claude Code format!"
echo "========================================="
