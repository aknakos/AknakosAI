---
name: epic-breakdown
description: Break PRD into lightweight Epic files with acceptance criteria, dependencies, complexity estimates, and PRD requirement traceability. Optionally use epic-parallel agent for large PRDs. Use after PRD approved, before planning mode.
---

## Instructions

Break formal PRD into manageable Epics. Each Epic represents cohesive functionality that can be planned and implemented independently.

### When to Use

**Use**: After PRD is approved, before planning mode

**Phase**: 3 (Epic Breakdown)

---

## Epic Characteristics

A good Epic:
- **Cohesive**: Related functionality grouped
- **Independent**: Can be built without blocking others (mostly)
- **Valuable**: Delivers user or business value
- **Testable**: Clear acceptance criteria
- **Right-sized**: 1-3 weeks of work (roughly)

---

## Process

### 1. Read and Understand PRD

Actions:
- Read PRD file: `.aknakos/products/{product-name}/YYYY-MM-DD-prd.md`
- Identify major functional areas
- Group related requirements
- Consider natural boundaries (auth, payments, user management, etc.)

### 2. Identify Epics

Common Epic Patterns:
- **By feature area**: User Authentication, Payment Processing, Dashboard
- **By user journey**: Onboarding, Core Workflow, Reporting
- **By system component**: API Layer, Database Schema, Frontend UI
- **By release phase**: MVP Features, Phase 2 Features, Nice-to-Haves

Tips:
- Start with 3-7 Epics (not too many, not too few)
- Each Epic should feel like a "project" you could assign
- Dependencies are okay, but minimize them
- Consider what can be built in parallel

### 3. Define Each Epic

For each Epic, specify:
- **Name**: Clear, descriptive (e.g., "user-authentication", "payment-processing")
- **Description**: 2-3 sentences explaining what this Epic accomplishes
- **Acceptance Criteria**: What must be true when this Epic is complete
- **Dependencies**: Which Epics must be done first (if any)
- **Complexity**: Estimate 1-9 scale (1-3: Trivial/few days, 4-6: Moderate/1-2 weeks, 7-9: Complex/2-3 weeks)
- **Related PRD Requirements**: List relevant PRD requirement IDs

### 4. Consider Alternative Designs (If Non-Trivial)

**When**: For complex Epics (complexity 6+) with multiple implementation strategies

Process:
1. Identify if Epic could be implemented in 2-3 different ways
2. For each alternative: brief description, pros/benefits, cons/drawbacks
3. Use `AskUserQuestion` tool to present alternatives
4. Document choice briefly in Epic's "Alternative Designs" section

Example Scenarios: Authentication (OAuth vs JWT vs Session), Data sync (WebSocket vs Polling vs SSE), File upload (Direct S3 vs Through server vs Presigned URLs), State management (Redux vs Context vs Zustand)

Documentation Format:
```markdown
## Alternative Designs

**Alternative A**: OAuth 2.0 with third-party provider (Auth0)
- Pros: Proven security, faster to implement, social login support
- Cons: External dependency, recurring costs

**Alternative B**: Custom JWT authentication
- Pros: Full control, no external dependencies, no recurring cost
- Cons: More implementation work, security responsibility

**Chosen**: Alternative A (OAuth with Auth0)
**Rationale**: Security complexity not worth building ourselves; team lacks auth expertise
```

Note: Only present alternatives for non-trivial Epics where multiple approaches genuinely exist

### 5. Epic File Structure

Template:
```markdown
# Epic: {Epic Name}

**Status**: Drafted
**Complexity**: {1-9}
**Created**: {YYYY-MM-DD}
**Dependencies**: {Other Epic names, or "None"}

## Description

{2-3 sentence description of what this Epic accomplishes}

## Acceptance Criteria

- [ ] {Criterion 1}
- [ ] {Criterion 2}
- [ ] {Criterion 3}

## Related PRD Requirements

- REQ-AUTH-001: Email/password authentication
- REQ-AUTH-002: Password complexity requirements

## Notes

{Any additional context, technical considerations, or open questions}
```

---

## Parallel Epic Creation

For large PRDs with many Epics:

```
Spawn epic-parallel agent with PRD to generate multiple Epics simultaneously
```

The agent creates multiple Epic files in parallel, saving time.

---

## Context Gathering

**Before Epic Breakdown**, determine if you need codebase context:

Use `context-scope` skill to decide:
- **Small/new project**: No context needed
- **Medium project**: Use @-mentions to reference relevant files
- **Large existing codebase**: Spawn context-gatherer agent

Why: Understanding existing architecture helps create realistic Epics

---

## Epic Prioritization

After creating Epics, consider priority:

**Must-Have (MVP)**: Critical for product to function, blocks other features, delivers core value

**Should-Have**: Important but not critical, enhances value significantly, can be added post-MVP

**Nice-to-Have**: Nice additions, can be delayed, future roadmap

---

## File Creation

**Location**: `.aknakos/products/{product-name}/epics/YYYY-MM-DD-epic-name.md`

**Naming**: Date prefix + lowercase-with-hyphens (Example: `2025-11-08-user-authentication.md`)

**Template**: Use Epic template from `.aknakos/templates/epic-template.md`

---

## Update Workflow State

After creating Epics:

```yaml
# .aknakos/state/workflow.yaml
current_phase: "epic_breakdown"
products:
  my-product:
    epics:
      - name: "user-authentication"
        file: "2025-11-08-user-authentication.md"
        status: "drafted"
        implementation_complexity: 6
        created_date: "2025-11-08"
      - name: "dashboard"
        file: "2025-11-08-dashboard.md"
        status: "drafted"
        implementation_complexity: 4
        created_date: "2025-11-08"
```

---

## Epic Feasibility Review

Before proceeding, review Epics:

Questions: Do all Epics together fulfill the PRD? Is each Epic independently valuable? Are dependencies minimized? Is complexity realistic? Are acceptance criteria clear?

If Issues: Combine small Epics, split large Epics, reorder to minimize dependencies, clarify acceptance criteria

---

## Tips

- **Keep Epics lightweight**: Just acceptance criteria + dependencies
- **Don't over-specify**: Details come in planning mode
- **Think parallel**: What can different developers work on simultaneously?
- **Consider MVP**: Which Epics are must-have for launch?
- **Document dependencies**: Makes scheduling easier
- **Estimate honestly**: Complexity guides review depth later

Avoid: Epics too small (creates overhead), Epics too large (hard to plan), too many dependencies (blocks progress), vague acceptance criteria, missing PRD requirement references

---

## What's Next

After Epics created and reviewed:
- **Next Phase**: Planning Mode (choose an Epic, enter planning mode with Shift+Tab twice)
- **Check Status**: Use `whats-next` skill
