# Architecture Skill

**Purpose**: Guide technical architecture exploration and decisions

**Phase**: Phase 1 - Strategic Vision

**When to Use**: Making architectural decisions, choosing tech stack, defining patterns

---

## What This Skill Does

This skill helps you explore and make architectural decisions through conversational discussion. It considers multiple approaches, evaluates trade-offs, and helps you choose the right technical foundation.

---

## Process

### 1. Architecture Fundamentals

**Questions to Explore**:
- What type of application is this? (Web, mobile, desktop, API, etc.)
- What scale do you need to support? (Users, requests, data volume)
- What are the performance requirements?
- What are the reliability requirements?
- What are the security requirements?

**Output**: Architectural constraints and requirements

---

### 2. Tech Stack Selection

**Questions to Explore**:

**Frontend** (if applicable):
- Framework? (React, Vue, Svelte, etc.)
- State management? (Redux, Zustand, Context, etc.)
- Styling? (Tailwind, CSS-in-JS, CSS Modules, etc.)
- Build tool? (Vite, Webpack, etc.)

**Backend** (if applicable):
- Language? (Node.js, Python, Go, Java, etc.)
- Framework? (Express, FastAPI, Gin, Spring, etc.)
- API style? (REST, GraphQL, gRPC, etc.)

**Database**:
- Type? (SQL, NoSQL, hybrid)
- Specific DB? (PostgreSQL, MongoDB, Redis, etc.)
- ORMs/query builders?

**Infrastructure**:
- Hosting? (Cloud provider, bare metal, serverless)
- Deployment? (Docker, Kubernetes, serverless functions)
- CI/CD? (GitHub Actions, CircleCI, etc.)

**Output**: Chosen tech stack with justifications

---

### 3. Architectural Patterns

**Questions to Explore**:
- Monolith or microservices? (Or modular monolith?)
- Layered architecture? (Presentation, business, data)
- Authentication/authorization approach?
- Error handling patterns?
- Logging and observability?
- Testing strategy?

**Output**: Chosen patterns and conventions

---

### 4. Data Architecture

**Questions to Explore**:
- What are the main entities/models?
- What are the relationships?
- What are the access patterns?
- What needs to be fast? What can be slow?
- What data needs to be consistent vs eventually consistent?
- Caching strategy?

**Output**: Data model and access patterns

---

### 5. Trade-off Analysis

For each significant decision, consider:

**Performance vs Simplicity**:
- Optimize now or later?
- Caching everywhere or keep it simple?

**Flexibility vs Convention**:
- Flexible architecture or opinionated?
- Many options or one way to do things?

**Scale vs Cost**:
- Build for current scale or future scale?
- Premium infrastructure or start simple?

**Output**: Documented trade-offs and chosen direction

---

## Parallel Exploration

Consider spawning agents to explore multiple approaches:

```
Spawn tech-exploration agent to compare:
- React + Vite vs Next.js vs Remix
- Express vs FastAPI vs Gin
- PostgreSQL vs MongoDB for this use case
```

Agents explore in parallel and return comparison matrices.

---

## Key Principles

1. **Start Simple, Scale Later**: Don't over-engineer for future scale you don't have
2. **Choose Boring Technology**: Proven tech > shiny new tech (usually)
3. **Optimize for Change**: Architecture should enable easy changes
4. **Document Decisions**: Capture WHY you chose X over Y
5. **Constraints Drive Clarity**: Use constraints to narrow options

---

## Architecture Decision Records (ADRs)

For significant decisions, consider documenting:

```markdown
## Decision: Use PostgreSQL for primary database

**Context**: Need reliable, structured data storage for user accounts and transactions

**Options Considered**:
- PostgreSQL (chosen)
- MongoDB
- MySQL

**Decision**: PostgreSQL

**Rationale**:
- Strong ACID guarantees (critical for transactions)
- Excellent JSON support (flexibility when needed)
- Mature ecosystem and tooling
- Team has PostgreSQL experience

**Consequences**:
- Need to run PostgreSQL in production (infrastructure cost)
- Schema migrations required for changes
- Excellent query performance for relational data
```

---

## Integration with PRD

Architecture decisions should inform the PRD:
- Tech stack → Mentioned in PRD technical approach
- Patterns → Referenced in PRD constraints
- Trade-offs → Inform PRD scope and timeline

---

## Artifacts Created

**During Skill**: Conversational exploration (in-context)

**After Skill**: Optionally document:
- Architecture summary
- Tech stack decisions
- Key patterns and conventions
- Architecture Decision Records (ADRs)

**Storage**: Can be referenced in PRD or stored separately

---

## Example Usage

```
User: Let's use the architecture skill to explore tech stack options

Claude: Great! Let's explore the architecture for your product.

Based on your product vision, I understand you're building [summary].
Let's start with some fundamental questions:

1. What type of application is this primarily?
[Conversational exploration begins...]
```

---

## Tips for Success

- Don't choose tech based on hype - choose based on fit
- Consider your team's expertise (learning curve matters)
- Prototype critical unknowns before committing
- Use parallel agents to compare approaches objectively
- Document WHY you chose things (future you will thank you)
- Architecture can evolve - don't overthink initial choices

---

## What's Next

After architecture decisions:
- **Option 1**: Create formal PRD (create-prd skill) - architecture informs PRD
- **Option 2**: Do more exploration (spawn tech-exploration agents)
- **Option 3**: Refine product vision based on architecture constraints

Use `whats-next` skill for personalized guidance.
