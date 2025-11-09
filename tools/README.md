# Aknakos Framework Tools

Conversion and maintenance scripts for the Aknakos Framework.

## Conversion Scripts

### convert-skills.sh

Converts Aknakos skills from `.aknakos/skills/*.md` to Claude Code format in `.claude/skills/`.

**Usage**:
```bash
./tools/convert-skills.sh
```

**What it does**:
1. Reads each skill file from `.aknakos/skills/`
2. Extracts skill name and description
3. Adds YAML frontmatter (name, description)
4. Creates `.claude/skills/{skill-name}/SKILL.md`
5. Skills become auto-loaded by Claude Code

**Output**: 25 Claude Code skills

---

### create-agent-skills.sh

Converts agent documentation to spawner skills that use the Task tool.

**Usage**:
```bash
./tools/create-agent-skills.sh
```

**What it does**:
1. Reads agent files from `.claude/agents/`
2. Creates spawner skill for each agent
3. Embeds agent instructions in skill
4. Creates `.claude/skills/spawn-{agent-name}/SKILL.md`

**Output**: 11 agent spawner skills

---

## When to Use

**Initial Setup**: Run both scripts once to convert legacy structure to Claude Code format.

**Re-run if**:
- Adding new skills to `.aknakos/skills/`
- Modifying agent documentation
- Updating skill descriptions

---

## Migration Complete

As of v1.1 (2025-11-09), all skills and agents are converted and auto-loaded by Claude Code.

See `MIGRATION.md` for full migration details.
