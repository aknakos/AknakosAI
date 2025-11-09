# Aknakos Framework - Complete Specification

**Version**: 1.0
**Date**: 2025-11-08
**Author**: Aknakos AI

---

## Executive Summary

The **Aknakos Framework** is a hybrid AI agent framework for Claude Code that balances **strategic depth with implementation speed**. It combines:

- **BMAD-style strategic planning**: Conversational exploration, architecture decisions, formal PRDs
- **OpenSpec-style fast implementation**: Lightweight Epics, native Claude planning mode, minimal documentation overhead
- **Integrated TDD**: Test-driven development enforced through workflow and review process
- **Parallel review agents**: Automatic quality gates after implementation

**Key Innovation**: Graduated complexity - heavy documentation for strategy, lightweight for implementation.

---

## Framework Architecture

### Core Philosophy

1. **Graduated Complexity**: Document heavily only what needs it (Vision → PRD = formal, Implementation = fast)
2. **Claude Code Native**: Uses Claude's planning mode and native capabilities, not rigid agent frameworks
3. **TDD by Default**: Test-driven development integrated into every implementation cycle
4. **Adaptive Review**: Review intensity matches risk and complexity
5. **Parallel When Beneficial**: Spawn agents for research and review, keep implementation focused

### Documentation Hierarchy

```
Product Vision (Conversational, low formality)
    ↓
Market Research (Parallel agents, structured reports)
    ↓
Architecture (Conversational + parallel tech exploration)
    ↓
PRD (FORMAL - SHALL/MUST language) ← Last heavy documentation
    ↓
Epic (Lightweight - acceptance criteria only)
    ↓
Planning Mode (Stories + Tasks + Test Specs - ephemeral)
    ↓
TDD Implementation (Tests first, then code)
    ↓
Review (5 parallel agents - automatic)
```

---

## File Structure

```
CLAUDE.md                                    # Framework instruction manual (read this!)

.aknakos/
├── state/
│   ├── workflow.yaml                        # Current workflow state
│   └── session.yaml                         # Session context (optional)
├── skills/                                  # Claude Skills (main context)
│   ├── product-vision.md
│   ├── architecture.md
│   ├── create-prd.md
│   ├── epic-breakdown.md
│   ├── whats-next.md
│   ├── context-scope.md
│   └── epic-review.md
├── agents/                                  # Agents (parallel, separate context)
│   ├── market-research.md
│   ├── tech-exploration.md
│   ├── epic-parallel.md
│   ├── context-gatherer.md
│   └── review/
│       ├── test-reviewer.md
│       ├── security-reviewer.md
│       ├── architecture-reviewer.md
│       ├── quality-reviewer.md
│       └── requirements-reviewer.md
└── templates/
    ├── prd-template.md
    └── epic-template.md

.aknakos/products/{product-name}/
├── YYYY-MM-DD-prd.md                        # Formal PRD
├── epics/
│   ├── YYYY-MM-DD-epic-name.md             # Lightweight Epics
│   └── ...
├── plans/                                   # Optional saved plans
│   └── epic-name/
│       └── YYYY-MM-DD-plan.md
└── reviews/                                 # Review reports
    ├── epic-name/
    │   ├── YYYY-MM-DD-test-review.md
    │   ├── YYYY-MM-DD-security-review.md
    │   ├── YYYY-MM-DD-architecture-review.md
    │   ├── YYYY-MM-DD-quality-review.md
    │   └── YYYY-MM-DD-requirements-review.md
    └── epic-reviews/
        └── YYYY-MM-DD-epic-name-review.md
```

---

## Workflow Phases

### Phase 1: Strategic Vision

**Purpose**: Define product vision, understand market, choose architecture

**Tools**:
- Skills: `product-vision`, `architecture`
- Agents: `market-research`, `tech-exploration` (parallel)

**Artifacts**: Conversational (in-context, not saved)

**Formality**: Low (exploratory)

**Duration**: 1-2 sessions

### Phase 2: PRD Creation

**Purpose**: Formalize requirements with SHALL/MUST language

**Tools**: Skill `create-prd`

**Artifacts**: `.aknakos/products/{name}/YYYY-MM-DD-prd.md` (formal)

**Formality**: HIGH (this is the last heavy documentation)

**Duration**: 1 session

**Review**: Strategic review before approval

### Phase 3: Epic Breakdown

**Purpose**: Break PRD into lightweight, implementable Epics

**Tools**:
- Skill: `epic-breakdown`
- Optional Agent: `epic-parallel` (for many Epics)
- Optional Agent: `context-gatherer` (for large codebases)

**Artifacts**: `.aknakos/products/{name}/epics/YYYY-MM-DD-epic-name.md` (lightweight)

**Formality**: Medium (just acceptance criteria + dependencies)

**Duration**: 0.5-1 session

### Phase 4: Planning Mode

**Purpose**: Break Epic → Stories → Tasks → Test Specs

**Tools**: Claude Code Native Planning Mode (Shift+Tab twice)

**Process**:
1. Read Epic file
2. Gather context (planning mode tools or Context agent if large)
3. Create Stories with acceptance criteria (ephemeral)
4. Create Tasks for implementation (ephemeral)
5. **Create Test Specifications** (critical for TDD)
6. Optionally save plan to file (if complex/multi-session)

**Artifacts**: Plan (ephemeral, or saved if complex)

**Formality**: Low (working plan)

**Duration**: 0.5-1 hour per Epic

### Phase 5: TDD Implementation

**5a. Write Tests (RED)**:
- Write ALL tests first based on test specifications from plan
- Tests MUST fail initially
- Duration: 1-2 hours

**5b. Review Tests vs Plan**:
- Verify tests match plan specifications
- Check tests cover all acceptance criteria
- Duration: 15-30 minutes

**5c. Implement Code (GREEN)**:
- Implement to make tests pass
- **DO NOT change tests** during this phase
- Duration: 2-6 hours depending on complexity

**5d. Refactor (REFACTOR)**:
- Improve code quality while keeping tests green
- Optional
- Duration: 0.5-1 hour

**Critical Rule**: Tests cannot change during implementation (5c). If they need changes, STOP, update plan with justification, then update tests.

### Phase 6: Review (Parallel Agents)

**Purpose**: Automatic quality gates

**Trigger**: After TDD implementation complete

**Agents** (run in parallel, separate contexts):
1. **test-reviewer**: Tests match plan, weren't changed, good coverage
2. **security-reviewer**: No vulnerabilities, secure practices
3. **architecture-reviewer**: Pattern consistency, design quality
4. **quality-reviewer**: Code quality, maintainability, standards
5. **requirements-reviewer**: All acceptance criteria met

**Artifacts**: 5 review reports saved to `.aknakos/products/{name}/reviews/{epic}/`

**Duration**: 15-30 minutes (parallel)

**Outcomes**:
- **PASS**: All good, Epic complete
- **CONCERNS**: Address issues, re-review specific reviewers
- **FAIL**: Critical issues, fix and re-review all

### Phase 7: Epic Completion Review

**Purpose**: Synthesize learnings for future Epics

**Tools**: Skill `epic-review`

**Process**: Read 5 review reports, extract patterns and learnings

**Artifacts**: `.aknakos/products/{name}/reviews/epic-reviews/YYYY-MM-DD-epic-name-review.md`

**Duration**: 30 minutes

---

## Skills Reference

| Skill | Phase | Purpose |
|-------|-------|---------|
| **product-vision** | 1 | Strategic product planning and exploration |
| **architecture** | 1 | Tech stack decisions and patterns |
| **create-prd** | 2 | Generate formal PRD from vision |
| **epic-breakdown** | 3 | Break PRD into Epics |
| **whats-next** | Any | Show next actions based on workflow state |
| **context-scope** | 3-4 | Decide if Context agent needed |
| **epic-review** | 7 | Synthesize review reports and learnings |

---

## Agents Reference

### Research/Exploration Agents

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| **market-research** | Market analysis, competitive research | Strategic Vision phase |
| **tech-exploration** | Compare tech options (React vs Vue, etc.) | Architecture decisions |
| **epic-parallel** | Generate multiple Epics simultaneously | Large PRD with 6+ Epics |
| **context-gatherer** | Map large/complex codebases | Before planning, large context needed |

### Review Agents (Automatic)

| Agent | Reviews | Output |
|-------|---------|--------|
| **test-reviewer** | Tests vs plan, TDD compliance, coverage | Test review report |
| **security-reviewer** | Security vulnerabilities, best practices | Security review report |
| **architecture-reviewer** | Pattern consistency, design quality | Architecture review report |
| **quality-reviewer** | Code quality, maintainability, standards | Quality review report |
| **requirements-reviewer** | Acceptance criteria completeness | Requirements review report |

---

## TDD Methodology

### The Cycle

```
PLAN (with test specs)
  ↓
RED (write failing tests)
  ↓
REVIEW TESTS (vs plan)
  ↓
GREEN (implement to pass)
  ↓
REFACTOR (improve quality)
  ↓
REVIEW (5 parallel agents)
```

### Critical Rules

**DO**:
- ✅ Write ALL tests before implementation
- ✅ Ensure tests fail initially
- ✅ Review tests against plan before implementing
- ✅ Run tests continuously during implementation

**DO NOT**:
- ❌ Change tests during implementation (Phase 5c)
- ❌ Skip test specifications in planning mode
- ❌ Implement before tests are written

**Exception**: Tests can ONLY be changed if you STOP implementation, update plan with justification, then update tests.

---

## State Management

### workflow.yaml

Location: `.aknakos/state/workflow.yaml`

**Tracks**:
- Current phase in workflow
- Products and their status
- Epics and their status
- TDD cycle position (tests written, reviewed, passing, etc.)
- Review results (PASS/CONCERNS/FAIL)
- Next actions

**Key Fields**:
```yaml
current_phase: "tdd_implementation"  # Current phase
products:
  my-product:
    epics:
      - name: "user-auth"
        status: "tdd_implementing"
        tdd:
          tests_changed_during_implementation: false  # Critical!
        reviews:
          test: "PASS"
          security: "CONCERNS"
```

**Query State**: Use `whats-next` skill to see current state and guidance

---

## Context Strategy

### Decision Tree

```
Need context?
├─ Single file → @-mention
├─ 2-5 files → Planning mode Explore
├─ Medium (Epic breakdown) → @-mentions to PRD/architecture
└─ Large (multi-domain) → Spawn context-gatherer agent
```

### Planning Mode Tools

- **@-mentions**: Reference specific files
- **Read**: View file contents
- **Glob**: Find files by pattern
- **Grep**: Search contents
- **Explore**: Specialized fast search (Haiku subagent)

### Context Agent

**When**: Large codebase (100+ files), multi-domain, architecture-wide understanding

**Benefit**: Explores in separate context, returns token-efficient summary

---

## Review Process

### Automatic Triggering

After TDD implementation completes → Spawn 5 parallel review agents

### Review Depth (Adaptive)

Based on Epic complexity (1-9 scale):

- **Trivial (1-3)**: Light reviews, quick checks
- **Moderate (4-6)**: Standard thorough reviews
- **Complex (7-9)**: Deep audits, comprehensive analysis

### Outcomes

- **All PASS** → Epic complete, proceed
- **CONCERNS** → Address issues, re-review specific agents
- **FAIL** → Fix critical issues, re-review all agents

---

## Quick Start Guide

### 1. Start New Product

```
1. Use product-vision skill → Explore product idea
2. Optionally spawn market-research agent (parallel)
3. Use architecture skill → Choose tech stack
4. Optionally spawn tech-exploration agent (parallel)
5. Use create-prd skill → Formalize requirements
6. Review and approve PRD
```

### 2. Break into Epics

```
1. Use epic-breakdown skill → Create Epics from PRD
2. Or spawn epic-parallel agent (if 6+ Epics)
3. Review Epics, adjust if needed
4. Prioritize (which Epic first?)
```

### 3. Implement an Epic

```
1. Choose Epic
2. Use context-scope skill → Decide context strategy
3. Enter planning mode (Shift+Tab twice):
   - Read Epic
   - Create Stories
   - Create Tasks
   - Create Test Specifications ⭐
   - Optionally save plan
4. Exit planning mode (Shift+Tab)
```

### 4. TDD Cycle

```
1. Write tests (based on test specs from plan) → RED
2. Review tests vs plan → Verify alignment
3. Implement code → Make tests pass (GREEN)
   ⚠️ DO NOT change tests during this step
4. Refactor code → Improve quality (REFACTOR)
```

### 5. Automatic Review

```
1. Implementation complete → 5 agents spawn automatically
2. Wait for review reports (15-30 min)
3. Read reports:
   - All PASS? → Epic complete!
   - CONCERNS? → Address issues, re-review
   - FAIL? → Fix critical issues, re-review all
```

### 6. Epic Completion

```
1. Use epic-review skill → Synthesize learnings
2. Document what worked, what didn't
3. Apply learnings to next Epic
4. Use whats-next skill → See what's next
```

---

## Best Practices

### Documentation

- **Heavy documentation**: Only for PRD (formal requirements)
- **Light documentation**: Epics (just acceptance criteria)
- **Ephemeral planning**: Stories/Tasks in planning mode (not saved unless complex)
- **Review documentation**: Automatic from review agents

### Planning

- **Small scope**: Plan for 30 minutes of work max
- **Test specs**: Always include test specifications in plan
- **Save plans**: Only for complex/multi-session work
- **Use whats-next**: When unsure what to do

### TDD

- **Tests first**: ALWAYS write tests before implementation
- **Don't change tests**: During implementation (GREEN phase)
- **If stuck**: Update plan with justification, then update tests
- **Run frequently**: Run tests continuously during implementation

### Review

- **Trust the agents**: Review reports are thorough
- **Address CONCERNS**: Don't skip concerns, address them
- **Learn from reviews**: Use epic-review to extract patterns
- **Iterate**: Apply learnings to next Epic

### Context

- **Start small**: Try planning mode tools first
- **Escalate if needed**: Spawn Context agent for large exploration
- **Reuse context**: Context summary stays in conversation
- **Use @-mentions**: For specific known files

---

## Common Workflows

### Greenfield Project (0 → 1)

```
Vision → Architecture → PRD → Epics → Planning Mode → TDD → Review → Next Epic
```

Duration: 2-4 weeks for MVP

### Add Feature to Existing Project

```
(Skip Vision/Architecture if already exist)
PRD (for feature) → Epics → Planning Mode → TDD → Review
```

Duration: 1-2 weeks per major feature

### Refactoring

```
Use context-gatherer → Understand current architecture
Create Refactoring PRD → Break into Epics → Planning Mode → TDD → Review
```

Duration: Varies

---

## Troubleshooting

### "I don't know what to do next"
→ Use `whats-next` skill

### "Tests are failing during implementation"
→ **GOOD!** That's RED phase. Implement code to make them pass (GREEN).

### "I need to change tests during implementation"
→ **STOP**. Update plan with justification, then update tests. Mark in workflow.yaml.

### "Context agent or planning mode?"
→ Use `context-scope` skill to decide

### "Review taking too long"
→ Check complexity score. Can adjust review depth if needed.

### "Lost context between sessions"
→ Check workflow.yaml for state. Read saved plans if they exist.

---

## Success Metrics

Track these to measure framework effectiveness:

- **Estimation accuracy**: Planned vs actual complexity
- **Review pass rate**: First-time PASS rate from reviewers
- **Test coverage**: Percentage coverage achieved
- **TDD compliance**: How often tests unchanged during implementation
- **Velocity**: Epics completed per week/month
- **Quality**: Issues found in production vs caught in review

---

## Version History

**v1.0** (2025-11-08): Initial release
- Graduated complexity architecture
- TDD integrated workflow
- 5 parallel review agents
- Hybrid context strategy (planning mode + Context agent)
- Planning mode integration for Stories/Tasks
- Skills and agents for all phases

---

## Getting Help

- **Read CLAUDE.md**: Primary framework documentation
- **Use whats-next skill**: Context-aware guidance
- **Check workflow.yaml**: Current state and next actions
- **Review examples**: In agent and skill definitions

---

## License & Attribution

Inspired by:
- **BMAD-METHOD**: Strategic planning approach, multi-agent collaboration
- **Agent OS**: Context layers, orchestration patterns
- **OpenSpec**: Lightweight implementation, fast execution
- **Spec Kit**: Phased workflow structure

Optimized for **Claude Code** with TDD methodology.

---

*For detailed documentation, always refer to CLAUDE.md in the project root.*
