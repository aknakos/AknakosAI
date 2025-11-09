---
name: validate-state
description: Verify workflow.yaml consistency with actual files and detect orphaned files, broken references, or missing reviews. Use when: - **Before major transitions**: Before entering planning mode, before Epic completion
---


Verify workflow.yaml consistency with actual files and detect orphaned files, broken references, or missing reviews.

## Purpose

Ensure workflow state accurately reflects product reality. Catch configuration drift before it causes issues.

## When to Use

- **Before major transitions**: Before entering planning mode, before Epic completion
- **After file operations**: After creating/deleting strategic docs or Epics
- **Periodic audits**: Weekly or after significant changes
- **Troubleshooting**: When workflow state seems incorrect
- **Time**: 1-3 min per product

---

## What This Skill Does

Validates `.aknakos/state/workflow.yaml` against actual filesystem:
- Files referenced in workflow.yaml exist
- Files on filesystem are tracked in workflow.yaml
- Epic statuses match actual progress
- Review files exist for completed Epics
- Validation files exist for validated Epics
- Standards files exist if marked as customized

---

## Process

### 1. Load Workflow State

**Read**: `.aknakos/state/workflow.yaml`

**Extract for each product**:
- Strategic document file paths
- Epic file paths
- Review file paths
- Validation file paths
- Conflict file paths
- Standards files
- Current phase

### 2. Validate File References

**Check**: Every file path in workflow.yaml exists on filesystem

**For each product**:

**Strategic Documents**:
```yaml
mission_file: "mission.md"
→ Check: .aknakos/products/{name}/mission.md exists
```

**Epics**:
```yaml
epics:
  - file: "2025-11-08-user-authentication.md"
→ Check: .aknakos/products/{name}/epics/2025-11-08-user-authentication.md exists
```

**Reviews**:
```yaml
reviews:
  test: "PASS"
→ Check: .aknakos/products/{name}/reviews/user-authentication/2025-11-08-test-review.md exists
```

**Validation**:
```yaml
validation:
  file: "reviews/validation/2025-11-08-epic-validation.md"
→ Check: .aknakos/products/{name}/reviews/validation/2025-11-08-epic-validation.md exists
```

**Conflicts**:
```yaml
conflicts:
  - resolution_file: "reviews/conflicts/2025-11-08-conflict-tech-stack.md"
→ Check: .aknakos/products/{name}/reviews/conflicts/2025-11-08-conflict-tech-stack.md exists
```

**Standards**:
```yaml
standards_customized: true
standards_files: ["security-guidelines.yaml"]
→ Check: .aknakos/products/{name}/standards/security-guidelines.yaml exists
```

**Flag**: Missing files (referenced but don't exist)

### 3. Detect Orphaned Files

**Check**: Files on filesystem but not in workflow.yaml

**Scan directories**:
```
.aknakos/products/{name}/
  ├── mission.md, roadmap.md, tech-stack.md
  ├── *-project-brief.md
  ├── *-architecture.md
  ├── *-ux-flow.md
  ├── *-prd.md
  ├── epics/*.md
  ├── reviews/**/*.md
  ├── standards/*.yaml
  └── plans/**/*.md
```

**For each file found**:
- Check if file path exists in workflow.yaml
- If not found → Flag as orphaned

**Common orphaned files**:
- Old Epic files (renamed but old file not deleted)
- Review files from deleted Epics
- Duplicate PRD files
- Draft files not tracked

### 4. Validate Epic States

**Check**: Epic status in workflow.yaml matches reality

**For each Epic**:

**If status = "complete"**:
- ✅ Must have review files (all 5 reviewers)
- ✅ Must have tests (tdd.tests_written = true)
- ✅ Must have passing tests (tdd.tests_passing = true)
- ✅ Review status should be PASS or CONCERNS (not PENDING)

**If status = "review"**:
- ✅ Must have test files
- ✅ May have some review files (in progress)

**If status = "tdd_implementing"**:
- ✅ Must have test files
- ✅ Tests should be written (tdd.tests_written = true)
- ✅ Tests should be reviewed (tdd.tests_reviewed = true)

**If status = "planning"**:
- ❌ Should NOT have test files yet
- ❌ Should NOT have review files yet

**Flag**: Status inconsistencies

### 5. Validate Phase Progression

**Check**: Current phase matches product state

**Phase logic**:

```
vision → requires: products = {}
mission_created → requires: mission_file exists
project_brief_created → requires: project_brief_file exists (optional)
architecture_created → requires: architecture_file exists (optional)
ux_flow_created → requires: ux_flow_file exists (optional)
prd → requires: prd.file exists, prd.status = "approved"
epic_breakdown → requires: epics.length > 0
validation_complete → requires: validation.status in ["PASS", "CONCERNS"]
planning_mode → requires: at least 1 Epic with status != "complete"
tdd_* → requires: active Epic in tdd_* status
review → requires: active Epic in "review" status
epic_complete → requires: active Epic with status = "complete"
```

**Flag**: Phase mismatches

### 6. Validate Required Reviews

**Check**: Completed Epics have all required reviews

**For Epic with status = "complete"**:

**Required review files** (if review_settings.enabled_reviewers):
- `reviews/{epic-name}/YYYY-MM-DD-test-review.md`
- `reviews/{epic-name}/YYYY-MM-DD-security-review.md`
- `reviews/{epic-name}/YYYY-MM-DD-architecture-review.md`
- `reviews/{epic-name}/YYYY-MM-DD-quality-review.md`
- `reviews/{epic-name}/YYYY-MM-DD-requirements-review.md`

**Flag**: Missing review files for completed Epics

### 7. Generate Validation Report

**Output**: Validation summary with issues and recommendations

---

## Validation Report Format

```markdown
# Workflow State Validation Report

**Product**: {name}
**Generated**: {YYYY-MM-DD HH:MM}
**Workflow File**: `.aknakos/state/workflow.yaml`

---

## Summary

**Status**: ✅ VALID / ⚠️ WARNINGS / ❌ INVALID

**Issues Found**: {count}
- Critical: {count}
- Warnings: {count}

**Products Validated**: {count}

---

## Critical Issues

### Product: my-product

#### 1. Missing File Reference

**Severity**: CRITICAL
**Type**: Missing file
**Details**: Epic file referenced in workflow.yaml does not exist
**File**: `products/my-product/epics/2025-11-08-user-authentication.md`
**Referenced in**: `workflow.yaml:59`

**Recommendation**:
- If Epic was renamed: Update workflow.yaml with new filename
- If Epic was deleted: Remove Epic from workflow.yaml
- If file should exist: Recreate Epic file or restore from backup

#### 2. Phase Mismatch

**Severity**: CRITICAL
**Type**: Invalid phase
**Details**: Current phase is "validation_complete" but validation status is "FAIL"
**Current phase**: `validation_complete`
**Validation status**: `FAIL`

**Recommendation**:
- If validation failed: Set phase to "epic_breakdown" and fix Epics
- If validation passed but status not updated: Set validation.status to "PASS"

---

## Warnings

### Product: my-product

#### 1. Orphaned File

**Severity**: WARNING
**Type**: Orphaned file
**Details**: File exists but not tracked in workflow.yaml
**File**: `products/my-product/epics/2025-11-07-old-auth.md`

**Recommendation**:
- If obsolete: Delete file
- If active: Add to workflow.yaml epics array

#### 2. Incomplete Review

**Severity**: WARNING
**Type**: Missing review
**Details**: Epic marked complete but missing review file
**Epic**: user-authentication
**Status**: complete
**Missing review**: `reviews/user-authentication/2025-11-08-test-review.md`

**Recommendation**:
- Run test-reviewer agent for this Epic
- Or: Change Epic status to "review" (not complete yet)

#### 3. TDD Critical Rule Violation

**Severity**: WARNING
**Type**: TDD violation
**Details**: Epic has tests_changed_during_implementation = true
**Epic**: dashboard
**Reason**: {test_change_reason from workflow.yaml}

**Recommendation**:
- Review test change justification
- Verify changes were documented in plan
- Ensure tests still match Epic acceptance criteria

---

## File Inventory

### Product: my-product

**Strategic Documents**: ✅ All found
- mission.md
- roadmap.md
- tech-stack.md
- 2025-11-08-prd.md
- 2025-11-08-architecture.md

**Epics**: ⚠️ 1 orphaned
- 2025-11-08-user-authentication.md (tracked)
- 2025-11-09-dashboard.md (tracked)
- 2025-11-07-old-auth.md (orphaned)

**Reviews**: ⚠️ 1 missing
- user-authentication: 4/5 reviews (missing test-review)
- dashboard: 0/5 reviews (Epic in progress, expected)

**Validation**: ✅ Found
- reviews/validation/2025-11-08-epic-validation.md

**Standards**: ✅ All found
- standards/security-guidelines.yaml
- standards/testing-standards.yaml

---

## Recommendations

### Immediate Actions (Critical)

1. **Fix missing file reference**: Update workflow.yaml to remove reference to deleted Epic file
2. **Fix phase mismatch**: Change phase to "epic_breakdown" or update validation status to "PASS"

### Suggested Actions (Warnings)

1. **Delete orphaned file**: Remove `products/my-product/epics/2025-11-07-old-auth.md`
2. **Complete review**: Run test-reviewer agent for user-authentication Epic
3. **Verify TDD violation**: Review dashboard Epic test changes and ensure documented

### Cleanup Tasks

1. Run `validate-state` skill after each Epic deletion to catch orphans early
2. Consider archiving old Epics instead of deleting (move to `epics/archive/`)
3. Update workflow.yaml immediately after file operations

---

## Statistics

**Total Files Scanned**: 24
**Files Referenced in Workflow**: 22
**Orphaned Files**: 1
**Missing Files**: 1
**Phase Consistency**: Invalid (1 issue)
**Epic Status Consistency**: Valid

---

## Next Steps

1. Fix critical issues listed above
2. Run `validate-state` skill again to verify fixes
3. Continue workflow once validation passes

**Status after fixes**: Should be ✅ VALID
```

---

## Validation Logic

### Missing File Detection

```
For each file_path in workflow.yaml:
  If not exists(.aknakos/products/{name}/{file_path}):
    Flag as CRITICAL: Missing file reference
```

### Orphaned File Detection

```
For each file in .aknakos/products/{name}/**:
  If file not in workflow.yaml references:
    If file matches expected patterns (*.md, *.yaml):
      Flag as WARNING: Orphaned file
```

### Epic Status Validation

```
For each epic in workflow.yaml:
  If epic.status == "complete":
    Check: reviews array has 5 entries (all reviewers)
    Check: tdd.tests_written == true
    Check: tdd.tests_passing == true
    If any check fails:
      Flag as WARNING: Epic status inconsistent
```

### Phase Validation

```
current_phase = workflow.yaml.current_phase
required_conditions = PHASE_REQUIREMENTS[current_phase]

For each condition in required_conditions:
  If condition not met:
    Flag as CRITICAL: Phase mismatch
```

---

## Integration with Workflow

**Use this skill**:
- **Before Phase 4**: Validate state before planning mode
- **After Epic deletion**: Check for orphaned references
- **After Epic completion**: Verify all reviews present
- **Periodic**: Weekly audit

**Complements**:
- `trace-requirements`: Validates traceability (different from state)
- `validate-alignment`: Validates content (different from state)
- `whats-next`: Uses valid state to suggest next actions

---

## Auto-Fix Capabilities (Future)

**Safe auto-fixes** (could be added):
- Remove orphaned files after user confirmation
- Update workflow.yaml with missing file paths
- Fix phase based on current product state
- Update Epic status based on review files

**Manual fixes required**:
- Recreating deleted files
- Resolving conflicting states
- Determining correct Epic status when ambiguous

---

## Common Issues and Fixes

### Issue 1: Epic file deleted but still in workflow.yaml

**Symptoms**:
- Missing file reference (CRITICAL)
- Epic status = any

**Fix**:
```yaml
# Remove Epic from workflow.yaml
epics:
  - name: "user-authentication"  # DELETE THIS ENTRY
    file: "2025-11-08-user-authentication.md"  # File doesn't exist
```

### Issue 2: Epic completed but no review files

**Symptoms**:
- Missing review (WARNING)
- Epic status = complete

**Fix**:
```
Option 1: Run review agents to generate missing reviews
Option 2: Change Epic status to "review" (not complete yet)
```

### Issue 3: Orphaned Epic file

**Symptoms**:
- Orphaned file (WARNING)
- Epic file exists but not in workflow.yaml

**Fix**:
```
Option 1: Add Epic to workflow.yaml (if active)
Option 2: Delete file (if obsolete)
Option 3: Move to epics/archive/ (if historical)
```

### Issue 4: Phase mismatch

**Symptoms**:
- Phase = "validation_complete" but validation.status = "FAIL"

**Fix**:
```yaml
# Fix validation status
validation:
  status: "PASS"  # Update if validation actually passed

# OR change phase back
current_phase: "epic_breakdown"  # If validation failed
```

---

## Tips for Success

- **Run frequently**: After file operations, before transitions
- **Fix critical first**: Missing files and phase mismatches block workflow
- **Archive don't delete**: Move old files to archive/ instead of deleting
- **Automate**: Consider running this validation before each `whats-next` call
- **Keep clean**: Fix orphans and warnings promptly to maintain state health

---

## Example Usage

```
User: I think my workflow state is out of sync. Can you validate it?

Claude: I'll run the validate-state skill to check workflow.yaml consistency.

[Runs validation]

Found 3 issues:
- CRITICAL: Epic "old-auth.md" referenced but file doesn't exist
- WARNING: Epic "dashboard.md" exists but not in workflow.yaml
- WARNING: user-authentication marked complete but missing test-review.md

Let me fix these:
1. Removing old-auth from workflow.yaml (file was deleted)
2. Adding dashboard.md to workflow.yaml
3. Running test-reviewer agent for user-authentication

[Makes fixes]

Validation now passes ✅
```

---

## What's Next

After state validation:
- If VALID: Continue with current phase
- If WARNINGS: Fix warnings then continue
- If INVALID: Fix critical issues before proceeding
- Use `whats-next` skill to see next actions
