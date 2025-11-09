---
name: escalate-conflict
description: Handle conflicts when lower-level work requires changing upper-level strategic decisions. Use when: **Trigger Situations**:
---


Handle conflicts when lower-level work requires changing upper-level strategic decisions.

## Purpose

**Block-and-escalate pattern** for alignment conflicts: Stop work → Update parent doc → Re-validate → Resume.

## When to Use

**Trigger Situations**:
1. Validation fails due to PRD/architecture issues (not Epic issues)
2. During planning mode: Realization that PRD is wrong or incomplete
3. During implementation: Tech stack doesn't work as planned
4. Epic-level work reveals flawed architecture decisions

**Philosophy**: Strategic docs are guidance, not unchangeable. But changes require formal updates and re-validation.

---

## Conflict Types

### Type 1: Requirements Conflict

**Scenario**: PRD requirements contradict each other or are impossible to implement together

**Example**:
```
PRD REQ-PERF-001: System SHALL respond within 100ms
PRD REQ-FEAT-005: System SHALL perform complex ML inference on every request

These conflict - ML inference cannot consistently complete in 100ms
```

**Resolution**: Update PRD to reconcile contradiction

---

### Type 2: Architecture Inadequacy

**Scenario**: Architecture doesn't support required functionality

**Example**:
```
PRD requires real-time collaboration (WebSockets)
architecture.md specifies serverless architecture (not ideal for persistent connections)

Architecture needs update to support requirement
```

**Resolution**: Update architecture.md with new approach

---

### Type 3: Tech Stack Limitation

**Scenario**: Chosen tech stack cannot achieve requirements

**Example**:
```
tech-stack.md specifies MongoDB
PRD requires complex relational queries with transactions
MongoDB makes this unnecessarily difficult

Need to switch to PostgreSQL
```

**Resolution**: Update tech-stack.md with new choice and rationale

---

### Type 4: Mission-PRD Misalignment

**Scenario**: PRD doesn't actually support mission goals

**Example**:
```
mission.md: "Keep product simple and accessible"
PRD: Includes 15 complex admin features in MVP

PRD violates mission principle
```

**Resolution**: Update PRD to align with mission OR update mission if priorities changed

---

### Type 5: Scope Expansion

**Scenario**: Implementation reveals missing requirements

**Example**:
```
During Epic work, realize PRD missing "password reset" functionality
User authentication incomplete without it

PRD needs requirement addition
```

**Resolution**: Add missing requirement to PRD

---

## Escalation Workflow

### Step 1: Stop Work

**Immediate Action**: Stop current phase

- If in validation: Document conflict in validation report (Status: FAIL)
- If in planning mode: Exit planning mode
- If in implementation: Stop coding

**Why**: Prevent building on flawed foundation

---

### Step 2: Document Conflict

**Create conflict report**:

Location: `.aknakos/products/{name}/reviews/conflicts/YYYY-MM-DD-conflict-{type}.md`

**Template**:
```markdown
# Conflict Report

**Date**: {YYYY-MM-DD}
**Type**: {Requirements/Architecture/Tech Stack/Mission/Scope}
**Phase**: {Validation/Planning/Implementation}
**Severity**: {Critical/High/Medium}

---

## Conflict Description

{Clear description of the conflict}

---

## Affected Documents

**Upper-level doc that needs change**:
- [ ] mission.md
- [ ] project-brief.md
- [ ] architecture.md
- [ ] tech-stack.md
- [ ] prd.md

**Lower-level work affected**:
- Epic: {Epic name}
- Story/Task: {If applicable}

---

## Current State

**What's documented** (in upper-level doc):
{Quote current spec/requirement}

**What's needed** (for lower-level work):
{What should be instead}

---

## Why This is a Conflict

{Explain incompatibility}

---

## Impact

**If not resolved**:
- {Impact on product}
- {Impact on timeline}
- {Impact on technical quality}

---

## Proposed Resolution

### Option 1: {Resolution approach}
- **Change required**: {Update to upper-level doc}
- **Pros**: {Benefits}
- **Cons**: {Drawbacks}
- **Impact**: {Scope of change}

### Option 2: {Alternative resolution}
- **Change required**: {Different update}
- **Pros**: {Benefits}
- **Cons**: {Drawbacks}
- **Impact**: {Scope of change}

### Recommended: {Option 1 or 2}

**Rationale**: {Why this option}

---

## Resolution Plan

1. {Action 1}
2. {Action 2}
3. {Action 3}

**Estimated time**: {Time to resolve}

---

## Approval

**Requires approval from**: {Stakeholder/User}
**Approved**: {Yes/No/Pending}
**Approved by**: {Name}
**Date**: {YYYY-MM-DD}
```

---

### Step 3: Determine Required Change

**Identify which upper-level document needs updating**:

**Decision Tree**:

```
Is it a product vision/goal issue?
  → Update mission.md

Is it a market/user understanding issue?
  → Update project-brief.md (if exists)

Is it a technical architecture issue?
  → Update architecture.md

Is it a specific tech stack choice issue?
  → Update tech-stack.md

Is it a functional/non-functional requirement issue?
  → Update prd.md
```

---

### Step 4: Present Options to User

**Use `AskUserQuestion` tool** to present resolution options:

**Example**:
```
Conflict: PRD requires <100ms response time, but ML inference needs ~500ms

Options:
A) Relax performance requirement to <500ms
B) Move ML inference to async background job
C) Use simpler ML model that can run <100ms

Which approach should we take?
```

Get user decision before proceeding.

---

### Step 5: Update Parent Document

**After approval, update the affected document**:

**Process**:
1. Use Edit tool to update document
2. Add change rationale section:

```markdown
## Change History

### {YYYY-MM-DD}: {Change description}

**Reason**: {Why this change was needed}
**Conflict**: See `reviews/conflicts/YYYY-MM-DD-conflict-{type}.md`
**Impact**: {What changed downstream}
**Approved by**: {Stakeholder}
```

3. Version update (increment version number)

---

### Step 6: Re-Validate

**After parent doc updated**:

**If PRD changed**:
- Re-run `validate-alignment` skill
- Ensure Epics still align with updated PRD

**If architecture/tech-stack changed**:
- Review all Epics for architecture compliance
- Update Epic acceptance criteria if needed

**If mission changed**:
- Verify all downstream docs align with new mission

---

### Step 7: Resume Work

**Only after re-validation passes**:

- If in validation phase: Continue with validated Epics
- If in planning mode: Re-enter with updated context
- If in implementation: Adjust implementation to new spec

**Update workflow.yaml**:
```yaml
conflicts_escalated:
  - date: "{YYYY-MM-DD}"
    type: "{Type}"
    resolution: "{Brief description}"
    documents_updated:
      - "{Doc 1}"
      - "{Doc 2}"
    status: "resolved"
```

---

## Examples

### Example 1: Tech Stack Change

**Conflict**:
```
Epic "User Management" requires complex relational queries with ACID transactions
tech-stack.md specifies MongoDB (document database, eventual consistency)
```

**Escalation**:
1. **Stop**: Exit Epic breakdown
2. **Document**: Create conflict report
3. **Identify**: tech-stack.md needs update
4. **Options**:
   - Option A: Switch to PostgreSQL (ACID guarantees)
   - Option B: Keep MongoDB, simplify data model
5. **Decision**: Option A (user chooses PostgreSQL)
6. **Update**: Edit tech-stack.md:
   ```markdown
   ### Database
   - **Primary Database**: PostgreSQL 15
     - **Rationale**: Complex relational queries, ACID transactions required for user management
     - **Changed from**: MongoDB (2025-11-08 - requirements needed relational features)
   ```
7. **Re-validate**: Check all Epics use PostgreSQL now
8. **Resume**: Continue Epic breakdown with PostgreSQL

---

### Example 2: PRD Requirements Conflict

**Conflict**:
```
PRD REQ-PERF-001: System SHALL respond within 100ms (95th percentile)
PRD REQ-FEAT-010: System SHALL perform sentiment analysis on user posts

Sentiment analysis ML model takes 300-500ms
```

**Escalation**:
1. **Stop**: Exit planning mode
2. **Document**: Conflict report
3. **Identify**: PRD needs update (conflicting requirements)
4. **Options**:
   - Option A: Relax performance to 500ms
   - Option B: Move sentiment analysis to async background job
   - Option C: Use faster but less accurate model
5. **Decision**: Option B (user prefers accuracy + speed)
6. **Update**: Edit prd.md:
   ```markdown
   **REQ-PERF-001**: The system SHALL respond to user requests within 100ms (95th percentile)

   **REQ-FEAT-010**: The system SHALL perform sentiment analysis on user posts asynchronously within 5 seconds of posting
   **Changed** (2025-11-08): Made async to meet performance requirements without sacrificing accuracy
   ```
7. **Re-validate**: Verify Epics now include async job handling
8. **Resume**: Re-enter planning mode

---

### Example 3: Scope Expansion

**Conflict**:
```
During "User Authentication" Epic planning, realize PRD missing "password reset" feature
Authentication incomplete without it
```

**Escalation**:
1. **Stop**: Note missing requirement
2. **Document**: Conflict report (Type: Scope Expansion)
3. **Identify**: PRD needs new requirement
4. **Options**:
   - Option A: Add password reset to PRD and Epic
   - Option B: Defer to post-MVP (users can contact support)
5. **Decision**: Option A (critical for MVP)
6. **Update**: Add to prd.md:
   ```markdown
   **REQ-AUTH-006**: The system SHALL provide self-service password reset via email verification
   **Added** (2025-11-08): Discovered during Epic planning as critical gap
   ```
7. **Re-validate**: Update Epic acceptance criteria to include password reset
8. **Resume**: Continue planning with complete requirements

---

## Severity Levels

### Critical
- Product cannot launch without resolution
- Major architecture incompatibility
- Mission-critical requirement conflict

**Action**: MUST resolve before proceeding

---

### High
- Significant technical risk
- User experience degradation
- Performance/security concern

**Action**: Should resolve before proceeding, can proceed with documented risk

---

### Medium
- Nice-to-have feature missing
- Minor spec inconsistency
- Optimization opportunity

**Action**: Can proceed, address in future iteration

---

## Conflict Prevention

**How to avoid conflicts**:

1. **Thorough strategic planning**: Use conversational skills (create-project-brief, create-architecture-doc)
2. **Run validation early**: Don't skip validate-alignment
3. **Prototype risky decisions**: Test assumptions before committing
4. **Regular alignment checks**: Review mission/PRD periodically

---

## Integration with Workflow

**Validation Phase**:
- Conflict detected → escalate-conflict skill
- Update docs → re-run validate-alignment

**Planning Mode**:
- Conflict detected → exit planning mode
- Escalate → update docs → re-enter planning mode

**Implementation Phase**:
- Conflict detected → stop implementation
- Escalate → update docs → resume with new spec

---

## Update Workflow State

After conflict resolution:

```yaml
products:
  - name: {product-name}
    conflicts:
      - date: "YYYY-MM-DD"
        type: "{Requirements/Architecture/etc}"
        severity: "{Critical/High/Medium}"
        affected_docs:
          - "{mission.md}"
          - "{prd.md}"
        status: "resolved"
        resolution_file: ".aknakos/products/{name}/reviews/conflicts/YYYY-MM-DD-conflict.md"
```

---

## Related Skills

- `validate-alignment`: Catches conflicts early
- `create-prd`, `create-architecture-doc`: Update strategic docs
- `whats-next`: Shows next action after resolution
