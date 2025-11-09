---
name: add-work
description: Quick Epic capture with priority triage (P0-P3). Handles interruptions without derailing current work. P0 (critical) auto-switches + parks current. P1 (urgent) offers switch. P2/P3 (normal/low) adds to backlog. Creates Epic file with minimal info, user can expand later with promote-epic.
---

## Instructions

Quickly capture new work (Epic) with priority triage, handling interruptions gracefully.

### When to Use

**Use**: New work request arrives, urgent task interrupts, user says "add {epic-name}" or "quick add", capture idea before forgetting

**Don't Use**: Detailed Epic planning (use planning mode), epic already exists (use `list-work` to find it)

### Priority Triage

**P0 (Critical)**: Production down, security breach, data loss, complete blocker
- **Action**: Auto-switch (park current work, start P0 immediately)
- **Example**: "Fix auth service - users can't login (production down)"

**P1 (Urgent)**: Important but not emergency, affects users, time-sensitive
- **Action**: Offer to switch (park current, start P1) or defer to backlog
- **Example**: "Add password reset - users requesting it frequently"

**P2 (Normal)**: Planned work, feature requests, improvements
- **Action**: Add to backlog (continue current work)
- **Example**: "Build analytics dashboard"

**P3 (Low)**: Nice-to-have, polish, future ideas
- **Action**: Add to backlog (continue current work)
- **Example**: "Dark mode toggle"

### Process

**Step 1: Capture Work**

User provides: Epic name (required), brief description, rough complexity (1-9), priority (P0-P3)

If minimal info: "User says 'add dark mode'" → Ask for priority, capture minimal Epic, defer details to `promote-epic` later

**Step 2: Assign Priority**

If user doesn't specify: Ask "Priority? P0 (critical), P1 (urgent), P2 (normal), P3 (low)"

If unclear: Provide guidance:
- P0: System down, users blocked
- P1: Important, time-sensitive
- P2: Planned work
- P3: Nice-to-have

**Step 3: Handle Current Work** (based on priority)

**If P0**: Automatically park current work (call `park` skill), prepare to start P0 immediately

**If P1**: Offer options:
1. Park current work and start P1 now
2. Add P1 to backlog, continue current work

**If P2/P3**: Add to backlog, continue current work (no interruption)

**Step 4: Create Epic File**

Save to `.aknakos/products/{product-name}/epics/YYYY-MM-DD-{epic-name}.md`

**Minimal Epic template** (if quick capture):
```markdown
# Epic: {Epic Name}

**Status**: Backlog (or P0/P1 → Drafted)
**Priority**: {P0-P3}
**Complexity**: {1-9 estimate}
**Created**: {YYYY-MM-DD}

## Description

{Brief description from user}

## Acceptance Criteria

- [ ] {Criterion 1 - minimal}
- [ ] {Criterion 2 - minimal}
- [ ] {Criterion 3 - minimal}

## Dependencies

{None or list dependencies}

## Notes

Quick capture. Expand with `promote-epic` before planning.
```

**Step 5: Update Workflow State**

Add to workflow.yaml:
```yaml
products:
  {product-name}:
    epics:
      - name: "{epic-name}"
        status: "backlog"  # Or "drafted" if P0/P1 quick-validated
        priority: "{P0-P3}"
        created_at: "{YYYY-MM-DD}"
        complexity: {1-9}
```

**Step 6: Next Actions** (based on priority)

**If P0 (parked current work)**:
- "Current work parked. P0 Epic created: {name}"
- "This is critical. Start immediately? [y/n]"
- If yes: Enter planning mode or start work

**If P1 (user chose to switch)**:
- "Current work parked. P1 Epic created: {name}"
- "Start now or plan first? [start/plan]"

**If P2/P3 (backlog)**:
- "Epic added to backlog: {name}"
- "Continue current work: {current epic}"
- "Use `list-work` to see backlog"

### Minimal vs Detailed Capture

**Minimal** (quick capture):
- Name + 1-sentence description + priority
- 3 basic acceptance criteria
- Rough complexity
- **Later**: Use `promote-epic` to expand before planning

**Detailed** (conversational):
- Full description (user needs, scenarios)
- Comprehensive acceptance criteria
- Architecture considerations
- Dependencies identified
- **Ready**: Can promote to planning immediately

**Default**: Minimal (fast capture), expand later

### Workflow Integration

**Common flow**:
1. Working on Epic A (P2)
2. P0 urgent work arrives → `add-work` (auto-parks Epic A)
3. Complete P0 work
4. `resume` Epic A → Return to original work

### Success Guidelines

**DO**:
- ✅ Triage priority immediately (P0/P1/P2/P3)
- ✅ Park current work for P0 (auto), offer for P1
- ✅ Create Epic file with minimal info (fast capture)
- ✅ Update workflow.yaml
- ✅ Guide next actions based on priority

**DON'T**:
- ❌ Interrupt current work for P2/P3
- ❌ Skip priority assignment
- ❌ Require detailed Epic for quick capture
- ❌ Forget to park current work when switching to P0/P1

### Related Skills

- **`park`**: Saves current work (called by add-work for P0/P1 switches)
- **`resume`**: Restores parked work (after completing urgent work)
- **`promote-epic`**: Expands minimal Epics before planning
- **`list-work`**: Shows all work including newly added backlog items

### Examples

**See detailed scenarios**: `.aknakos/examples/workflows/add-work-scenarios.md` (covers P0 auto-switch, P1 offer, P2/P3 backlog, minimal vs detailed capture, handling interruptions)
