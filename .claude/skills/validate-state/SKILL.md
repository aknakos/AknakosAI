---
name: validate-state
description: Verify workflow.yaml consistency with actual files and detect orphaned files, broken references, or missing reviews. Ensures workflow state accurately reflects product reality. Use before major transitions (planning mode, Epic completion), after file operations, periodic audits, or when troubleshooting.
---

## Instructions

Validate `.aknakos/state/workflow.yaml` against filesystem to catch configuration drift before it causes issues.

### When to Use

**Use**: Before planning mode, before Epic completion, after creating/deleting strategic docs or Epics, periodic audits (weekly), troubleshooting incorrect state

**Don't Use**: workflow.yaml doesn't exist, no products defined

**Time**: 1-3 min per product

### Process

**Step 1: Load Workflow State**

Read `.aknakos/state/workflow.yaml`.

**Extract per product**:
- Strategic document file paths
- Epic file paths
- Review file paths
- Validation file paths
- Conflict file paths
- Standards files
- Current phase

**Step 2: Validate File References**

Check every file path in workflow.yaml exists on filesystem.

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

**Flag**: Missing files (referenced but don't exist) as CRITICAL

**Step 3: Detect Orphaned Files**

Check files on filesystem but not in workflow.yaml.

**Scan directories**:
```
.aknakos/products/{name}/
  ├── mission.md, roadmap.md, tech-stack.md
  ├── *-project-brief.md, *-architecture.md, *-ux-flow.md, *-prd.md
  ├── epics/*.md
  ├── reviews/**/*.md
  ├── standards/*.yaml
  └── plans/**/*.md
```

**For each file**: Check if path exists in workflow.yaml. If not found → Flag as orphaned (WARNING)

**Common orphaned files**: Old Epic files (renamed), review files from deleted Epics, duplicate PRD files, draft files not tracked

**Step 4: Validate Epic States**

Check Epic status in workflow.yaml matches reality.

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

**Flag**: Status inconsistencies as WARNING

**Step 5: Validate Phase Progression**

Check current phase matches product state.

**Phase requirements**:
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

**Flag**: Phase mismatches as CRITICAL

**Step 6: Validate Required Reviews**

Check completed Epics have all required reviews.

**For Epic with status = "complete"**:

**Required review files** (if review_settings.enabled_reviewers):
- `reviews/{epic-name}/YYYY-MM-DD-test-review.md`
- `reviews/{epic-name}/YYYY-MM-DD-security-review.md`
- `reviews/{epic-name}/YYYY-MM-DD-architecture-review.md`
- `reviews/{epic-name}/YYYY-MM-DD-quality-review.md`
- `reviews/{epic-name}/YYYY-MM-DD-requirements-review.md`

**Flag**: Missing review files as WARNING

**Step 7: Generate Validation Report**

Use template: `.aknakos/templates/reports/state-validation-report.md`

**Sections**:
- Summary (status ✅/⚠️/❌, issue counts)
- Critical Issues (missing files, phase mismatches)
- Warnings (orphaned files, incomplete reviews, TDD violations)
- File Inventory (strategic docs, Epics, reviews, validation, standards)
- Recommendations (immediate actions, suggested actions, cleanup tasks)
- Statistics (files scanned, orphaned, missing, consistency checks)
- Next Steps (fix critical → re-validate → continue)

**Save to**: `.aknakos/products/{product-name}/reviews/validation/YYYY-MM-DD-state-validation.md`

### Validation Logic

**Missing File Detection**:
```
For each file_path in workflow.yaml:
  If not exists(.aknakos/products/{name}/{file_path}):
    Flag as CRITICAL: Missing file reference
```

**Orphaned File Detection**:
```
For each file in .aknakos/products/{name}/**:
  If file not in workflow.yaml references:
    If file matches expected patterns (*.md, *.yaml):
      Flag as WARNING: Orphaned file
```

**Epic Status Validation**:
```
For each epic in workflow.yaml:
  If epic.status == "complete":
    Check: reviews array has 5 entries (all reviewers)
    Check: tdd.tests_written == true
    Check: tdd.tests_passing == true
    If any check fails:
      Flag as WARNING: Epic status inconsistent
```

**Phase Validation**:
```
current_phase = workflow.yaml.current_phase
required_conditions = PHASE_REQUIREMENTS[current_phase]

For each condition in required_conditions:
  If condition not met:
    Flag as CRITICAL: Phase mismatch
```

### Common Issues and Fixes

**Issue 1: Epic file deleted but still in workflow.yaml**
- **Symptoms**: Missing file reference (CRITICAL), Epic status = any
- **Fix**: Remove Epic from workflow.yaml epics array

**Issue 2: Epic completed but no review files**
- **Symptoms**: Missing review (WARNING), Epic status = complete
- **Fix**: Run review agents OR change Epic status to "review" (not complete yet)

**Issue 3: Orphaned Epic file**
- **Symptoms**: Orphaned file (WARNING), Epic file exists but not in workflow.yaml
- **Fix**: Add Epic to workflow.yaml (if active) OR delete file (if obsolete) OR move to epics/archive/ (if historical)

**Issue 4: Phase mismatch**
- **Symptoms**: Phase = "validation_complete" but validation.status = "FAIL"
- **Fix**: Update validation.status to "PASS" (if actually passed) OR change phase back to "epic_breakdown" (if failed)

### Integration

**Use this skill**:
- **Before Phase 4**: Validate state before planning mode
- **After Epic deletion**: Check for orphaned references
- **After Epic completion**: Verify all reviews present
- **Periodic**: Weekly audit

**Complements**:
- `trace-requirements`: Validates traceability (different from state)
- `validate-alignment`: Validates content (different from state)
- `whats-next`: Uses valid state to suggest next actions

### Recommendations by Status

**✅ VALID**: Continue with current phase

**⚠️ WARNINGS**: Fix warnings then continue
- Delete orphaned files
- Complete missing reviews
- Verify TDD violations documented

**❌ INVALID**: Fix critical issues before proceeding
- Recreate missing files or update references
- Fix phase mismatches
- Run validation again to verify

**Related Skills**: whats-next (next actions), trace-requirements (traceability), validate-alignment (content validation)
