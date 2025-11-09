---
name: escalate-conflict
description: Block-and-escalate pattern when Epic/implementation work reveals upper-level doc issues. Stop work → Document conflict → Update parent doc → Re-validate → Resume. Use when validation fails due to PRD/architecture issues OR during planning/implementation when strategic docs are wrong/incomplete.
---

## Instructions

Handle conflicts when lower-level work requires changing upper-level strategic decisions.

**Philosophy**: Strategic docs are guidance, not unchangeable. Changes require formal updates and re-validation.

### Conflict Types

**Type 1: Requirements Conflict**
- PRD requirements contradict each other or impossible to implement together
- Example: "System SHALL respond <100ms" AND "System SHALL run ML inference" (conflicting)

**Type 2: Architecture Inadequacy**
- Architecture doesn't support required functionality
- Example: PRD requires WebSockets, architecture.md specifies serverless (not ideal for persistent connections)

**Type 3: Tech Stack Limitation**
- Chosen tech cannot achieve requirements
- Example: tech-stack.md specifies MongoDB, PRD requires complex relational queries with transactions

**Type 4: Mission-PRD Misalignment**
- PRD doesn't support mission goals
- Example: mission "Keep simple", PRD includes 15 complex admin features in MVP

**Type 5: Scope Expansion**
- Implementation reveals missing requirements
- Example: Realize PRD missing "password reset" during authentication Epic planning

### Escalation Workflow (7 Steps)

**1. Stop Work**
- If in validation: Document conflict in report (Status: FAIL)
- If in planning mode: Exit planning mode
- If in implementation: Stop coding
- **Why**: Prevent building on flawed foundation

**2. Document Conflict**

Create conflict report using template: `.aknakos/templates/conflict-report.md`

Save to: `.aknakos/products/{name}/reviews/conflicts/YYYY-MM-DD-conflict-{type}.md`

**3. Determine Required Change**

Decision tree:
- Product vision/goal issue → Update mission.md
- Market/user understanding → Update project-brief.md
- Technical architecture → Update architecture.md
- Tech stack choice → Update tech-stack.md
- Functional/non-functional requirement → Update prd.md

**4. Present Options to User**

Use `AskUserQuestion` tool to present 2-3 resolution options:
- Each option: description, pros, cons, complexity
- Get user decision before proceeding

**Example**:
```
Conflict: PRD requires <100ms response, but ML inference needs ~500ms

Options:
A) Relax performance requirement to <500ms
B) Move ML inference to async background job
C) Use simpler ML model that can run <100ms
```

**5. Update Parent Document**

After approval:
1. Use Edit tool to update document
2. Add change rationale:
   ```markdown
   **Updated** (YYYY-MM-DD): {Change description}
   **Reason**: {Why needed}
   **Conflict**: See reviews/conflicts/YYYY-MM-DD-conflict-{type}.md
   ```
3. Version update (increment version if applicable)

**6. Re-Validate**

After parent doc updated:
- **If PRD changed**: Re-run `validate-alignment` skill, ensure Epics still align
- **If architecture/tech-stack changed**: Review all Epics for compliance, update acceptance criteria
- **If mission changed**: Verify all downstream docs align with new mission

**7. Resume Work**

Only after re-validation passes:
- If in validation: Continue with validated Epics
- If in planning mode: Re-enter with updated context
- If in implementation: Adjust implementation to new spec

Update workflow.yaml:
```yaml
conflicts_escalated:
  - date: "YYYY-MM-DD"
    type: "{Type}"
    resolution: "{Brief description}"
    documents_updated: ["{Doc}"]
    status: "resolved"
```

### Severity Levels

**Critical** (MUST resolve before proceeding):
- Product cannot launch without resolution
- Major architecture incompatibility
- Mission-critical requirement conflict

**High** (Should resolve, can proceed with documented risk):
- Significant technical risk
- User experience degradation
- Performance/security concern

**Medium** (Can proceed, address in future):
- Nice-to-have feature missing
- Minor spec inconsistency
- Optimization opportunity

### Conflict Prevention

How to avoid conflicts:
1. **Thorough strategic planning**: Use create-project-brief, create-architecture-doc
2. **Run validation early**: Don't skip validate-alignment
3. **Prototype risky decisions**: Test assumptions before committing
4. **Regular alignment checks**: Review mission/PRD periodically

### Examples

See `.aknakos/examples/conflicts/` for detailed examples:
- `prd-requirements-conflict.md`: Performance requirement conflicts with ML feature (resolved via async processing)

Template: `.aknakos/templates/conflict-report.md`

### Integration with Workflow

**Validation Phase**:
- Conflict detected → escalate-conflict skill
- Update docs → re-run validate-alignment

**Planning Mode**:
- Conflict detected → exit planning mode
- Escalate → update docs → re-enter planning mode

**Implementation Phase**:
- Conflict detected → stop implementation
- Escalate → update docs → resume with new spec

### Related Skills

- `validate-alignment`: Catches conflicts early
- `create-prd`, `create-architecture-doc`: Update strategic docs
- `whats-next`: Shows next action after resolution
