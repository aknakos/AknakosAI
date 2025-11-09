---
name: list-work
description: Display all work items with statuses, priorities, progress. Shows Epic name, status (backlog/drafted/planning/in_progress/parked/complete), priority (P0-P3), progress summary, dependencies, blockers. Grouped by priority, sorted by status.
---

## Instructions

Provide comprehensive view of all Epics across all states, grouped by priority (P0-P3), sorted by status.

### When to Use

**Use**: User asks "what's on my plate?", need to decide what to work on next, see parked/backlog items, review overall progress, "list-work" command

**Don't Use**: Only want current work (use `whats-next`), only parked work (use `resume`), detailed Epic info (read Epic file)

### Display Structure

**1. Overview Section**

Display: Active work (epic + phase), counts (parked, drafted, backlog, complete), total epics

**2. Priority Sections** (P0 → P1 → P2 → P3)

For each priority, group by status: IN PROGRESS → PARKED → DRAFTED → BACKLOG

**Per Epic show**:
- Name, Status, Progress summary, Dates (started/parked/created), Complexity (1-9)
- Description, Dependencies, Blockers
- Git stash ref (if parked), Validation status (if drafted)

**3. Complete Section**

List completed epics with priority and completion date

**4. Summary Footer**

Suggest next steps (complete in-progress P0/P1, resume parked high-priority, start drafted work)

### Process

**Step 1**: Read workflow.yaml (`parked_work`, `current_work`, Epic list with priorities/statuses)

**Step 2**: Read Epic files for descriptions, dependencies, complexity, notes

**Step 3**: Group by priority (P0 → P1 → P2 → P3), then by status (IN PROGRESS → PARKED → DRAFTED → BACKLOG)

**Step 4**: Display formatted view with overview, priority sections, complete section, next actions

**Step 5**: Suggest actions:
- Complete in-progress P0/P1
- Resume parked high-priority work
- Start drafted Epics (validated, ready for planning)
- Promote backlog items (use `promote-epic`)

### Filtering (Optional)

User can request filters:
- "Show parked work" → Display only parked items
- "What's in backlog?" → Display only backlog items
- "Show P0/P1 only" → Display only critical/urgent priorities
- "Show complete work" → Display completed epics

Apply filter, display relevant subset

### Data Source

- `workflow.yaml`: Epic list, statuses, priorities, parked metadata, current work tracking
- Epic files (`.aknakos/products/{name}/epics/*.md`): Descriptions, acceptance criteria, dependencies, complexity, notes

### Success Guidelines

**DO**:
- ✅ Group by priority (P0 first - most important)
- ✅ Show actionable next steps
- ✅ Highlight blockers and dependencies
- ✅ Include time context (how long parked, when created)
- ✅ Provide filtering options for large lists

**DON'T**:
- ❌ Overwhelm with too much detail (use compact view)
- ❌ Hide critical information (P0 should be prominent)
- ❌ Forget to show dependencies (affects prioritization)
- ❌ Omit git stash info for parked work
- ❌ Skip next action suggestions

### Related Skills

- **`whats-next`**: Current phase and next action (narrower scope)
- **`resume`**: Parked work (subset of list-work)
- **`add-work`**: Add items shown in list-work
- **`promote-epic`**: Move items between statuses

### Examples

**See full output example**: `.aknakos/examples/workflows/list-work-output.md` (shows complete formatted display with all sections, filtering examples, dependency visualization)

### Next Actions

After viewing list-work:
- `resume {epic-name}`: Restore parked work
- `add-work`: Create new Epic
- `promote-epic {epic-name}`: Move backlog → drafted
- Planning mode (Shift+Tab×2): Work on drafted Epic
- `whats-next`: Current phase and next action
