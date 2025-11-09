---
name: trace-requirements
description: Auto-generate traceability matrix showing Mission → PRD → Epic → Tests → Code chain. Use when: - **After Epic completion**: Verify implementation covers all requirements
---


Auto-generate traceability matrix showing Mission → PRD → Epic → Tests → Code chain.

## Purpose

Visualize complete requirement traceability to ensure no requirements are orphaned and all implementation traces to strategic goals.

## When to Use

- **After Epic completion**: Verify implementation covers all requirements
- **During validation**: Check Epic-PRD coverage before planning mode
- **Audit**: Periodic verification of traceability chain
- **Time**: 2-5 min per product
- **Complexity**: All (especially 4-9)

## What This Skill Does

Reads strategic documents and implementation files to generate comprehensive traceability matrix showing:
- Which Mission goals are supported by which PRD requirements
- Which PRD requirements are addressed by which Epics
- Which Epic acceptance criteria have tests
- Which tests cover which code files

---

## Process

### 1. Load Strategic Context

**Read files**:
```
@.aknakos/products/{name}/mission.md
@.aknakos/products/{name}/roadmap.md
@.aknakos/products/{name}/YYYY-MM-DD-prd.md
@.aknakos/products/{name}/YYYY-MM-DD-architecture.md (if exists)
@.aknakos/products/{name}/YYYY-MM-DD-ux-flow.md (if exists)
@.aknakos/products/{name}/epics/*.md (all Epics)
```

### 2. Extract Goals and Requirements

**From mission.md**:
- Product goals (GOAL-1, GOAL-2, etc.)
- Success metrics

**From PRD**:
- All SHALL/MUST requirements (REQ-*)
- Link requirements to mission goals (explicitly or inferred)

**From Epics**:
- Epic names and IDs
- PRD requirement references from frontmatter
- Acceptance criteria

### 3. Trace Implementation (if Epic completed)

**From test files**:
- Test descriptions
- Test file paths
- Coverage of acceptance criteria

**From code files**:
- Implementation files
- Functions/components implementing requirements

### 4. Identify Gaps

**Check for**:
- Mission goals without PRD requirements
- PRD requirements without Epics
- Epics without tests (if Epic status = complete)
- Tests without code (failing tests)
- Code without tests (untested implementation)

### 5. Generate Matrix

**Output**: `.aknakos/products/{name}/traceability-matrix.md`

---

## Traceability Matrix Format

```markdown
# Traceability Matrix

**Product**: {name}
**Generated**: {YYYY-MM-DD}
**Coverage**: Mission → PRD → Epics → Tests → Code

---

## Overview

- **Mission Goals**: {count}
- **PRD Requirements**: {count} (SHALL: {count}, MUST: {count})
- **Epics**: {count} (Complete: {count}, In Progress: {count})
- **Coverage**: {percentage}%

---

## Mission → PRD Mapping

### GOAL-1: {Goal name from mission.md}

**PRD Requirements**:
- REQ-AUTH-001: Email/password authentication
- REQ-AUTH-002: Password complexity requirements
- REQ-SEC-001: TLS encryption

**Coverage**: 100%

### GOAL-2: {Goal name}

**PRD Requirements**:
- REQ-DASH-001: User dashboard
- REQ-DASH-002: Analytics widgets

**Coverage**: 100%

### ⚠️ GOAL-3: {Orphaned goal}

**PRD Requirements**: None

**Status**: ❌ ORPHANED - No PRD requirements support this goal

---

## PRD → Epic Mapping

### REQ-AUTH-001: Email/password authentication

**Epic**: user-authentication (2025-11-08-user-authentication.md)
**Status**: ✅ Complete
**Acceptance Criteria**:
- [x] Users can register with email and password
- [x] Users can login with valid credentials
- [x] Passwords are hashed with bcrypt

**Tests**: 8 tests in `tests/auth/authentication.test.ts`
**Code**: `src/lib/auth/authentication.ts`

### REQ-DASH-001: User dashboard

**Epic**: dashboard (2025-11-09-dashboard.md)
**Status**: 🔄 In Progress
**Acceptance Criteria**:
- [ ] Dashboard displays user stats
- [ ] Dashboard loads within 2 seconds

**Tests**: Not yet written
**Code**: Not yet implemented

### ⚠️ REQ-PERF-001: Response time < 200ms

**Epic**: None

**Status**: ❌ ORPHANED - No Epic addresses this requirement

---

## Epic → Tests → Code Mapping

### Epic: user-authentication

**File**: epics/2025-11-08-user-authentication.md
**Status**: ✅ Complete
**Complexity**: 6

**Acceptance Criteria → Tests**:

1. **Users can register with email and password**
   - ✅ `tests/auth/registration.test.ts`: "should register user with valid email and password"
   - ✅ `tests/auth/registration.test.ts`: "should reject registration with invalid email"
   - Code: `src/lib/auth/registration.ts:12-45`

2. **Users can login with valid credentials**
   - ✅ `tests/auth/login.test.ts`: "should login user with correct credentials"
   - ✅ `tests/auth/login.test.ts`: "should reject login with incorrect password"
   - Code: `src/lib/auth/login.ts:8-34`

3. **Passwords are hashed with bcrypt**
   - ✅ `tests/auth/password.test.ts`: "should hash password before storage"
   - ✅ `tests/auth/password.test.ts`: "should verify password against hash"
   - Code: `src/lib/auth/password-utils.ts:15-28`

**Test Coverage**: 100% (8/8 acceptance criteria have tests)
**Code Coverage**: 92% (from test run)

### Epic: dashboard

**File**: epics/2025-11-09-dashboard.md
**Status**: 🔄 Planning
**Complexity**: 4

**Acceptance Criteria → Tests**:
- Not yet planned

---

## Gaps and Orphans

### Orphaned Mission Goals
- GOAL-3: {Goal name} - No PRD requirements

### Orphaned PRD Requirements
- REQ-PERF-001: Response time < 200ms - No Epic

### Untested Acceptance Criteria
- None (all completed Epics have tests)

### Failing Tests
- None

### Untested Code
- `src/lib/dashboard/stats.ts` - No tests found (dashboard Epic in progress)

---

## Summary

**Traceability Health**: 85% ⚠️

**Strengths**:
- All completed Epics have full test coverage
- Mission → PRD alignment strong
- TDD process followed correctly

**Issues**:
- 1 orphaned mission goal (GOAL-3)
- 1 orphaned PRD requirement (REQ-PERF-001)
- 2 Epics in progress (expected)

**Recommendations**:
1. Create Epic for REQ-PERF-001 or remove from PRD
2. Add PRD requirements for GOAL-3 or update mission
3. Complete dashboard Epic to improve coverage to 100%

---

## Traceability Chain Visualization

```
Mission Goals (4)
  ↓
PRD Requirements (12)
  ↓
Epics (3)
  ↓
Test Specifications (24)
  ↓
Tests (24)
  ↓
Code Files (8)

Coverage: 85% (10/12 requirements traced to Epics)
```
```

---

## Matrix Generation Logic

### Mission → PRD

**Extract goals from mission.md**:
- Look for "Goals", "Objectives", or "Success Metrics" sections
- Assign GOAL-1, GOAL-2, etc.

**Link to PRD**:
- Check if PRD explicitly references goals
- Infer links from requirement descriptions
- Flag goals with no PRD requirements

### PRD → Epic

**Extract requirements**:
- Find all SHALL/MUST statements in PRD
- Extract REQ-* identifiers

**Link to Epics**:
- Read Epic frontmatter `prd_references` field
- Check Epic description for REQ-* mentions
- Flag requirements with no Epic coverage

### Epic → Tests

**Extract acceptance criteria**:
- Parse Epic acceptance criteria section
- Number criteria AC-1, AC-2, etc.

**Link to tests**:
- Search test files for test descriptions matching criteria
- Check test file comments for AC-* references
- Flag criteria without tests (if Epic status = complete)

### Tests → Code

**Extract test files**:
- Find all test files (*.test.ts, *.spec.ts, etc.)
- Parse test descriptions

**Link to code**:
- Check import statements in tests
- Identify code files under test
- Flag tests without corresponding code (failing tests)

---

## Update Workflow State

After generating matrix, update `.aknakos/state/workflow.yaml`:

```yaml
products:
  my-product:
    traceability:
      last_generated: "2025-11-08"
      matrix_file: "traceability-matrix.md"
      coverage_percentage: 85
      orphaned_goals: 1
      orphaned_requirements: 1
      gaps_count: 2
```

---

## Use Cases

### Use Case 1: Epic Validation

**Before**: Phase 3.5 validation
**Purpose**: Verify Epic-PRD coverage
**Focus**: PRD → Epic section only

```
Run trace-requirements skill focusing on PRD-Epic mapping.
Check for orphaned PRD requirements before planning mode.
```

### Use Case 2: Epic Completion Audit

**After**: Phase 7 epic completion
**Purpose**: Verify implementation completeness
**Focus**: Full chain (Mission → Code)

```
Run trace-requirements skill with full traceability chain.
Verify all acceptance criteria have tests and code.
```

### Use Case 3: Product Audit

**Anytime**: Periodic review
**Purpose**: Overall product health check
**Focus**: Gaps and orphans

```
Run trace-requirements skill to identify:
- Mission goals without implementation
- PRD requirements without Epics
- Acceptance criteria without tests
```

---

## Integration with Other Skills

**Complements**:
- `validate-alignment`: Uses PRD → Epic mapping
- `epic-review`: Uses Epic → Tests → Code mapping
- `validate-state`: Verifies files referenced in matrix exist

**Workflow**:
1. Phase 3.5: `validate-alignment` checks alignment
2. Phase 3.5: `trace-requirements` generates coverage matrix
3. Phase 7: `epic-review` updates matrix with implementation details

---

## Tips for Success

- **Run regularly**: After Epic breakdown, after Epic completion, periodically
- **Focus on gaps**: Orphaned goals/requirements are red flags
- **Track coverage**: Aim for 95%+ PRD-Epic coverage
- **Use for audits**: Show stakeholders complete traceability
- **Lightweight**: Matrix generation is automated, takes 2-5 min

---

## Common Scenarios

### Scenario 1: Found orphaned PRD requirement

**Action**:
1. Create Epic for requirement, OR
2. Remove requirement from PRD (with justification)

### Scenario 2: Found orphaned mission goal

**Action**:
1. Add PRD requirements supporting goal, OR
2. Update mission to remove goal

### Scenario 3: Found untested acceptance criteria

**Action**:
1. Write missing tests (TDD RED phase), OR
2. Update Epic status to "in_progress" (not complete yet)

---

## Example Output Files

See example at: `products/task-manager/traceability-matrix.md` (once example product created)

---

## What's Next

After generating traceability matrix:
- Review gaps and take action
- Update workflow.yaml with coverage stats
- Use `validate-state` to verify file consistency
