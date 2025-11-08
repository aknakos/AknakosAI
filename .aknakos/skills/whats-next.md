# What's Next Skill

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

### Example 5: No Active Work

```
📍 Current Phase: Vision
🎯 No active products

💡 GETTING STARTED:

Ready to start a new product? Here's the workflow:

1. **Product Vision** (use product-vision skill)
   - Define problem, users, value proposition
   - Optional: Spawn market-research agents in parallel

2. **Architecture** (use architecture skill)
   - Choose tech stack
   - Define patterns
   - Optional: Spawn tech-exploration agents

3. **Create PRD** (use create-prd skill)
   - Formalize requirements (SHALL/MUST language)
   - Review and approve

4. **Epic Breakdown** (use epic-breakdown skill)
   - Break PRD into Epics
   - Prioritize

5. **Start Implementing** (planning mode + TDD)
   - Choose Epic
   - Enter planning mode
   - Create Stories + Tasks + Test Specs
   - Write tests, implement, review

Want to start? Use product-vision skill to begin.
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
    epics:
      - name: {epic-name}
        status: {status}
        # ... analyze status

# Determine guidance based on:
if status == "drafted":
    suggest: "Enter planning mode"
elif status == "tdd_tests_written":
    suggest: "Implement code (GREEN phase)"
    warn: "Do not change tests"
elif status == "review":
    if reviews have CONCERNS:
        suggest: "Address concerns first"
    else:
        suggest: "All reviews pass, mark complete"
```

---

## Integration with Workflow

**After Phase Transitions**:
- After PRD created → Suggests Epic breakdown
- After Epics created → Suggests which Epic to start
- After planning → Suggests writing tests
- After tests → Suggests implementing
- After implementation → Shows review results
- After Epic complete → Suggests next Epic or retrospective

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

- **context-scope**: Decide if context agent needed
- **epic-review**: Synthesize learnings after Epic complete
- **product-vision**, **architecture**, **create-prd**, **epic-breakdown**: Workflow progression skills
