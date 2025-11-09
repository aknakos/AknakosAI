---
name: whats-next
description: Read workflow.yaml and provide context-aware guidance (current phase, blockers, next steps, available context). Use when starting sessions, after completing phases, when stuck, or after errors.
---

## Instructions

Read `.aknakos/state/workflow.yaml` and provide intelligent workflow guidance based on current state.

### Process

1. **Read State**: Load workflow.yaml
   - Current phase
   - Active product(s)
   - Epic statuses
   - TDD cycle position
   - Review results
   - Open conflicts
   - Validation status

2. **Analyze**:
   - What's blocking progress?
   - What's ready to work on?
   - What needs attention?
   - What can be done in parallel?

3. **Provide Guidance** using format:
   ```
   📍 Current Phase: {phase}
   🎯 Current Product: {product-name}
   📋 Current Epic: {epic-name} ({status})

   ✅ COMPLETED: (if applicable)
   ⚠️ BLOCKERS: (if any)
   ⚡ NEXT STEP(S):
   💡 CONTEXT AVAILABLE / SUGGESTIONS:
   ```

### State Decision Logic

**No products** → Suggest `create-mission` skill

**Mission created, no PRD**:
- If complexity 1-3 → `create-prd` skill
- If complexity 4-9 → `create-project-brief` skill (optional)
- If novel architecture → `create-architecture-doc` skill after brief (optional)
- If user-facing + significant UI → `create-ux-flow` skill after architecture (optional)

**PRD created, no Epics** → `epic-breakdown` skill

**Epics created, validation ≠ PASS** → `validate-alignment` skill
- If FAIL → Fix critical issues, may need `escalate-conflict`
- If CONCERNS → Address recommendations
- If PASS → Proceed to planning mode

**Open conflicts** → `escalate-conflict` skill

**Epic = drafted, validation PASS** → Enter planning mode (Shift+Tab twice)

**Epic = planning** → Create Stories/Tasks/Test Specs in planning mode

**Epic = tdd_tests_written** → Implement code (GREEN phase)
- **Warn**: DO NOT change tests during implementation
- If tests need changes: STOP, update plan, mark in workflow.yaml

**Epic = tdd_implementation** → Continue implementing until tests pass

**Epic = review**:
- If reviews have CONCERNS/FAIL → Address issues, re-review
  - Check if alignment violations (may need `escalate-conflict`)
- If all PASS → Mark Epic complete

**Epic = complete** → Suggest next Epic OR `epic-review` skill for retrospective

### Phase Transition Guidance

**After mission** → Project brief (if complex) OR PRD (if simple)
**After project brief** → Architecture doc (if complex) OR PRD
**After architecture** → UX flow (if user-facing) OR PRD
**After UX flow** → PRD
**After PRD** → Epic breakdown
**After Epics** → Validation
**After validation PASS** → Planning mode for first Epic
**After planning** → Write tests (RED)
**After tests** → Implement (GREEN)
**After implementation** → Review (5 parallel agents)
**After reviews PASS** → Epic complete
**After Epic complete** → Next Epic or retrospective
**On conflict** → Escalate

### Guidance Principles

**Be Specific**: "Enter planning mode (Shift+Tab twice)" not "Work on Epic"

**Show Context**: List available files:
- PRD location
- Epic location
- Plan location (if exists)
- Relevant docs (mission, architecture, ux-flow)

**Prioritize Blockers**: Show blockers before next steps

**Respect TDD Rules**: During TDD, always remind about test change rules

**Suggest Optimizations**:
- When to spawn parallel agents (market-research, tech-exploration, context-gatherer)
- When to use epic-review
- Consider complexity when choosing Epic

### Detailed Examples

See `.aknakos/examples/workflows/whats-next-scenarios.md` for 8 complete scenario examples:
1. Starting new session (planning mode)
2. Mid-TDD cycle (tests written, ready for implementation)
3. Review phase with blockers (CONCERNS found)
4. Ready for next Epic (previous complete)
5. Strategic planning phase (mission created, choosing depth)
6. Validation checkpoint (Epics created, need validation)
7. Conflict escalation (planning blocked by architecture mismatch)
8. No active work (getting started)

### Related Skills

**Strategic Documents**:
- `create-mission`: Mission + roadmap (Phase 1a, required)
- `create-project-brief`: BMAD Analyst brief (Phase 1b, optional)
- `create-architecture-doc`: BMAD Architect doc (Phase 1c, optional)
- `create-ux-flow`: UX flow (Phase 1d, optional)
- `create-prd`: PRD with PM persona (Phase 2, required)

**Workflow Management**:
- `epic-breakdown`: Break PRD into Epics (Phase 3)
- `validate-alignment`: BMAD PO validation (Phase 3.5, required)
- `escalate-conflict`: Block-and-escalate for conflicts
- `epic-review`: Synthesize learnings after Epic

**Context**:
- `context-scope`: 3-tier context strategy guidance
