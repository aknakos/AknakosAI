---
name: promote-epic
description: Move Epic through validation stages (backlog → drafted → ready for planning). Backlog → Drafted requires quick-validate (mission alignment, tech compatibility, rough complexity). Drafted → Planning requires full validate-alignment. Checks dependencies before promotion.
---

## Instructions

Move Epics through validation and readiness stages with appropriate validation at each transition.

### When to Use

**Use**: Ready to promote backlog item to active work, Epic passed validation, dependencies resolved

**Don't Use**: Epic lacks basic info (name/description/complexity), dependencies unresolved, validation failed

### Epic Lifecycle

```
Backlog
  ↓ [promote-epic: quick validation]
Drafted
  ↓ [promote-epic: full validation]
Ready for Planning
  ↓ [enter planning mode: Shift+Tab×2]
Planning → In Progress → Complete
```

**Parked**: Can be parked from any active state, resumes to same state

### Promotion 1: Backlog → Drafted

**Requirements**:
- Name and description (expand if minimal)
- Rough complexity estimate (1-9)
- Priority assignment (P0-P3)
- At least 3 acceptance criteria (minimal)

**Process**:
1. Select Epic from backlog
2. Check dependencies (if dependency in backlog/drafted → block or warn)
3. Add basic details (expand minimal description, add acceptance criteria, confirm priority)
4. Run `quick-validate` skill (mission alignment, tech compatibility, rough complexity)
5. If validation PASS → Update Epic status to "drafted", add `quick_validated: true`
6. If validation FAIL → Resolve issues or defer promotion

### Promotion 2: Drafted → Ready for Planning

**Requirements**:
- Detailed acceptance criteria (comprehensive, testable)
- PRD requirement references (REQ-*)
- Architecture considerations
- Dependencies resolved or in-progress

**Process**:
1. Select drafted Epic
2. Check completion (acceptance criteria detailed?, PRD refs?, architecture notes?)
3. Run `validate-alignment` skill (full validation: PRD coverage, Epic traceability, architecture compliance)
4. If validation PASS or CONCERNS → Update Epic status to "planning", mark `full_validated: true`
5. If validation FAIL → Address issues, re-validate
6. Suggest: "Ready for planning mode. Enter: Shift+Tab×2"

### Dependency Handling

**Before promotion, check dependencies**:

**If dependency complete**: ✓ Proceed

**If dependency in-progress**: ⚠ Warn, let user decide (usually okay to proceed)

**If dependency backlog/drafted**: ✗ Block or offer options:
1. Promote dependency first
2. Remove dependency (if not actually needed)
3. Defer Epic promotion

### Workflow State Updates

**Backlog → Drafted**:
```yaml
epics:
  - name: "{epic-name}"
    status: "drafted"  # Changed from "backlog"
    quick_validated: true
    validated_at: "{YYYY-MM-DD}"
```

**Drafted → Planning**:
```yaml
epics:
  - name: "{epic-name}"
    status: "planning"  # Changed from "drafted"
    full_validated: true
    validated_at: "{YYYY-MM-DD}"
```

### Success Guidelines

**DO**:
- ✅ Check dependencies before promoting
- ✅ Run appropriate validation (quick vs full)
- ✅ Expand minimal Epics before promoting
- ✅ Update workflow.yaml with new status
- ✅ Guide user to next action (planning mode)

**DON'T**:
- ❌ Promote without validation
- ❌ Ignore dependency blockers
- ❌ Skip acceptance criteria requirements
- ❌ Promote directly from backlog to planning (skip drafted stage)

### Related Skills

- **`add-work`**: Creates backlog items (starting point)
- **`quick-validate`**: Validates backlog → drafted (2-3 min check)
- **`validate-alignment`**: Validates drafted → planning (full 10-15 min validation)
- **`list-work`**: Shows epics needing promotion

### Next Actions

**After Backlog → Drafted**:
- Epic now in drafted queue
- Use `list-work` to see all drafted items
- When ready: Promote drafted → planning

**After Drafted → Planning**:
- Epic ready for planning mode
- Enter planning mode: Shift+Tab×2
- Define Stories, Tasks, Test specs

### Examples

**See detailed scenarios**: `.aknakos/examples/workflows/promote-epic-scenarios.md` (covers dependency blocking, minimal Epic expansion, validation failures, quick vs full validation)
