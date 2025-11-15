# Test Review Report: {Epic Name}

**Epic**: {epic-name}
**Review Date**: {YYYY-MM-DD}
**Reviewer**: test-reviewer
**Complexity**: {1-9}

## Review Outcome

**Overall**: {PASS / CONCERNS / FAIL}

**Summary**: {1-2 sentence overall assessment}

---

## Test-Plan Alignment

**Plan File**: .aknakos/products/{product-name}/plans/{epic-name}/YYYY-MM-DD-plan.md

### Test Specifications from Plan

| Test Specification | Status | Notes |
|--------------------|--------|-------|
| test_login_with_valid_credentials() | ✅ Exists | Matches plan, covers acceptance criteria |
| test_login_with_invalid_password() | ✅ Exists | Matches plan |
| test_login_rate_limiting() | ❌ Missing | Not implemented, was in plan |

**Alignment**: {X}/{Y} specified tests exist and match plan

**Rating**: ✅ PASS / ⚠️ CONCERNS / ❌ FAIL

**Issues**:
- {Issue 1 if any}
- {Issue 2 if any}

---

## TDD Compliance Check

**Tests Changed During Implementation**: {TRUE / FALSE}

{If FALSE}:
✅ **TDD Rules Followed**
- Tests were written first
- Tests were not modified during implementation
- Implementation made tests pass without changing tests

{If TRUE}:
⚠️ **Tests Were Modified During Implementation**

**Change Reason**: {from workflow.yaml test_change_reason field}

**Justification Valid**: {YES / NO}

**Analysis**:
{Review if the reason for changing tests was legitimate}

**Files Changed**:
- {test file 1}: {what changed and why}
- {test file 2}: {what changed and why}

**Rating**: ✅ PASS / ⚠️ CONCERNS / ❌ FAIL

---

## Test Coverage

**Coverage Metrics** (if available):
- **Overall**: {percentage}%
- **Unit Tests**: {percentage}%
- **Integration Tests**: {coverage description}
- **E2E Tests**: {coverage description}

### Testing Pyramid Compliance

**Test Distribution**:
- **Unit Tests**: {count} ({percentage}%) - Target: 70-80%
- **Integration Tests**: {count} ({percentage}%) - Target: 15-20%
- **E2E Tests**: {count} ({percentage}%) - Target: 5-10%
- **Total Tests**: {count}

**Pyramid Compliance**: ✅ GOOD / ⚠️ CONCERNS / ❌ POOR

**Issues**:
- {Issue if E2E > 15%: "Too many E2E tests ({count}), exceeds 10-15% target"}
- {Issue if E2E > 10 tests: "E2E test count ({count}) exceeds maximum (5-10 tests)"}
- {Issue if Unit < 60%: "Insufficient unit test coverage ({percentage}%)"}

### E2E Test Boundary Check

**E2E Tests Reviewed**: {count}

**Anti-Patterns Found**:
- {test-name}: Testing error scenario (should be integration test)
- {test-name}: Testing edge case (should be unit test)
- {test-name}: Testing validation (should be unit test)

**E2E Tests Properly Scoped**: {count}/{total} tests are happy path only

**Rating**: ✅ PASS / ⚠️ CONCERNS / ❌ FAIL

### Edge Case Coverage

**Edge Cases in Unit Tests**: ✅ Comprehensive / ⚠️ Partial / ❌ Missing
- {List key edge cases covered in unit tests}

**Error Scenarios in Integration Tests**: ✅ Comprehensive / ⚠️ Partial / ❌ Missing
- {List error scenarios covered in integration tests}

**Edge Cases in E2E Tests** (should be NONE): {count found}
- {List any edge cases incorrectly placed in E2E tests}

### Coverage by Acceptance Criterion

| Acceptance Criterion | Tests Covering It | Status |
|----------------------|-------------------|--------|
| User can login with valid credentials | test_login_valid, test_login_flow_e2e | ✅ Covered |
| Invalid credentials show error | test_login_invalid_password, test_login_invalid_email | ✅ Covered |
| {Criterion} | {Tests} | ⚠️ Partially covered / ❌ Not covered |

**Coverage Gaps**:
- {Gap 1}: {What's not covered}
- {Gap 2}: {What's not covered}

**Edge Cases Tested**:
- ✅ {Edge case 1}: {test name}
- ✅ {Edge case 2}: {test name}
- ❌ {Edge case 3 not tested}: {missing coverage}

**Rating**: ✅ PASS (>80%) / ⚠️ CONCERNS (60-80%) / ❌ FAIL (<60%)

---

## Test Quality

### Test Structure

**Isolation**: ✅ GOOD / ⚠️ SOME ISSUES / ❌ POOR
- {Assessment of test isolation}

**Clarity**: ✅ GOOD / ⚠️ SOME ISSUES / ❌ POOR
- {Assessment of test names and readability}

**AAA Pattern**: ✅ FOLLOWED / ⚠️ MOSTLY / ❌ NOT FOLLOWED
- {Assessment of Arrange-Act-Assert structure}

### Quality Issues

**Good Practices Observed**:
- {Practice 1}: {Example}
- {Practice 2}: {Example}

**Issues Found**:
- {Issue 1}: {Description and location}
  - **Severity**: {Low/Medium/High}
  - **Recommendation**: {How to fix}
- {Issue 2}: {Description and location}
  - **Severity**: {Low/Medium/High}
  - **Recommendation**: {How to fix}

**Rating**: ✅ GOOD / ⚠️ NEEDS IMPROVEMENT / ❌ POOR

---

## Requirements Traceability

**Epic Acceptance Criteria**: {count}
**Criteria with Tests**: {count} / {total}

| Acceptance Criterion | Traced To Tests | Status |
|----------------------|-----------------|--------|
| {Criterion 1} | {test1, test2} | ✅ Fully traced |
| {Criterion 2} | {test3} | ⚠️ Partially traced |
| {Criterion 3} | None | ❌ Not traced |

**Orphan Tests** (tests not mapped to criteria):
- {test name}: {Why is it orphaned? Is it needed?}

**Rating**: ✅ PASS / ⚠️ CONCERNS / ❌ FAIL

---

## Overall Assessment

### Strengths

1. {Strength 1}
2. {Strength 2}
3. {Strength 3}

### Issues to Address

**Critical** (must fix):
1. {Critical issue 1}
2. {Critical issue 2}

**Important** (should fix):
1. {Important issue 1}
2. {Important issue 2}

**Minor** (nice to fix):
1. {Minor issue 1}

---

## Final Rating

**Test-Plan Alignment**: {PASS/CONCERNS/FAIL}
**TDD Compliance**: {PASS/CONCERNS/FAIL}
**Test Coverage**: {PASS/CONCERNS/FAIL}
**Testing Pyramid Compliance**: {GOOD/CONCERNS/POOR}
**E2E Boundary Check**: {PASS/CONCERNS/FAIL}
**Test Quality**: {GOOD/NEEDS IMPROVEMENT/POOR}
**Requirements Traceability**: {PASS/CONCERNS/FAIL}

**Overall**: {PASS / CONCERNS / FAIL}

---

## Recommendations

1. {Recommendation 1}
2. {Recommendation 2}
3. {Recommendation 3}

---

## Approval Decision

**PASS**: All tests align with plan, TDD rules followed, coverage >80%, quality is good

**CONCERNS**: Minor issues found but not blockers. Address issues above and consider re-review.

**FAIL**: Critical issues found (tests changed without justification, major coverage gaps, poor quality). Must address before completing Epic.

**Decision**: {PASS / CONCERNS / FAIL}

{If CONCERNS or FAIL}:
**Required Actions**:
- [ ] {Action 1}
- [ ] {Action 2}
- [ ] Re-run test-reviewer after fixes
