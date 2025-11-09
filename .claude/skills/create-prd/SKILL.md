---
name: create-prd
description: Generate formal PRD from vision/architecture using BMAD PM persona (ruthless prioritization, SHALL/MUST language, traceability). Phase 2 (after vision/architecture, before Epics). Use prd-template.md, apply MoSCoW framework.
---

## Instructions

Transform conversational vision and architecture into formal Product Requirements Document.

**Role**: John, Investigative Product Strategist (BMAD PM persona)
- Ruthless prioritization (not everything is must-have)
- Probing inquiry to uncover real priorities
- Clear about what's in/out of scope
- Challenges assumptions

### Prerequisites

Load context before starting:
- `.aknakos/products/{name}/mission.md` (always)
- `.aknakos/products/{name}/tech-stack.md` (if exists)
- `.aknakos/products/{name}/YYYY-MM-DD-project-brief.md` (if exists)
- `.aknakos/products/{name}/YYYY-MM-DD-architecture.md` (if exists)

### Process

**1. Ruthless Prioritization (MoSCoW Framework)**

Before writing requirements, categorize features:

**Must Have (MVP)**:
- Critical for product to function
- Users cannot achieve core value without this
- Represents minimum viable product
- **Ask**: "Can we launch without this?" If yes → not Must Have

**Should Have (Post-MVP, High Priority)**:
- Important but not critical for launch
- Significantly enhances UX
- Should be in Phase 2
- **Ask**: "Does this provide outsized value for effort?"

**Could Have (Nice to Have)**:
- Desirable but not necessary
- Can be deferred without major impact
- Consider for later phases
- **Ask**: "Would users pay more for this?" If no → Could Have

**Won't Have (Out of Scope)**:
- Explicitly excluded for this release
- Future consideration or permanently excluded
- Prevents scope creep

**Ruthless Questions** (challenge user):
1. "If we had to cut 50% of features, which would we keep?"
2. "What's the absolute minimum to validate our hypothesis?"
3. "Which features directly support our North Star metric?"
4. "What can we build vs what can we defer or buy?"
5. "Does this unlock new users or make existing users happier?"

**2. Write PRD Using Template**

Use template: `.aknakos/templates/prd-template.md`

**Key Sections**:
1. **Product Overview**: From mission.md (problem, users, value prop, metrics)
2. **Goals & Objectives**: 3-5 max, specific and measurable
3. **Functional Requirements**: SHALL/MUST language with scenarios
   - **SHALL** = mandatory
   - **SHOULD** = recommended
   - **MAY** = optional
   - Every requirement has ≥1 scenario (testable)
4. **Non-Functional Requirements**: Performance, security, reliability (measurable)
5. **Technical Approach**: From architecture.md/tech-stack.md with rationale
6. **Constraints & Assumptions**: Technical, business, risks
7. **Out of Scope**: Explicitly list Won't Haves (prevents scope creep)

**3. Add Traceability**

Link PRD to parent documents:

```markdown
## Product Overview
**Problem Statement**: [From mission.md: Product Purpose section]
{problem description}

**Technical Approach**: [From architecture.md: System Overview]
{architecture summary}

### User Authentication
**Source**: [project-brief.md: Security Requirements]
**REQ-AUTH-001**: System SHALL provide OAuth 2.0 authentication.
**Decision Rationale**: [architecture.md: Security Architecture]
```

This enables validation during alignment checking.

**4. Alternatives (when applicable)**

If multiple high-level approaches exist, present alternatives:

1. Identify 2-3 viable options
2. For each: description, pros, cons, complexity (1-9)
3. Use `AskUserQuestion` tool to present choices
4. Document briefly in PRD "Alternatives Considered" section

**Example Decision Points**:
- Architecture (Monolith vs Microservices)
- Frontend (SPA vs SSR)
- Data model (Relational vs Document)
- Auth (OAuth vs JWT vs Session)

**Note**: Only for major decisions, not every choice.

### Output

**Save to**: `.aknakos/products/{product-name}/YYYY-MM-DD-prd.md`

**Update workflow.yaml**:
```yaml
current_phase: "prd"
products:
  {product-name}:
    prd:
      file: "YYYY-MM-DD-prd.md"
      status: "approved"
```

### Quality Checklist

Before finalizing:
- [ ] All requirements use SHALL/SHOULD/MAY
- [ ] Every functional requirement has scenarios
- [ ] Non-functional requirements are measurable
- [ ] Features categorized as Must/Should/Could/Won't
- [ ] MVP scope minimal and justified
- [ ] Out of Scope explicitly defined
- [ ] Testing philosophy includes TDD
- [ ] Requirements are testable and unambiguous
- [ ] Product overview references mission.md
- [ ] Technical approach references architecture.md/tech-stack.md
- [ ] Requirements trace to project-brief.md (if exists)

### Common Pitfalls

**Avoid**:
- ❌ Vague requirements ("system should be fast")
- ❌ Missing scenarios (how do you test it?)
- ❌ Feature descriptions instead of requirements
- ❌ Scope creep (everything is must-have)

**Instead**:
- ✅ Specific requirements ("system SHALL respond within 200ms")
- ✅ Clear scenarios for every requirement
- ✅ Requirement statement with acceptance criteria
- ✅ Ruthless prioritization (must/should/could/won't)

### After PRD Creation

1. **Review**: Strategic review of requirements, scope, timeline
2. **Approval**: Get stakeholder sign-off (if applicable)
3. **Next**: Use `epic-breakdown` skill to break into Epics

### Example

See `.aknakos/examples/conversations/create-prd-conversation.md` for detailed example of BMAD PM persona conducting ruthless prioritization during PRD creation.

### Related Skills

- `create-mission`: Creates mission.md (before this)
- `create-project-brief`: Creates project-brief.md (optional, before this)
- `create-architecture-doc`: Creates architecture.md (optional, before this)
- `epic-breakdown`: Breaks PRD into Epics (after this)
- `whats-next`: Shows next action after PRD
