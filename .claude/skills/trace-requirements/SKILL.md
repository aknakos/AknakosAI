---
name: trace-requirements
description: Auto-generate traceability matrix showing Mission → PRD → Epic → Tests → Code chain. Visualize complete requirement traceability to ensure no requirements are orphaned and all implementation traces to strategic goals. Use after Epic completion (verify implementation), during validation (check Epic-PRD coverage), periodic audits.
---

## Instructions

Generate comprehensive traceability matrix linking strategic goals to implementation.

### When to Use

**Use**: After Epic completion (verify implementation covers requirements), during validation (check Epic-PRD coverage before planning mode), periodic audits (verify traceability chain)

**Don't Use**: No PRD exists, no Epics defined

**Time**: 2-5 min per product

**Complexity**: All (especially 4-9)

### Process

**Step 1: Load Strategic Context**

Read files:
```
.aknakos/products/{name}/mission.md
.aknakos/products/{name}/roadmap.md
.aknakos/products/{name}/YYYY-MM-DD-prd.md
.aknakos/products/{name}/YYYY-MM-DD-architecture.md (if exists)
.aknakos/products/{name}/YYYY-MM-DD-ux-flow.md (if exists)
.aknakos/products/{name}/epics/*.md (all Epics)
```

**Step 2: Extract Goals and Requirements**

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

**Step 3: Trace Implementation** (if Epic completed)

**From test files**:
- Test descriptions
- Test file paths
- Coverage of acceptance criteria

**From code files**:
- Implementation files
- Functions/components implementing requirements

**Step 4: Identify Gaps**

Check for:
- Mission goals without PRD requirements (orphaned goals)
- PRD requirements without Epics (orphaned requirements)
- Epics without tests (if Epic status = complete)
- Tests without code (failing tests)
- Code without tests (untested implementation)

**Step 5: Generate Matrix**

Use template: `.aknakos/templates/reports/traceability-matrix.md`

**Sections**:
- Overview (counts: goals, requirements, Epics, coverage %)
- Mission → PRD Mapping (per goal: linked requirements, coverage %, orphaned status)
- PRD → Epic Mapping (per requirement: Epic, status, acceptance criteria, tests, code, orphaned status)
- Epic → Tests → Code Mapping (per Epic: acceptance criteria → tests → code files, test coverage %, code coverage %)
- Gaps and Orphans (orphaned goals, orphaned requirements, untested criteria, failing tests, untested code)
- Summary (traceability health %, strengths, issues, recommendations)
- Traceability Chain Visualization (flowchart showing coverage)

**Save to**: `.aknakos/products/{name}/traceability-matrix.md`

### Matrix Generation Logic

**Mission → PRD**:
- Extract goals from mission.md (look for "Goals", "Objectives", "Success Metrics" sections)
- Assign GOAL-1, GOAL-2, etc.
- Check if PRD explicitly references goals or infer links from requirement descriptions
- Flag goals with no PRD requirements (orphaned)

**PRD → Epic**:
- Find all SHALL/MUST statements in PRD, extract REQ-* identifiers
- Read Epic frontmatter `prd_references` field
- Check Epic description for REQ-* mentions
- Flag requirements with no Epic coverage (orphaned)

**Epic → Tests**:
- Parse Epic acceptance criteria section, number criteria AC-1, AC-2, etc.
- Search test files for test descriptions matching criteria
- Check test file comments for AC-* references
- Flag criteria without tests (if Epic status = complete)

**Tests → Code**:
- Find all test files (*.test.ts, *.spec.ts, etc.)
- Parse test descriptions
- Check import statements in tests to identify code files under test
- Flag tests without corresponding code (failing tests)

### Update Workflow State

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

### Use Cases

**Use Case 1: Epic Validation** (Before Phase 3.5)
- **Purpose**: Verify Epic-PRD coverage
- **Focus**: PRD → Epic section only
- **Action**: Check for orphaned PRD requirements before planning mode

**Use Case 2: Epic Completion Audit** (After Phase 7)
- **Purpose**: Verify implementation completeness
- **Focus**: Full chain (Mission → Code)
- **Action**: Verify all acceptance criteria have tests and code

**Use Case 3: Product Audit** (Periodic review)
- **Purpose**: Overall product health check
- **Focus**: Gaps and orphans
- **Action**: Identify mission goals without implementation, PRD requirements without Epics, acceptance criteria without tests

### Common Scenarios

**Scenario 1: Found orphaned PRD requirement**

**Actions**:
1. Create Epic for requirement, OR
2. Remove requirement from PRD (with justification)

**Scenario 2: Found orphaned mission goal**

**Actions**:
1. Add PRD requirements supporting goal, OR
2. Update mission to remove goal

**Scenario 3: Found untested acceptance criteria**

**Actions**:
1. Write missing tests (TDD RED phase), OR
2. Update Epic status to "in_progress" (not complete yet)

### Integration

**Complements**:
- `validate-alignment`: Uses PRD → Epic mapping for alignment validation
- `epic-review`: Uses Epic → Tests → Code mapping for retrospective
- `validate-state`: Verifies files referenced in matrix exist

**Workflow**:
1. Phase 3.5: `validate-alignment` checks alignment
2. Phase 3.5: `trace-requirements` generates coverage matrix
3. Phase 7: `epic-review` updates matrix with implementation details

**Output**: `.aknakos/products/{name}/traceability-matrix.md`

**Coverage Target**: Aim for 95%+ PRD-Epic coverage

**Related Skills**: validate-alignment (Epic-PRD alignment), epic-review (Epic retrospective), validate-state (file consistency)
