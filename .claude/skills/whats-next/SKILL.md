---
name: whats-next
description: Provide intelligent workflow guidance based on current state
---


**Purpose**: Provide intelligent workflow guidance based on current state

**Phase**: Any phase (utility skill)

**When to Use**:
- Starting a new session ("What should I work on?")
- After completing a phase ("What's next?")
- When stuck or uncertain
- After errors or blockers

---

## What This Skill Does

This skill reads `.aknakos/state/workflow.yaml` and provides context-aware guidance about what to do next, current blockers, and available actions.

---

## How It Works

### 1. Read Current State

**Reads**:
- Current phase in workflow
- Active product(s)
- Epic statuses
- TDD cycle position
- Review results
- Open concerns
- Next actions queue

---

### 2. Analyze Context

**Determines**:
- What's blocking progress?
- What's ready to work on?
- What needs attention?
- What can be done in parallel?

---

### 3. Provide Guidance

**Output Format**:
```
📍 Current Phase: {phase}
🎯 Current Product: {product-name}
📋 Current Epic: {epic-name} ({status})

[Section 1: Completed]
[Section 2: Blockers]
[Section 3: Next Steps]
[Section 4: Context Available]
[Section 5: Suggestions]
```

---

## Output Examples

### Example 1: Starting New Session

```
📍 Current Phase: Planning Mode
🎯 Current Product: my-product
📋 Current Epic: user-authentication (planning)

✅ COMPLETED:
- Product vision defined
- PRD created and approved
- 4 Epics created and prioritized

⚡ NEXT STEP:
→ Enter planning mode to break down user-authentication Epic

HOW TO:
1. Shift+Tab twice (enter planning mode)
2. Read Epic file: products/my-product/epics/2025-11-08-user-authentication.md
3. Create Stories with acceptance criteria
4. Create Tasks for each Story
5. Create Test Specifications (critical!)
6. Optionally save plan to products/my-product/plans/user-authentication/

💡 CONTEXT AVAILABLE:
- PRD: products/my-product/2025-11-08-prd.md
- Epic: products/my-product/epics/2025-11-08-user-authentication.md
- Use context-scope skill if unsure about context needs
```

---

### Example 2: Mid-TDD Cycle

```
📍 Current Phase: TDD Implementation (Tests Written)
🎯 Current Product: my-product
📋 Current Epic: user-authentication (tdd_tests_written)

✅ COMPLETED:
- Planning mode completed with test specifications
- All tests written according to plan
- Tests reviewed and match acceptance criteria
- Tests currently FAILING (RED phase - as expected)

⚡ NEXT STEP:
→ Implement code to make tests pass (GREEN phase)

⚠️ CRITICAL RULES:
- DO NOT change tests during implementation
- If tests need changes, STOP immediately:
  1. Update plan with justification
  2. Update tests
  3. Mark in workflow.yaml: tests_changed_during_implementation: true
- Run tests frequently to track progress

💡 CONTEXT AVAILABLE:
- Plan with test specs: products/my-product/plans/user-auth/2025-11-08-plan.md
- Epic: products/my-product/epics/2025-11-08-user-authentication.md
- PRD: products/my-product/2025-11-08-prd.md
- Tests: See test files in codebase
```

---

### Example 3: Review Phase with Blockers

```
📍 Current Phase: Review
🎯 Current Product: my-product
📋 Current Epic: user-authentication (review)

✅ COMPLETED:
- TDD cycle complete (all tests passing)
- 5 parallel review agents completed

⚠️ BLOCKERS:
1. Architecture Review: CONCERNS
   Issue: "Token storage pattern not aligned with OAuth best practices"
   Severity: Medium
   Location: src/auth/token-storage.ts

2. Security Review: CONCERNS
   Issue: "Password reset tokens expire too slowly (24h → should be 1h)"
   Severity: High
   Location: src/auth/password-reset.ts

⚡ NEXT STEPS:
1. Address architecture concerns:
   - Review OAuth token storage best practices
   - Consider spawning tech-exploration agent to compare approaches
   - Update token-storage.ts implementation
   - Re-run architecture-reviewer agent

2. Address security concerns:
   - Update password reset token expiration to 1 hour
   - Update related tests
   - Re-run security-reviewer agent

3. After addressing all concerns:
   - Re-run all reviewers or just specific ones with concerns
   - If all PASS → Mark Epic complete

💡 SUGGESTIONS:
- Tackle security concern first (higher severity)
- Reference PRD REQ-SEC-003 for password reset requirements
- Consider spawning tech-exploration agent for token storage patterns
```

---

### Example 4: Ready for Next Epic

```
📍 Current Phase: Epic Complete
🎯 Current Product: my-product
📋 Last Completed: user-authentication

✅ COMPLETED:
- user-authentication Epic: COMPLETE
  - All reviews PASS
  - All tests passing
  - All acceptance criteria met

📊 EPIC STATUS:
✅ user-authentication: Complete (complexity: 6)
⏸️ dashboard: Drafted (complexity: 4) - Ready for planning
⏸️ payment-processing: Drafted (complexity: 7)
⏸️ settings: Drafted (complexity: 3)

⚡ NEXT OPTIONS:

Option 1 (Recommended): Start dashboard Epic
- Lower complexity (4 vs 7)
- No dependencies
- Enter planning mode for dashboard

Option 2: Start payment-processing Epic
- Higher complexity (7)
- May want to spawn context-gatherer for payment integration research
- Critical for MVP

Option 3: Review & Retrospective
- Use epic-review skill to synthesize learnings from user-authentication
- Document patterns and approaches that worked well

💡 SUGGESTIONS:
- Consider using epic-review skill before starting next Epic
- Learnings from user-authentication may inform other Epics
```

---

### Example 5: Strategic Planning Phase

```
📍 Current Phase: Mission Created
🎯 Current Product: my-product
📋 Strategic Docs: mission.md ✓, roadmap.md ✓

✅ COMPLETED:
- Mission created (product vision, goals, success metrics)
- Roadmap created (development phases, priorities)

⚡ NEXT DECISION:
→ Choose planning depth based on complexity

OPTION 1: Fast Track (Complexity 1-3)
- Skip to PRD creation
- Use create-prd skill
- References mission.md and roadmap.md

OPTION 2: Strategic Track (Complexity 4-9)
- Create project brief (20-30 min BMAD Analyst-style elicitation)
- Use create-project-brief skill
- Deep market analysis, personas, competitive landscape
- Optional: Spawn market-research agent in parallel

OPTION 3: Full Strategic (Complex + Novel Architecture)
- Create project brief first (Option 2)
- Then create architecture document (30-45 min alternatives-driven)
- Use create-architecture-doc skill after brief
- Mandatory alternatives for all tech decisions
- Optional: Spawn tech-exploration agent for comparisons

OPTION 4: Full Strategic + UX (User-Facing Products)
- Create project brief (Option 2)
- Create architecture (Option 3)
- Create UX flow (15-25 min user flow mapping)
- Use create-ux-flow skill after architecture
- Defines user flows, interface structure, interaction patterns
- When: User-facing products with significant UI needs

💡 RECOMMENDATION:
Based on complexity estimate and product type, suggest Option {1/2/3/4}

CONTEXT AVAILABLE:
- mission.md - Product vision and goals
- roadmap.md - Development phases
```

---

### Example 6: Validation Checkpoint

```
📍 Current Phase: Validation
🎯 Current Product: my-product
📋 Epics: 5 created, awaiting validation

✅ COMPLETED:
- Mission, roadmap, tech-stack created
- Project brief created (comprehensive)
- Architecture document created
- PRD created with traceability
- 5 Epics broken down from PRD

⚡ NEXT STEP:
→ Run validation before planning mode

USE SKILL: validate-alignment

WHAT IT CHECKS:
✓ Requirements coverage (all PRD SHALL/MUST have Epics)
✓ Epic-to-PRD traceability (each Epic references PRD)
✓ Architecture compliance (Epics don't contradict architecture.md)
✓ Mission alignment (Epics support product goals)
✓ Completeness (acceptance criteria are testable)
✓ Consistency (no Epic conflicts)

POSSIBLE OUTCOMES:
- PASS → Proceed to planning mode ✅
- CONCERNS → Address recommendations, then proceed ⚠️
- FAIL → Fix critical issues before planning mode ❌

If FAIL: May need to use escalate-conflict skill if parent docs need changes
```

---

### Example 7: Conflict Escalation

```
📍 Current Phase: Planning Mode (BLOCKED)
🎯 Current Product: my-product
📋 Current Epic: payment-processing

⚠️ BLOCKER DETECTED:
Epic requires Stripe integration, but architecture.md specifies PayPal only

⚡ NEXT STEP:
→ Escalate conflict (block-and-escalate pattern)

USE SKILL: escalate-conflict

PROCESS:
1. Stop current work
2. Document conflict (why change needed)
3. Identify which parent doc needs update (architecture.md)
4. Present options to user
5. Update parent doc with justification
6. Re-run validation
7. Resume work

CONFLICT TYPE: Architecture
AFFECTED DOCS: architecture.md, epics/2025-11-08-payment-processing.md
SEVERITY: High (blocks implementation)

OPTIONS:
A) Update architecture.md to support Stripe
B) Modify Epic to use PayPal instead
C) Support both (add complexity)

After resolution:
- Re-run validate-alignment skill
- Ensure no other Epics affected
- Resume planning mode
```

---

### Example 8: No Active Work

```
📍 Current Phase: Not Started
🎯 No active products

💡 GETTING STARTED:

Ready to start a new product? Here's the NEW workflow:

PHASE 1: Strategic Documents (Conversational)

1a. **Create Mission** (Required, 10-15 min)
    Use: create-mission skill
    Output: mission.md + roadmap.md
    When: Every product

1b. **Create Project Brief** (Optional, 20-30 min)
    Use: create-project-brief skill
    Output: project-brief.md (5-8 pages)
    When: Complexity 4-9 OR thorough planning needed
    Style: BMAD Analyst (6 Hats, 5 Whys, role-playing)

1c. **Create Architecture** (Optional, 30-45 min)
    Use: create-architecture-doc skill
    Output: architecture.md + tech-stack.md
    When: Complexity 4-9 OR novel architecture
    Style: BMAD Architect (alternatives-driven)

1d. **Create UX Flow** (Optional, 15-25 min)
    Use: create-ux-flow skill
    Output: ux-flow.md (3-8 pages)
    When: User-facing products with significant UI/UX needs
    Defines: User flows, interface structure, interaction patterns

PHASE 2: PRD (Required)

2. **Create PRD** (15-30 min)
   Use: create-prd skill (enhanced with PM persona)
   References: mission, brief (if exists), architecture (if exists)
   Output: prd.md with SHALL/MUST requirements

PHASE 3: Epic Breakdown

3. **Break into Epics**
   Use: epic-breakdown skill
   Output: Epic files with traceability

PHASE 3.5: Validation (REQUIRED)

3.5. **Validate Alignment**
     Use: validate-alignment skill
     Checks: Epic-PRD-Architecture-Mission alignment
     Must PASS before planning mode

PHASE 4-7: Implementation

4. Planning mode → 5. TDD → 6. Review → 7. Complete

Want to start? Use create-mission skill to begin.
```

---

## Guidance Principles

### 1. Be Specific

**Bad**: "Work on the Epic"
**Good**: "Enter planning mode (Shift+Tab twice) to break down user-authentication Epic"

### 2. Show Context

Always show what files/resources are available:
- PRD location
- Epic location
- Plan location (if exists)
- Relevant code files

### 3. Prioritize by Blockers

Show blockers first, then next steps

### 4. Respect TDD Rules

During TDD cycle, always remind about test change rules

### 5. Suggest Optimizations

Suggest when to:
- Use parallel agents
- Spawn context-gatherer
- Use epic-review skill
- Consider complexity

---

## State Reading Logic

```yaml
# Read workflow.yaml
current_phase: {phase}
products:
  {product-name}:
    mission_created: {true/false}
    project_brief_created: {true/false}
    architecture_created: {true/false}
    ux_flow_created: {true/false}
    validation:
      status: {PASS/CONCERNS/FAIL}
    conflicts: []
    epics:
      - name: {epic-name}
        status: {status}
        # ... analyze status

# Determine guidance based on phase:
if current_phase == "vision" or no products:
    suggest: "Use create-mission skill to start"

elif mission_created and not prd:
    assess_complexity()
    if complexity >= 4:
        suggest: "Create project brief (create-project-brief skill)"
    else:
        suggest: "Create PRD (create-prd skill)"

elif mission_created and project_brief and not architecture:
    if complexity >= 4 or novel_architecture:
        suggest: "Create architecture doc (create-architecture-doc skill)"
    else:
        suggest: "Create PRD (create-prd skill)"

elif architecture_created and not ux_flow and user_facing_product:
    if complexity >= 4 or significant_ui_needs:
        suggest: "Create UX flow (create-ux-flow skill)"
    else:
        suggest: "Create PRD (create-prd skill)"

elif prd and not epics:
    suggest: "Break PRD into Epics (epic-breakdown skill)"

elif epics and validation_status != "PASS":
    suggest: "Run validation (validate-alignment skill)"
    if validation_status == "FAIL":
        warn: "Fix critical issues before planning mode"

elif conflicts.length > 0 and conflicts[0].status == "open":
    suggest: "Resolve conflicts (escalate-conflict skill)"

elif epic.status == "drafted" and validation_status == "PASS":
    suggest: "Enter planning mode"
elif epic.status == "tdd_tests_written":
    suggest: "Implement code (GREEN phase)"
    warn: "Do not change tests"
elif epic.status == "review":
    if reviews have CONCERNS:
        suggest: "Address concerns first"
        check: alignment_checks
        if alignment issues:
            suggest: "May need escalate-conflict if parent docs wrong"
    else:
        suggest: "All reviews pass, mark complete"
```

---

## Integration with Workflow

**After Phase Transitions**:
- After mission created → Suggests project brief (if complex) OR PRD (if simple)
- After project brief → Suggests architecture doc (if complex) OR PRD
- After architecture → Suggests UX flow (if user-facing) OR PRD creation
- After UX flow → Suggests PRD creation
- After PRD created → Suggests Epic breakdown
- After Epics created → Suggests validation
- After validation PASS → Suggests which Epic to start
- After planning → Suggests writing tests
- After tests → Suggests implementing
- After implementation → Shows review results (with alignment checks)
- After Epic complete → Suggests next Epic or retrospective
- On conflict detected → Suggests escalate-conflict skill

---

## Example Usage

```
User: What's next?

Claude: [Reads workflow.yaml]

📍 Current Phase: Planning Mode
🎯 Current Product: my-product
📋 Current Epic: dashboard (planning)

[Provides specific guidance...]
```

---

## Tips for Using This Skill

- Use it liberally - it's designed to be called frequently
- Check it after errors or unexpected results
- Use it when starting a new session
- Use it when unsure what phase you're in
- Trust the guidance - it reads actual state

---

## What This Skill Cannot Do

- Make decisions for you (suggests options, you choose)
- Fix code or errors (guides you to fix them)
- Change workflow state (only reads and advises)
- Bypass blockers (helps you address them)

---

## Related Skills

**Strategic Document Creation**:
- **create-mission**: Create mission.md + roadmap.md (Phase 1a)
- **create-project-brief**: BMAD Analyst-style brief (Phase 1b, optional)
- **create-architecture-doc**: BMAD Architect-style architecture (Phase 1c, optional)
- **create-ux-flow**: UX flow definition (Phase 1d, optional, user-facing)
- **create-prd**: Formal PRD with PM persona (Phase 2)

**Workflow Management**:
- **epic-breakdown**: Break PRD into Epics (Phase 3)
- **validate-alignment**: BMAD PO validation checklist (Phase 3.5)
- **escalate-conflict**: Block-and-escalate for conflicts
- **epic-review**: Synthesize learnings after Epic complete

**Context Management**:
- **context-scope**: 3-tier context strategy guidance

**Legacy**:
- **product-vision**, **elicitation**, **architecture**: Legacy strategic planning
