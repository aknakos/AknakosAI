---
name: architecture
description: Guide technical architecture exploration and decisions using alternatives pattern. MANDATORY for ALL tech/architecture decisions present 2-3 alternatives using AskUserQuestion tool. Use when making architectural decisions, choosing tech stack, defining patterns.
---

## Instructions

Explore and make architectural decisions through conversational discussion. Consider multiple approaches, evaluate trade-offs, choose the right technical foundation.

### When to Use

**Use**: Making architectural decisions, choosing tech stack, defining patterns

**Phase**: 1 (Strategic Vision)

---

## ⚠️ MANDATORY: Always Present Alternatives

**CRITICAL RULE**: For EVERY tech/architecture decision, you MUST present 2-3 alternatives using `AskUserQuestion` tool.

**Tech decisions include**: Framework choices (React vs Vue vs Svelte), Database selection (PostgreSQL vs MongoDB vs MySQL), Architecture patterns (Monolith vs Microservices vs Serverless), API style (REST vs GraphQL vs gRPC), Authentication method (OAuth vs JWT vs Session), State management (Redux vs Zustand vs Context API), Hosting/infrastructure (AWS vs Vercel vs self-hosted)

**Process for EVERY decision**:
1. Identify 2-3 viable options
2. For each option: description, pros/benefits, cons/drawbacks, complexity (1-9 scale)
3. **Use `AskUserQuestion` tool** to present alternatives
4. Document choice with brief rationale

Example:
```
Use AskUserQuestion to present:

Option A: React + Vite
- Pros: Large ecosystem, team experience, fast build times
- Cons: Requires more setup, larger bundle
- Complexity: 5/10

Option B: Next.js
- Pros: Full-stack framework, SSR built-in, great DX
- Cons: Opinionated, vendor lock-in, heavier
- Complexity: 6/10

Option C: Svelte + SvelteKit
- Pros: Smallest bundles, simple syntax, fast runtime
- Cons: Smaller ecosystem, less team experience
- Complexity: 4/10
```

**No exceptions**: Tech decisions are critical and must be explored thoroughly.

---

## Process

### 1. Architecture Fundamentals

Questions to Explore: What type of application? (Web, mobile, desktop, API) What scale? (Users, requests, data volume) Performance requirements? Reliability requirements? Security requirements?

Output: Architectural constraints and requirements

### 2. Tech Stack Selection

Questions:
- **Frontend** (if applicable): Framework? State management? Styling? Build tool?
- **Backend** (if applicable): Language? Framework? API style?
- **Database**: Type? (SQL, NoSQL, hybrid) Specific DB? ORMs/query builders?
- **Infrastructure**: Hosting? Deployment? CI/CD?

Output: Chosen tech stack with justifications

### 3. Architectural Patterns

Questions: Monolith or microservices? Layered architecture? Authentication/authorization approach? Error handling patterns? Logging and observability? Testing strategy?

Output: Chosen patterns and conventions

### 4. Data Architecture

Questions: Main entities/models? Relationships? Access patterns? What needs to be fast vs slow? Consistency requirements? Caching strategy?

Output: Data model and access patterns

### 5. Trade-off Analysis

For each significant decision, consider:
- **Performance vs Simplicity**: Optimize now or later? Caching everywhere or keep it simple?
- **Flexibility vs Convention**: Flexible architecture or opinionated? Many options or one way?
- **Scale vs Cost**: Build for current scale or future scale? Premium infrastructure or start simple?

Output: Documented trade-offs and chosen direction

---

## Parallel Exploration (Recommended for Deep Comparison)

**When to use**: When you need detailed technical comparison of alternatives

**Recommended**: Use `tech-exploration` agent for deep, parallel comparison:

```
Spawn tech-exploration agent to compare:
- React + Vite vs Next.js vs Remix
- Express vs FastAPI vs Gin
- PostgreSQL vs MongoDB for this use case
```

**Benefits**: Agent explores options in parallel (separate context), returns detailed comparison matrix, saves main context from exploration overhead, provides objective analysis

**Then**: Use `AskUserQuestion` to present findings and get user decision

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

**Options Considered**: PostgreSQL (chosen), MongoDB, MySQL

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

## Tips

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
