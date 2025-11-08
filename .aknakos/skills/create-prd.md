# Create PRD Skill

**Purpose**: Generate formal Product Requirements Document from vision and architecture

**Phase**: Phase 2 - PRD Creation

**When to Use**: After product vision and architecture are clear, before Epic breakdown

---

## What This Skill Does

This skill transforms your conversational product vision and architecture decisions into a formal PRD using SHALL/MUST language. This is the last heavy documentation phase before moving to lightweight Epics.

---

## PRD Structure

### 1. Product Overview

**Contents**:
- Product name and tagline
- Problem statement (clear and concise)
- Target users/customers
- Value proposition
- Success metrics

**Format**: Narrative, clear, concise

---

### 2. Goals & Objectives

**Contents**:
- Primary goals (3-5 maximum)
- Success criteria for each goal
- Timeline/milestones
- What defines "done" for this product

**Format**: Bullet points, specific and measurable

---

### 3. Functional Requirements

**Format**: SHALL/MUST language (formal requirements)

**Structure**:
```markdown
## Functional Requirements

### User Authentication

**REQ-AUTH-001**: The system SHALL provide email/password authentication.

**Scenarios**:
- Given a user with valid credentials
- When they submit login form
- Then they SHALL be authenticated and redirected to dashboard

**REQ-AUTH-002**: The system SHALL enforce password complexity requirements.

**Scenarios**:
- Given a user creating an account
- When they enter a password
- Then the system SHALL reject passwords shorter than 12 characters
- And SHALL require at least one uppercase, lowercase, number, and special character
```

**Key Points**:
- Use SHALL for mandatory requirements
- Use SHOULD for recommended but not mandatory
- Use MAY for optional features
- Every requirement has at least one scenario
- Requirements are testable and unambiguous

---

### 4. Non-Functional Requirements

**Contents**:
- **Performance**: Response time, throughput, scalability
- **Security**: Authentication, authorization, data protection
- **Reliability**: Uptime, fault tolerance, recovery
- **Usability**: Accessibility, user experience standards
- **Maintainability**: Code quality, documentation standards

**Format**: SHALL/MUST language with measurable criteria

**Example**:
```markdown
### Performance Requirements

**REQ-PERF-001**: The system SHALL respond to API requests within 200ms for 95th percentile.

**REQ-PERF-002**: The system SHALL support at least 1000 concurrent users.

### Security Requirements

**REQ-SEC-001**: The system SHALL encrypt all data in transit using TLS 1.3 or higher.

**REQ-SEC-002**: The system SHALL hash passwords using bcrypt with minimum cost factor of 12.
```

---

### 5. Technical Approach

**Contents**:
- Architecture summary (from architecture skill)
- Tech stack (frontend, backend, database, infrastructure)
- Key patterns and conventions
- Testing philosophy (including TDD approach)

**Format**: Descriptive with rationale

**Example**:
```markdown
## Technical Approach

### Tech Stack

**Frontend**: React 18 + Vite + TypeScript
- **Rationale**: Modern, performant, excellent TypeScript support

**Backend**: Node.js + Express + TypeScript
- **Rationale**: Team expertise, npm ecosystem, good performance

**Database**: PostgreSQL 15
- **Rationale**: ACID guarantees, JSON support, mature tooling

### Testing Philosophy

This product SHALL follow Test-Driven Development (TDD):
- All features SHALL have tests written before implementation
- Unit test coverage SHALL be minimum 80%
- Integration tests SHALL cover all API endpoints
- E2E tests SHALL cover critical user flows
```

---

### 6. Constraints & Assumptions

**Contents**:
- Technical constraints
- Business constraints (budget, timeline, team)
- Key assumptions
- Known risks

**Format**: Clear bullet points

**Example**:
```markdown
## Constraints

### Technical
- Must run on AWS (company standard)
- Must integrate with existing Auth0 tenant
- Must support IE11 (client requirement)

### Business
- MVP must launch within 3 months
- Development team of 2 engineers
- Budget: $50K for infrastructure first year

## Assumptions

- Users have reliable internet connection
- Users access primarily from desktop (70%+)
- User base will grow 10% month-over-month

## Risks

- Third-party API (payment provider) stability
- Team learning curve with new tech stack
- Scope creep from stakeholder requests
```

---

### 7. Out of Scope

**Contents**: Explicitly list what is NOT included (prevents scope creep)

**Example**:
```markdown
## Out of Scope (For This Release)

- Mobile native apps (future consideration)
- Offline mode (future consideration)
- Multi-language support (future consideration)
- Admin dashboard (will be separate product)
- Advanced analytics (basic analytics only for MVP)
```

---

## PRD Quality Checklist

Before finalizing PRD, verify:

- [ ] All requirements use SHALL/SHOULD/MAY language
- [ ] Every functional requirement has scenarios
- [ ] Non-functional requirements are measurable
- [ ] Tech stack is documented with rationale
- [ ] Success metrics are specific and measurable
- [ ] Constraints and assumptions are explicit
- [ ] Out of scope is clearly defined
- [ ] Testing philosophy includes TDD approach
- [ ] Requirements are testable and unambiguous

---

## File Creation

**Location**: `products/{product-name}/YYYY-MM-DD-prd.md`

**Naming**: Use current date prefix (e.g., `2025-11-08-prd.md`)

**Template**: Use PRD template from `.aknakos/templates/prd-template.md`

---

## After PRD Creation

1. **Review**: Conduct strategic review
   - Are requirements clear and complete?
   - Are success criteria measurable?
   - Are constraints realistic?
   - Is scope appropriate for timeline?

2. **Approval**: Get stakeholder sign-off (if applicable)

3. **Update State**: Update `.aknakos/state/workflow.yaml`
   ```yaml
   current_phase: "prd"
   products:
     my-product:
       prd:
         file: "2025-11-08-prd.md"
         status: "approved"
         review_date: "2025-11-08"
   ```

---

## Example Usage

```
User: Let's use the create-prd skill to formalize our product requirements

Claude: Great! I'll help you create a formal PRD based on our product vision and architecture discussions.

I'll use the PRD template and translate our conversations into formal SHALL/MUST language.

Let me start by pulling together the key points:
[PRD creation begins...]
```

---

## Key Principles

1. **Formal Language**: Use SHALL/MUST - this is a contract
2. **Testable Requirements**: Every requirement must be verifiable
3. **Complete Scenarios**: Provide context for each requirement
4. **Explicit Exclusions**: Say what you're NOT doing
5. **Balance Detail**: Detailed enough to be clear, not so detailed you can't change

---

## Common Pitfalls

**Avoid**:
- Vague requirements ("system should be fast")
- Missing scenarios (how do you test it?)
- Feature descriptions instead of requirements
- Mixing requirements with implementation
- Scope creep (everything is must-have)

**Instead**:
- Specific requirements ("system SHALL respond within 200ms")
- Clear scenarios for every requirement
- Requirement statement with acceptance criteria
- Separate what from how (requirements vs technical approach)
- Prioritize (must-have, should-have, nice-to-have)

---

## What's Next

After PRD is approved:
- **Next Phase**: Epic Breakdown (epic-breakdown skill)
- **Check Status**: Use `whats-next` skill

---

## Integration with TDD

PRD should inform testing approach:
- Functional requirements → Test specifications
- Non-functional requirements → Performance/security tests
- Scenarios → Direct test cases

When breaking into Epics and creating test specs in planning mode, reference PRD requirements for traceability.
