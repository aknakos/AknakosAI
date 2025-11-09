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
