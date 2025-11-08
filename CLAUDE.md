Always sacrifice grammar for the sake of conciseness and clarity.

# Aknakos Framework - AI Agent Framework for Claude Code

**Version**: 1.0
**Purpose**: Hybrid framework balancing strategic depth with implementation speed, optimized for Claude Code.

## Core Principles

1. **Graduated Complexity**: Heavy docs for strategy, lightweight for implementation
2. **Strategic Depth + Implementation Speed**: BMAD-style planning with OpenSpec-style execution
3. **TDD by Default**: Test-driven development integrated into every cycle
4. **Claude Code Native**: Uses Claude's planning mode, not rigid agent workflows
5. **Adaptive Review**: Review intensity matches risk and complexity
6. **Parallel When Beneficial**: Spawn agents for research/review, keep implementation focused

## Workflow Overview

**Strategic** (Vision → PRD): Conversational, exploratory, thorough
**Planning** (PRD → Epic): Formal documentation with acceptance criteria
**Implementation** (Epic → Code): Fast TDD cycles using planning mode
**Review**: Automated parallel review agents

---

## Workflow Phases

### Phase 1-3: Strategic Planning

**Phase 1 - Vision**: Use `elicitation`, `product-vision`, or `architecture` skills. Spawn `market-research` or `competitive-analysis` agents if needed. Output: Clear vision (conversational, not saved).

**Phase 2 - PRD**: Use `create-prd` skill to generate formal requirements doc using SHALL/MUST language. Save to `products/{product-name}/YYYY-MM-DD-prd.md`. Strategic review before proceeding.

**Phase 3 - Epic Breakdown**: Use `epic-breakdown` skill to create Epics from PRD. Each Epic: name, description, acceptance criteria, dependencies, complexity (1-9). Save to `products/{product-name}/epics/YYYY-MM-DD-epic-name.md`. Optional: Use `epic-parallel` agent for multiple Epics simultaneously.

### Phase 4: Planning Mode

Enter planning mode (Shift+Tab twice) to break Epic into Stories/Tasks/Test Specs.

**Context gathering**:
- Small scope (2-5 files): @-mentions or Explore subagent
- Medium scope: Explore subagent in planning mode
- Large scope: Exit, spawn `context-gatherer` agent, review results, re-enter planning

**Create** (ephemeral, not saved as files):
- Stories: description, acceptance criteria, dependencies
- Tasks: specific code changes
- **Test Specifications** (CRITICAL): Unit/integration/E2E tests mapped to acceptance criteria

Optional: Save plan to `products/{product-name}/plans/epic-name/YYYY-MM-DD-plan.md` if complex/multi-session.

### Phase 5: TDD Implementation

**TDD Cycle**: PLAN → RED → REVIEW → GREEN → REFACTOR → REVIEW

**RED (Write Tests)**:
- Write ALL tests before implementation
- Tests MUST fail initially (no implementation exists)
- Follow test specifications from plan
- Verify: All tests fail (RED state)

**REVIEW (Tests vs Plan)**:
- Compare tests against plan's test specifications
- Verify coverage of acceptance criteria and edge cases
- ✅ Match → Proceed | ❌ Don't match → Fix tests OR update plan

**GREEN (Implement)**:
- Implement code to make tests pass
- **CRITICAL: DO NOT CHANGE TESTS during implementation**
- If tests need changes: STOP, update plan with justification, then update tests
- Track: `tests_changed_during_implementation: false` in workflow.yaml

**REFACTOR (Improve)**:
- Improve code quality while keeping tests passing
- Optional: Skip if quality already good

### Phase 6: Automated Review

**Triggers automatically** after TDD completes. 5 parallel agents:

1. **test-reviewer**: Tests unchanged, good coverage, match plan
2. **security-reviewer**: Security audit (auth, data, vulnerabilities)
3. **architecture-reviewer**: Design consistency, patterns, tech debt
4. **quality-reviewer**: Code quality, maintainability, standards
5. **requirements-reviewer**: Acceptance criteria completeness

**Review Tiers** (complexity-based):
- Trivial (1-3): Quick scan, auto-approve if PASS
- Moderate (4-6): Thorough analysis, human review if CONCERNS
- Complex (7-9): Deep audit, human review required

Reports saved to `products/{product-name}/reviews/epic-name/`. Decision: PASS/CONCERNS/FAIL.

### Phase 7: Epic Completion

Use `epic-review` skill to synthesize review reports, extract learnings, identify patterns. Save retrospective to `products/{product-name}/reviews/epic-reviews/YYYY-MM-DD-epic-name-review.md`.

---

## Skills & Agents

**Skills** (stay in main context): See `.aknakos/skills/` for full definitions
- `elicitation`, `product-vision`, `architecture`: Strategic planning
- `create-prd`: Generate formal PRD
- `epic-breakdown`: Break PRD into Epics
- `whats-next`: Show next actions based on workflow state
- `context-scope`: Decide if Context agent needed
- `epic-review`: Synthesize review reports

**Agents** (parallel, separate contexts): See `.aknakos/agents/` for full definitions

*Research*: `market-research`, `tech-exploration`, `epic-parallel`, `context-gatherer`
*Review*: `test-reviewer`, `security-reviewer`, `architecture-reviewer`, `quality-reviewer`, `requirements-reviewer` (auto-triggered after TDD)

---

## TDD Critical Rules

**DO**:
- ✅ Write ALL tests before implementation
- ✅ Ensure tests fail initially
- ✅ Review tests against plan before implementing
- ✅ Keep tests passing during refactoring

**DON'T**:
- ❌ Change tests during implementation (Phase 5 GREEN)
- ❌ Skip test specifications in planning mode
- ❌ Implement before tests written

**Test Change Exceptions**: Only during test writing, test review, or after automated review identifies issues. If needed during implementation: STOP, update plan with justification, mark `tests_changed_during_implementation: true`.

---

## Alternatives Pattern

**When**: Present alternatives for tech/architecture decisions (frameworks, databases, patterns, auth methods, state management).

**Process**:
1. Identify 2-3 viable options
2. Use `tech-exploration` agent for comparison (optional)
3. Use `AskUserQuestion` tool: Option A/B/C with pros/cons/complexity
4. Document choice with one-line rationale in PRD or Epic

**DO**: Auto-detect multiple options, always present for tech decisions, brief rationale
**DON'T**: Present for trivial decisions, over-document, skip for architecture choices

---

## State Management

**Location**: `.aknakos/state/workflow.yaml`

Tracks: framework version, current phase, products, PRDs, Epics, TDD status, reviews, next actions.

**Phases**: vision → prd → epic_breakdown → planning_mode → tdd_tests_written → tdd_test_review → tdd_implementation → tdd_refactor → review → epic_complete

**Query**: Use `whats-next` skill for current state and next actions.
**Update**: Edit workflow.yaml manually.

See workflow.yaml file for structure example.

---

## Context Strategy

**Single file**: @-mentions in planning mode
**Small scope (2-5 files)**: Planning mode Explore subagent
**Medium scope**: @-mentions for PRD + architecture docs
**Large scope**: Spawn `context-gatherer` agent

**Planning Mode Tools** (read-only): Read, Glob, Grep, Explore

Use `context-scope` skill to determine strategy.

---

## File Structure

```
.aknakos/
├── state/workflow.yaml
├── skills/*.md
├── agents/**/*.md
└── templates/*.md

products/{product-name}/
├── YYYY-MM-DD-prd.md
├── epics/YYYY-MM-DD-epic-name.md
├── plans/epic-name/YYYY-MM-DD-plan.md
└── reviews/epic-name/YYYY-MM-DD-*-review.md
```

**Naming**: Date prefix (`YYYY-MM-DD-`), lowercase with hyphens.

---

## Quick Reference

**Workflow**: Vision → PRD → Epics → Plan (Shift+Tab×2) → Tests (RED) → Review Tests → Implement (GREEN) → Refactor → Automated Review → Complete

**Commands**:
- Enter planning mode: Shift+Tab twice
- Check status: `whats-next` skill
- Spawn agent: "Spawn {agent-name} agent"

**Key Rules**:
- Write tests before implementation
- Review tests against plan
- NEVER change tests during implementation
- Use planning mode for Stories/Tasks
- Let review agents run automatically

**Troubleshooting**:
- Lost? → `whats-next` skill
- Need context? → `context-scope` skill
- Tests need changes during implementation? → STOP, update plan, then update tests

---

## Version History

**v1.0** (2025-11-08): Initial release - Graduated complexity, TDD workflow, parallel reviews, context strategy, planning mode integration

---

*For detailed definitions, see `.aknakos/skills/` and `.aknakos/agents/` directories.*
