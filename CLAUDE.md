# Aknakos Framework - AI Agent Framework for Claude Code

**Version**: 1.0
**Purpose**: Hybrid framework balancing strategic depth with implementation speed, optimized for Claude Code.

---

## Framework Philosophy

### Core Principles

1. **Graduated Complexity**: Heavy docs for strategy, lightweight for implementation
2. **Strategic Depth + Implementation Speed**: BMAD-style planning with OpenSpec-style execution
3. **TDD by Default**: Test-driven development integrated into every implementation cycle
4. **Claude Code Native**: Uses Claude's planning mode and native capabilities, not rigid agent workflows
5. **Adaptive Review**: Review intensity matches risk and complexity
6. **Parallel When Beneficial**: Spawn agents for research and review, keep implementation focused

### The Balance

- **Strategic work** (Vision → PRD): Conversational, exploratory, thorough
- **Planning work** (PRD → Epic): Formal documentation with clear acceptance criteria
- **Implementation work** (Epic → Code): Fast TDD cycles using Claude planning mode
- **Review work**: Automated parallel review agents

---

## Workflow Phases

### Phase 1: Strategic Vision (High-Level Planning)

**When**: Starting new product or major feature direction

**Tools**:
- Skills: `elicitation`, `product-vision`, `architecture`
- Agents: `market-research`, `competitive-analysis` (parallel)

**Process**:
1. Use `elicitation` or `product-vision` skill for product goals, target users, value proposition
2. Spawn parallel research agents if needed (market research, competitive analysis)
3. Use `architecture` skill for tech stack, patterns

**Artifacts**: Conversational (stays in context, not saved as files)

**Output**: Clear product vision and architectural direction

---

### Phase 2: PRD Creation (Requirements Documentation)

**When**: After vision clear, before breaking into Epics

**Tools**: Skill `create-prd`

**Process**:
1. Use `create-prd` skill to generate formal Product Requirements Document
2. PRD uses SHALL/MUST language (formal requirements)
3. Includes acceptance criteria, constraints, success metrics
4. References architecture decisions from Phase 1

**Artifacts**: File `products/{product-name}/YYYY-MM-DD-prd.md` (formal with SHALL/MUST)

**Formality**: HIGH (last heavy documentation)

**Review**: Strategic review before proceeding

**Output**: Approved PRD ready for Epic breakdown

---

### Phase 3: Epic Breakdown

**When**: After PRD approved

**Tools**:
- Skill: `epic-breakdown`
- Optional Agents: `epic-parallel` (multiple Epics simultaneously), `context-gatherer` (large codebase)

**Process**:
1. Read PRD
2. Use `context-scope` skill to determine if Context agent needed or planning mode Explore sufficient
3. Use `epic-breakdown` skill to create Epics from PRD
4. Each Epic: name, description, acceptance criteria, dependencies, complexity estimate

**Artifacts**: Files `products/{product-name}/epics/YYYY-MM-DD-epic-name.md` (lightweight)

**Output**: Set of Epics ready for planning mode

---

### Phase 4: Planning Mode (Epic → Stories → Tasks → Test Specs)

**When**: Ready to implement an Epic

**Tools**: **Claude Code Native Planning Mode** (Shift+Tab twice)

**Process**:
1. Enter planning mode (Shift+Tab twice)
2. Read Epic file: `products/{product-name}/epics/YYYY-MM-DD-epic-name.md`
3. Gather context:
   - Small scope (2-5 files): Use @-mentions or planning mode Explore
   - Medium scope: Planning mode Explore subagent
   - Large scope: Exit, spawn Context agent, review results, re-enter planning mode
4. Create Stories (ephemeral - not saved as files):
   - Description
   - Acceptance criteria
   - Dependencies
5. Create Tasks (ephemeral - not saved):
   - Specific code changes
6. **Create Test Specifications** (CRITICAL):
   - Unit tests: What units to test, behaviors to verify
   - Integration tests: Integrations to test, interactions to verify
   - E2E tests: User flows to test
   - Map tests to acceptance criteria
   - Specify expected behaviors and edge cases
7. Optional: Save to `products/{product-name}/plans/epic-name/YYYY-MM-DD-plan.md` if complex/multi-session

**Output**: Complete implementation plan ready for TDD cycle

---

### Phase 5: TDD Implementation Cycle ⭐ TEST-DRIVEN DEVELOPMENT

**Tools**: Native Claude Code (no planning mode, direct implementation)

**TDD Cycle: RED → GREEN → REFACTOR**

#### Phase 5a: Write Tests First (RED)

**Process**:
1. Read plan with test specifications
2. Write ALL tests first (before any implementation code)
3. Tests follow test specifications from plan
4. Tests MUST fail initially (no implementation exists yet)

**Rules**:
- Write unit tests first, then integration, then E2E
- Each test verifies one acceptance criterion
- Tests isolated, clear, comprehensive

**Verification**: Run tests → all FAIL (RED). If pass without implementation, tests wrong.

**Artifacts**: Test files written, all failing

---

#### Phase 5b: Review Tests vs Plan

**Purpose**: Ensure tests match plan before implementing

**Process**:
1. Compare written tests against plan's test specifications
2. Verify:
   - All acceptance criteria have corresponding tests
   - Tests cover edge cases mentioned in plan
   - Test quality good (clear, isolated, maintainable)
   - Tests fail as expected (RED)

**Decision**:
- ✅ Tests match plan → Proceed to implementation (Phase 5c)
- ❌ Tests don't match → Fix tests OR update plan (with justification)

**Output**: Approved tests ready for implementation

---

#### Phase 5c: Implement Code (GREEN)

**Process**:
1. Implement code to make tests pass
2. Follow original plan
3. Run tests continuously (watch them turn green)
4. **CRITICAL RULE: DO NOT CHANGE TESTS**

**Rules**:
- Implement only enough to make tests pass
- If tests need changes during implementation:
  - **STOP** immediately
  - Either: Justify why plan wrong, update plan, then update tests
  - OR: Recognize implementation approach wrong, try different approach
- Tests are contract; implementation serves tests

**Verification**: Run tests → all PASS (GREEN). All acceptance criteria met.

**Artifacts**: Working code with passing tests. Track: `tests_changed_during_implementation: false` in workflow.yaml

---

#### Phase 5d: Refactor (REFACTOR)

**Purpose**: Improve code quality while maintaining passing tests

**Process**:
1. Improve structure, readability, performance
2. Eliminate duplication
3. Apply design patterns
4. Run tests after each change

**Rules**:
- Tests NEVER change during refactoring
- Tests must remain passing (GREEN)
- Only code quality improvements

**Optional**: Skip if code quality already good

**Output**: Clean, tested code ready for review

---

### Phase 6: Review (INTEGRATED, REQUIRED, PARALLEL)

**When**: Automatically triggered after TDD implementation completes

**Tools**: 5 Parallel Review Agents

**Agents**:
1. **test-reviewer**: Verify tests weren't changed, coverage good, tests match plan
2. **security-reviewer**: Security audit (auth, data protection, vulnerabilities)
3. **architecture-reviewer**: Design consistency, patterns, tech debt
4. **quality-reviewer**: Code quality, maintainability, standards
5. **requirements-reviewer**: Acceptance criteria completeness

**Process**:
1. All 5 agents spawn in parallel (separate contexts)
2. Each agent reviews its specific aspect
3. Each produces review report

**Artifacts**: 5 review reports saved to `products/{product-name}/reviews/epic-name/`

**Review Tiers** (Adaptive depth based on complexity):
- Trivial (1-3): Quick scan, light reports, auto-approve if PASS
- Moderate (4-6): Thorough analysis, standard reports, human review if CONCERNS
- Complex (7-9): Deep audit with threat modeling, comprehensive review, human review required

**Decision**:
- ✅ All PASS → Mark Epic complete, proceed
- ⚠️ CONCERNS → Address issues, re-run specific reviewers
- ❌ FAIL → Fix critical issues, re-run all reviewers

**Output**: Review reports + decision (pass/concerns/fail)

---

### Phase 7: Epic Completion Review

**When**: After all Stories in Epic implemented and reviewed

**Tools**: Skill `epic-review`

**Process**:
1. Use `epic-review` skill to synthesize all review reports
2. Extract learnings: what worked, what didn't
3. Identify patterns (repeated issues, successful approaches)
4. Create epic-level retrospective

**Artifacts**: File `products/{product-name}/reviews/epic-reviews/YYYY-MM-DD-epic-name-review.md`

**Output**: Knowledge captured for future Epics

---

## Skills Reference

Skills stay in main conversation context. Use for strategic work and workflow guidance.

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| **elicitation** | Iterative questioning (BMAD-style) | Starting product vision, deep exploration |
| **product-vision** | Strategic product planning | Starting new product, major feature direction |
| **architecture** | Tech stack, patterns, decisions | Architectural exploration, tech decisions |
| **create-prd** | Generate formal PRD | After vision clear, before Epics |
| **epic-breakdown** | Break PRD into Epics | After PRD approved |
| **whats-next** | Show next actions based on workflow state | Anytime unsure what to do next |
| **context-scope** | Decide if Context agent needed | Before planning mode, when context needs unclear |
| **epic-review** | Synthesize review reports | After all Stories in Epic complete |

---

## Agents Reference

Agents run in parallel in separate contexts. Use for research, exploration, review tasks that don't bloat main conversation context.

### Research/Exploration Agents

| Agent | Purpose | When to Use | Output |
|-------|---------|-------------|--------|
| **market-research** | Competitive analysis, user research | Strategic Vision phase | Research report |
| **tech-exploration** | Compare multiple tech approaches | Architecture exploration | Tech comparison matrix |
| **epic-parallel** | Generate multiple Epics simultaneously | Epic breakdown (if many Epics) | Multiple Epic files |
| **context-gatherer** | Large-scale codebase context | Before planning mode (large codebases) | Context summary |

### Review Agents

| Agent | Purpose | Scope | Output |
|-------|---------|-------|--------|
| **test-reviewer** | Verify tests match plan, weren't changed, good coverage | Tests and plan | Test review report |
| **security-reviewer** | Security audit | Auth, data protection, vulnerabilities | Security review report |
| **architecture-reviewer** | Design consistency | Patterns, tech debt, design | Architecture review report |
| **quality-reviewer** | Code quality | Maintainability, standards, testing | Quality review report |
| **requirements-reviewer** | Acceptance criteria check | Completeness, traceability | Requirements review report |

**How they run**: Automatically triggered after TDD implementation completes (all 5 in parallel)

---

## TDD Methodology

### The TDD Cycle

```
PLAN (Planning Mode)
  ↓
RED (Write failing tests)
  ↓
REVIEW (Tests vs Plan)
  ↓
GREEN (Implement to pass tests)
  ↓
REFACTOR (Improve code)
  ↓
REVIEW (5 parallel agents)
```

### Critical Rules

**DO**:
- ✅ Write ALL tests before implementation
- ✅ Ensure tests fail initially (prove they test something)
- ✅ Review tests against plan before implementing
- ✅ Run tests continuously during implementation
- ✅ Keep tests passing during refactoring

**DO NOT**:
- ❌ Change tests during implementation (Phase 5c)
- ❌ Skip test specifications in planning mode
- ❌ Implement before tests written
- ❌ Proceed with tests that pass before implementation

### Test Change Exceptions

Tests can ONLY be changed:
1. During test writing (Phase 5a) - before implementation starts
2. During test review (Phase 5b) - if tests don't match plan
3. After review (Phase 6) - if Test Reviewer identifies issues

If tests need changes during implementation (Phase 5c):
- **STOP immediately**
- Update plan with justification
- Then update tests
- Mark in workflow.yaml: `tests_changed_during_implementation: true`
- Test Reviewer will review the change

---

## State Management

### workflow.yaml Structure

Location: `.aknakos/state/workflow.yaml`

```yaml
framework_version: "1.0"
current_phase: "tdd_implementation"

# Phases: vision, prd, epic_breakdown, planning_mode, tdd_tests_written,
#         tdd_test_review, tdd_implementation, tdd_refactor, review, epic_complete

products:
  {product-name}:
    current_status: "in_progress"
    prd:
      file: "YYYY-MM-DD-prd.md"
      status: "approved"
    epics:
      - name: "{epic-name}"
        file: "YYYY-MM-DD-epic-name.md"
        status: "review"
        implementation_complexity: 6  # 1-9 scale
        tdd:
          plan_includes_test_specs: true
          tests_written: true
          tests_reviewed: true
          tests_passing: true
          tests_changed_during_implementation: false  # MUST stay false
        reviews:
          test: "PASS"
          security: "PASS"
          architecture: "CONCERNS"
          quality: "PASS"
          requirements: "PASS"
        next_action: "Address architecture concerns"

context_strategy:
  last_used: "planning_mode_explore"  # or "context_agent"

review_settings:
  auto_trigger: true
  parallel_reviews: true
  complexity_threshold: 4  # Below this = lighter reviews
```

### State Machine

```
vision → prd → epic_breakdown → planning_mode →
tdd_tests_written → tdd_test_review → tdd_implementation →
tdd_refactor → review → epic_complete
```

### Updating State

- **Manual**: Edit `.aknakos/state/workflow.yaml`
- **Query state**: Use `whats-next` skill to see current state and next actions

---

## Context Strategy

### Decision Tree

```
Need context for planning mode?
│
├─ Single file or component?
│  → Use @-mentions in planning mode
│
├─ Small scope (2-5 files)?
│  → Use planning mode's Explore subagent
│
├─ Medium scope (Epic breakdown)?
│  → Use @-mentions to reference PRD + architecture docs
│
└─ Large scope (multi-domain, full codebase)?
   → Spawn context-gatherer agent
```

### Planning Mode Tools

Available in planning mode (read-only):
- **Read**: View file contents
- **Glob**: Find files by pattern
- **Grep**: Search file contents
- **Explore**: Specialized Explore subagent (fast codebase search)

### Context Agent

**When to use**: Large, complex, multi-domain context needs

**Process**:
1. Use `context-scope` skill to analyze if needed
2. Spawn `context-gatherer` agent
3. Agent explores codebase in separate context
4. Agent returns summary report
5. Use summary in main conversation
6. Enter planning mode with context loaded

**Benefits**: Doesn't bloat main context, thorough exploration, token-efficient summary

---

## File Structure & Naming

### Directory Structure

```
CLAUDE.md (this file)

.aknakos/
├── state/
│   └── workflow.yaml
├── skills/
│   └── *.md
├── agents/
│   ├── *.md
│   └── review/
│       └── *.md
└── templates/
    └── *.md

products/{product-name}/
├── YYYY-MM-DD-prd.md
├── epics/
│   └── YYYY-MM-DD-epic-name.md
├── plans/
│   └── epic-name/
│       └── YYYY-MM-DD-plan.md
└── reviews/
    ├── epic-name/
    │   └── YYYY-MM-DD-*-review.md
    └── epic-reviews/
        └── YYYY-MM-DD-epic-name-review.md
```

### Naming Conventions

**Date Prefix**: All artifact files use `YYYY-MM-DD-` prefix (chronological order, easy sorting)

**Examples**: `2025-11-08-prd.md`, `2025-11-08-user-authentication.md` (Epic)

**Product Name**: Lowercase with hyphens (e.g., `my-product`, `user-dashboard`)

**Epic Name**: Lowercase with hyphens, descriptive (e.g., `user-authentication`, `payment-processing`)

---

## What's Next Usage

### Purpose

`whats-next` skill provides intelligent guidance based on current workflow state.

### How It Works

1. Reads `.aknakos/state/workflow.yaml`
2. Analyzes current phase, product status, Epic status
3. Identifies blockers and next actions
4. Provides context-aware suggestions

### When to Use

- Starting a session: "What should I work on?"
- Completing a phase: "What's next?"
- Stuck or confused: "What should I do now?"
- After errors: "How do I proceed?"

---

## Quick Reference

### Workflow At A Glance

1. **Vision**: Discuss product (`elicitation` or `product-vision`, `architecture` skills)
2. **PRD**: Create formal requirements (`create-prd` skill)
3. **Epics**: Break PRD into Epics (`epic-breakdown` skill)
4. **Plan**: Enter planning mode (Shift+Tab twice), create Stories + Tasks + Test Specs
5. **Tests**: Write tests first (RED)
6. **Review Tests**: Verify tests match plan
7. **Implement**: Make tests pass (GREEN)
8. **Refactor**: Clean up code (REFACTOR)
9. **Review**: 5 parallel agents review automatically
10. **Complete**: Epic done, extract learnings

### Key Commands

- **Enter Planning Mode**: Shift+Tab twice
- **Exit Planning Mode**: Shift+Tab
- **Check Status**: Use `whats-next` skill
- **Spawn Agent**: "Spawn {agent-name} agent"
- **Use Skill**: "Use {skill-name} skill" or invoke skill

### Critical Rules

- ✅ Write tests before implementation
- ✅ Review tests against plan
- ❌ NEVER change tests during implementation
- ✅ Use planning mode for Stories/Tasks (not separate files)
- ✅ Save plans only if complex/multi-session
- ✅ Let review agents run automatically

---

## Troubleshooting

- **"I don't know what to do next"** → Use `whats-next` skill
- **"Should I use Context agent or planning mode?"** → Use `context-scope` skill
- **"Tests need to change during implementation"** → STOP, update plan with justification, then update tests
- **"Reviews taking too long"** → Check complexity score
- **"Lost context between sessions"** → Check workflow.yaml for current state, read saved plans

---

## Version History

**v1.0** (2025-11-08): Initial release
- Graduated complexity architecture
- TDD integrated workflow
- Parallel review agents
- Context strategy (hybrid)
- Planning mode integration

---

*For detailed skill and agent definitions, see `.aknakos/skills/` and `.aknakos/agents/` directories.*
