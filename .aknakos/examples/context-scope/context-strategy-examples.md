# Context Strategy Examples

## Example 1: Small Scope

**Situation**: "I need to modify the login function"

**Analysis**:
- Single file/function
- Specific location
- Well-defined task

**Recommendation**:
```
Use @-mention in planning mode:
@src/auth/login.ts

Or simply Read the file if you know where it is.
```

---

## Example 2: Medium Scope

**Situation**: "I need to understand how authentication works"

**Analysis**:
- Several related files (auth module)
- One domain (backend auth)
- Pattern search helpful

**Recommendation**:
```
Use planning mode tools:
1. Glob: src/auth/**/*.ts (find all auth files)
2. Grep: "authentication" (find usage patterns)
3. Explore: Search for "auth middleware" and "session management"
4. Read key files identified
```

---

## Example 3: Large Scope

**Situation**: "I need to understand how authentication integrates with the entire system including frontend, payments, and user management"

**Analysis**:
- Many files across multiple domains
- Architecture-wide understanding
- Complex integration points
- Unfamiliar with structure

**Recommendation**:
```
Spawn context-gatherer agent:

Scope: "Map authentication system across entire application:
- Frontend: Auth components, login flows, session handling
- Backend: Auth middleware, routes, session management
- Database: User schema, session storage
- Integrations: How auth connects to payments, user management
- Patterns: Auth patterns used throughout codebase"

Agent will explore thoroughly and return comprehensive summary.
```

---

## Context Loading by Work Type

### Working on Epic Breakdown

**Load**:
- **Tier 1**: mission.md, roadmap.md, tech-stack.md (always)
- **Tier 2**: prd.md (full document or relevant sections)
- **Tier 3**: Not needed yet

**Rationale**: Need full product context + requirements to create realistic Epics

---

### Working in Planning Mode (Story/Task Creation)

**Load**:
- **Tier 1**: mission.md, tech-stack.md (always)
- **Tier 2**:
  - Current Epic file (always)
  - @-mention relevant PRD sections (specific requirements)
  - @-mention relevant architecture patterns (if novel architecture)
- **Tier 3**: testing-standards.yaml (for test specs)

**Rationale**: Need Epic context + specific requirements + testing guidance

---

### Working on Implementation

**Context already in plan** (from planning mode output):
- Plan contains distilled context
- No additional loading needed
- Self-contained

**If context missing**:
- Re-enter planning mode
- Load Tier 1 + relevant Tier 2 sections
- Update plan

---

### Working on Architecture Decisions

**Load**:
- **Tier 1**: mission.md, roadmap.md (always)
- **Tier 2**:
  - project-brief.md (user needs, scale requirements)
  - architecture.md (existing architecture if modifying)
- **Tier 3**: architecture-patterns.yaml, security-guidelines.yaml

**Rationale**: Need product vision + user context + existing architecture + standards

---

## Decision Framework Table

| Situation | Context Strategy |
|-----------|------------------|
| Epic breakdown | Tier 1 (always) + Tier 2 (prd.md full) |
| Planning mode | Tier 1 + Epic + @-mention PRD sections + Tier 3 (testing standards) |
| Implementation | Context in plan (self-contained) |
| Architecture decisions | Tier 1 + Tier 2 (project-brief, architecture) + Tier 3 (patterns, security) |
| Need PRD sections | @-mention specific sections OR context-fetcher agent |
| Need architecture sections | @-mention specific sections OR context-fetcher agent |
| Modify specific file | @-mention or Read |
| Understand subsystem | Planning mode Explore |
| Large codebase exploration | context-gatherer agent |
| Quick lookup | Planning mode |

---

## Context Agent Workflow

If Context agent recommended:

### 1. Spawn Agent

```
Spawn context-gatherer agent to map the authentication system:
- Include frontend auth components
- Include backend auth middleware and routes
- Include database schema for users/sessions
- Document how auth integrates with other systems
```

### 2. Wait for Results

Agent explores in separate context and returns summary report

### 3. Review Summary

Agent provides:
- Architecture overview
- Key files and their purposes
- Integration points
- Patterns used
- Dependencies
- Recommendations

### 4. Use Context

Apply summary context to your work:
- Enter planning mode with summary in mind
- Reference specific files mentioned in summary
- Follow patterns identified
