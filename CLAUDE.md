Always sacrifice grammar for the sake of conciseness and clarity. You must keep CLAUDE.md less than 500 lines.

# Aknakos Framework - AI Agent Framework for Claude Code

**Version**: 1.1
**Purpose**: Hybrid framework balancing strategic depth with implementation speed, optimized for Claude Code.
**Updated**: 2025-11-09 - Migrated to Claude Code native structure

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

### Phase 1: Strategic Documents (Conversational Discovery)

**Phase 1a - Mission** (Required, Lightweight):
- Use `create-mission` skill
- Conversational discovery (10-15 min)
- Output: `mission.md` (1 page) + `roadmap.md` (1-2 pages)
- Agent OS-style lightweight references
- When: Every product

**Phase 1b - Project Brief** (Optional, Complex Products):
- Use `create-project-brief` skill
- BMAD Analyst-style deep elicitation (20-30 min)
- Advanced techniques: 6 Hats, 5 Whys, role-playing, self-critique
- Output: `YYYY-MM-DD-project-brief.md` (5-8 pages)
- When: Complexity 4-9 OR user requests thorough planning
- Optional: Spawn `market-research` agent for parallel research

**Phase 1c - Architecture** (Optional, Complex Products):
- Use `create-architecture-doc` skill
- BMAD Architect-style alternatives-driven exploration (30-45 min)
- Mandatory alternatives for all tech decisions (use AskUserQuestion)
- Output: `YYYY-MM-DD-architecture.md` (5-10 pages) + `tech-stack.md` (1 page)
- When: Complexity 4-9 OR novel architecture decisions
- Optional: Spawn `tech-exploration` agent for deep comparisons

**Phase 1d - UX Flow** (Optional, User-Facing Products):
- Use `create-ux-flow` skill
- Conversational UX design (15-25 min)
- Define user flows, interface structure, interaction patterns
- Output: `YYYY-MM-DD-ux-flow.md` (3-8 pages)
- When: User-facing products (Complexity 4-9) OR significant UI/UX needs
- Informs PRD with UX requirements and constraints

### Phase 2: PRD (Formal Requirements)

**Phase 2 - PRD**:
- Use `create-prd` skill (enhanced with BMAD PM persona)
- References mission.md, project-brief.md, architecture.md, ux-flow.md
- Ruthless prioritization (MoSCoW: Must/Should/Could/Won't)
- Traceability: Link PRD to source documents
- Output: `YYYY-MM-DD-prd.md` with SHALL/MUST language
- Strategic review before proceeding

### Phase 3: Epic Breakdown

**Phase 3 - Epic Breakdown**:
- Use `epic-breakdown` skill
- Each Epic: name, description, acceptance criteria, dependencies, complexity (1-9)
- Epics include traceability frontmatter (PRD references, architecture references)
- Save to `.aknakos/products/{product-name}/epics/YYYY-MM-DD-epic-name.md`
- Optional: Use `epic-parallel` agent for multiple Epics simultaneously

### Phase 3.5: Alignment Validation (Quality Gate)

**Phase 3.5 - Validate Alignment** (Required):
- Use `validate-alignment` skill
- BMAD PO Master Validation Checklist pattern
- Checks: Requirements coverage, Epic-PRD traceability, architecture compliance, UX alignment (if ux-flow.md exists), mission alignment
- Output: Validation report (PASS/CONCERNS/FAIL)
- Location: `.aknakos/products/{name}/reviews/validation/YYYY-MM-DD-epic-validation.md`
- **If FAIL**: Block progression, use `escalate-conflict` skill if parent docs need changes
- **If PASS/CONCERNS**: Proceed to planning mode

### Phase 4: Planning Mode

Enter planning mode (Shift+Tab twice) to break Epic into Stories/Tasks/Test Specs.

**Context loading** (3-Tier Hierarchy):
- **Tier 1** (Always load): mission.md, tech-stack.md, roadmap.md
- **Tier 2** (Selective): Epic file (always), @-mention PRD sections, @-mention architecture patterns
- **Tier 3** (As needed): testing-standards.md, security-guidelines.md
- Use `context-scope` skill to determine strategy
- For large Tier 2 docs: Spawn `context-fetcher` agent for selective extraction

**Create** (ephemeral, not saved as files):
- Stories: description, acceptance criteria, dependencies
- Tasks: specific code changes
- **Test Specifications** (CRITICAL): Unit/integration/E2E tests mapped to acceptance criteria

Optional: Save plan to `.aknakos/products/{product-name}/plans/epic-name/YYYY-MM-DD-plan.md` if complex/multi-session.

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
3. **architecture-reviewer**: **ENHANCED** - Checks architecture.md compliance, tech-stack.md alignment, pattern consistency
4. **quality-reviewer**: Code quality, maintainability, standards
5. **requirements-reviewer**: **ENHANCED** - Checks Epic alignment, PRD traceability, mission alignment

**Review Enhancements**:
- Agents load strategic docs (mission, PRD, architecture, tech-stack, ux-flow)
- Check alignment with upper-level decisions
- Flag deviations (documented vs undocumented)
- Recommend `escalate-conflict` if parent docs need changes

**Review Tiers** (complexity-based):
- Trivial (1-3): Quick scan, auto-approve if PASS
- Moderate (4-6): Thorough analysis, human review if CONCERNS
- Complex (7-9): Deep audit, human review required

Reports saved to `.aknakos/products/{product-name}/reviews/epic-name/`. Decision: PASS/CONCERNS/FAIL.

**Meta-Review** (optional): After 5 reviews complete, spawn `meta-reviewer` agent to synthesize findings, resolve conflicts, prioritize fixes.

### Phase 7: Epic Completion

Use `epic-review` skill to synthesize review reports, extract learnings, identify patterns. Save retrospective to `.aknakos/products/{product-name}/reviews/epic-reviews/YYYY-MM-DD-epic-name-review.md`.

---

## Skills & Agents

**Skills** (stay in main context): See `.claude/skills/` for full definitions (Claude Code native skills)

*Strategic Documents*:
- `create-mission`: Generate mission.md + roadmap.md (Agent OS style, lightweight)
- `create-project-brief`: BMAD Analyst-style project brief (advanced elicitation)
- `create-architecture-doc`: BMAD Architect-style architecture (alternatives-driven)
- `create-ux-flow`: UX flow definition (user flows, interface structure, interaction patterns)
- `create-prd`: Generate formal PRD with BMAD PM persona (ruthless prioritization)

*Workflow Management*:
- `elicitation`, `product-vision`, `architecture`: Legacy strategic planning
- `epic-breakdown`: Break PRD into Epics with traceability
- `validate-alignment`: BMAD PO validation checklist (Epic-PRD-Architecture alignment)
- `escalate-conflict`: Block-and-escalate for parent doc conflicts
- `epic-review`: Synthesize review reports

*Dynamic Work Management*:
- `add-work`: Quick Epic capture with priority triage (P0-P3), handles interruptions
- `park`: Save current work context (git stash + progress)
- `resume`: Restore parked work with full context
- `list-work`: Display all work with statuses/priorities
- `quick-validate`: Lightweight validation (2-3 min) for urgent work
- `promote-epic`: Move Epics through validation stages (backlog → drafted → planning)

*Context Management*:
- `context-scope`: 3-tier context strategy (Strategic/Detailed/Standards)
- `whats-next`: Show next actions based on workflow state

*Quality & Metrics*:
- `trace-requirements`: Auto-generate traceability matrix (Mission → PRD → Epic → Tests → Code)
- `validate-state`: Verify workflow.yaml consistency, detect orphaned files/broken references
- `compare-standards`: Show product vs framework standards differences, visualize inheritance
- `analyze-metrics`: Track time/complexity accuracy, improve estimates from historical data

**Agents** (auto-loaded by Claude Code): See `.claude/agents/` for agent definitions

*Research*: `market-research`, `tech-exploration`, `epic-parallel`, `context-gatherer`, `context-fetcher`
*Review*: `test-reviewer`, `security-reviewer`, `architecture-reviewer`, `quality-reviewer`, `requirements-reviewer`, `meta-reviewer`

---

## Dynamic Work Management

**Handle interruptions without derailing progress.**

**Flow**: New work → Priority (P0-P3) → Park current (git stash + context) → Resume later
**Lifecycle**: Backlog → Drafted (quick-validate) → Planning (full-validate) → In Progress → Parked/Complete

**Priority**: P0 (auto-switch), P1 (offer switch), P2/P3 (backlog)
**Validation**: Quick (2-3 min, mission/tech/complexity) for P0/P1, Full (10-15 min, PRD/architecture) before planning

**User says**: "New work: {desc}" | "Park this" | "Resume" | "Show all work"

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

**Phases**: mission_created → project_brief_created (optional) → architecture_created (optional) → ux_flow_created (optional) → prd → epic_breakdown → validation_complete → planning_mode → tdd_tests_written → tdd_test_review → tdd_implementation → tdd_refactor → review → epic_complete

**Query**: Use `whats-next` skill for current state and next actions.
**Update**: Edit workflow.yaml manually.

See workflow.yaml file for structure example.

---

## Context Strategy (3-Tier Hierarchy)

**Tier 1: Strategic Context** (Always Load):
- mission.md, tech-stack.md, roadmap.md
- Lightweight (1 page each)
- Load in planning mode, Epic work, implementation

**Tier 2: Detailed Context** (Selective Loading):
- project-brief.md, architecture.md, ux-flow.md, prd.md (3-25 pages)
- @-mention specific sections OR spawn `context-fetcher` for extraction
- DRY principle: single source of truth

**Tier 3: Standards** (Hybrid - product-specific > framework defaults):
- **Precedence**: `.aknakos/products/{name}/standards/*.yaml` (if exists) > `.aknakos/standards/*.yaml`
- **Files**: coding-conventions, architecture-patterns, testing-standards, security-guidelines, review-checklist (all YAML)
- **Framework defaults**: SvelteKit + Svelte 5 + Better-Auth + Drizzle + Vitest + Cypress + Bun
- **Product-specific**: Optional custom standards (use `create-standards` skill after mission creation)
- Referenced during planning, implementation, review

**Loading Strategies**:
- **Small scope**: @-mentions
- **Medium scope**: Planning mode Explore
- **Large Tier 2 docs**: context-fetcher agent (selective extraction)
- **Large codebase**: context-gatherer agent

Use `context-scope` skill to determine strategy.

---

## File Structure

```
.aknakos/
└── state/workflow.yaml  # Workflow state management

.claude/                 # Claude Code native structure
├── skills/              # Auto-loaded skills (Claude Code format)
│   ├── create-mission/SKILL.md
│   ├── create-prd/SKILL.md
│   ├── epic-breakdown/SKILL.md
│   └── ...
├── docs/                # Reference documentation
│   └── agents/          # Agent prompts for Task tool
│       ├── market-research.md
│       ├── tech-exploration.md
│       └── review/*.md
├── templates/           # Document templates
│   ├── mission-template.md
│   ├── prd-template.md
│   └── ...
├── standards/           # Framework default standards (YAML)
│   ├── coding-conventions.yaml
│   ├── architecture-patterns.yaml
│   ├── testing-standards.yaml
│   ├── security-guidelines.yaml
│   └── review-checklist.yaml
└── references/          # Reference docs
    └── elicitation-techniques.md

.aknakos/products/{product-name}/
├── mission.md                          # Lightweight vision (Agent OS)
├── roadmap.md                          # Development phases (Agent OS)
├── tech-stack.md                       # Tech choices (Agent OS)
├── YYYY-MM-DD-project-brief.md        # Strategic brief (BMAD, optional)
├── YYYY-MM-DD-architecture.md         # Architecture spec (BMAD, optional)
├── YYYY-MM-DD-ux-flow.md              # UX flow spec (optional)
├── YYYY-MM-DD-prd.md                  # Formal requirements
├── standards/                          # Product-specific standards (optional, YAML)
│   ├── coding-conventions.yaml        # Overrides framework defaults
│   ├── architecture-patterns.yaml
│   ├── testing-standards.yaml
│   ├── security-guidelines.yaml
│   └── review-checklist.yaml
├── epics/YYYY-MM-DD-epic-name.md      # Traceability frontmatter
├── plans/epic-name/YYYY-MM-DD-plan.md
└── reviews/
    ├── validation/                     # Validation reports
    │   └── YYYY-MM-DD-epic-validation.md
    ├── conflicts/                      # Conflict reports
    │   └── YYYY-MM-DD-conflict-{type}.md
    └── epic-name/YYYY-MM-DD-*-review.md
```

**Naming**: Date prefix (`YYYY-MM-DD-`), lowercase with hyphens.

---

## Quick Reference

**Workflow**: Mission (1a) → [Project Brief (1b, optional)] → [Architecture (1c, optional)] → [UX Flow (1d, optional)] → PRD (2) → Epics (3) → **Validate** (3.5) → Plan (4, Shift+Tab×2) → Tests (5 RED) → Review Tests → Implement (5 GREEN) → Refactor → Automated Review (6) → Complete (7)

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

**v1.1** (2025-11-09): Claude Code native integration - 25 skills + 11 agents in `.claude/`, instance data in `.aknakos/`

**v1.0** (2025-11-08): Initial release - Graduated complexity, TDD workflow, parallel reviews, context strategy, planning mode integration

---

*Skills: `.claude/skills/` | Agents: `.claude/agents/` | Framework: `.aknakos/` | Products: `.aknakos/products/`*
