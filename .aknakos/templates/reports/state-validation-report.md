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
