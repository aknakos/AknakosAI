#!/bin/bash

# Convert agent documentation to spawner skills
# Each agent gets a "spawn-{agent-name}" skill that uses the Task tool

set -e

mkdir -p .claude/skills

# Function to create spawner skill from agent doc
create_spawner_skill() {
    local agent_file="$1"
    local agent_name=$(basename "$agent_file" .md)
    local skill_name="spawn-$agent_name"

    echo "Creating spawner skill: $skill_name"

    # Extract purpose from agent file
    local purpose=$(grep -A 3 "^## Agent Purpose" "$agent_file" | tail -1 | sed 's/^[[:space:]]*//')

    if [ -z "$purpose" ]; then
        purpose=$(head -20 "$agent_file" | grep -v '^#' | grep -v '^---' | grep -v '^\*\*' | grep -v '^$' | head -1)
    fi

    # Create skill directory
    local skill_dir=".claude/skills/$skill_name"
    mkdir -p "$skill_dir"

    # Create SKILL.md with spawner pattern
    cat > "$skill_dir/SKILL.md" << EOF
---
name: $skill_name
description: Spawn $agent_name agent using Task tool. $purpose
---

## Purpose

Spawn the **$agent_name** agent to run in parallel using Claude Code's Task tool.

## Agent Details

EOF

    # Append the original agent content (without header)
    sed -E '/^# .* Agent$/d' "$agent_file" >> "$skill_dir/SKILL.md"

    # Add spawning instructions at the end
    cat >> "$skill_dir/SKILL.md" << 'EOF'

---

## How to Use This Skill

When this skill is invoked, spawn the agent using the Task tool:

\`\`\`
Use the Task tool with:
- subagent_type: "general-purpose"
- description: "{brief description of task}"
- prompt: "{full agent instructions from above}"
\`\`\`

The agent will run in a separate context and return results when complete.

EOF

    echo "  ✓ Created: $skill_dir/SKILL.md"
}

# Convert all research agents
echo "Converting research agents to spawner skills..."
for agent_file in .claude/docs/agents/*.md; do
    if [ -f "$agent_file" ]; then
        create_spawner_skill "$agent_file"
    fi
done

# Convert all review agents
echo ""
echo "Converting review agents to spawner skills..."
for agent_file in .claude/docs/agents/review/*.md; do
    if [ -f "$agent_file" ]; then
        create_spawner_skill "$agent_file"
    fi
done

echo ""
echo "========================================="
echo "✓ Created spawner skills for all agents"
echo "✓ Location: .claude/skills/spawn-*/"
echo ""
echo "These skills help spawn agents using Task tool"
echo "========================================="
