---
name: context-scope
description: Determine optimal context gathering strategy with tier-based approach Use when: When unsure which context loading strategy to use
---


**Purpose**: Determine optimal context gathering strategy with tier-based approach

**Phase**: Before Planning Mode or Epic Breakdown

**When to Use**: When unsure which context loading strategy to use

---

## What This Skill Does

This skill analyzes your context needs using a **3-tier hierarchy** and recommends whether to:
1. Load Tier 1 (Strategic) context - Always required
2. Selectively load Tier 2 (Detailed) context - Use @-mentions or context-fetcher
3. Auto-apply Tier 3 (Standards) context - Reference standards as needed
4. Use planning mode's built-in tools vs spawn Context agent

**Why This Matters**: Context hierarchy ensures lower-level work aligns with higher-level strategic decisions while optimizing token usage.

---

## Context Hierarchy (3-Tier Model)

Based on BMAD + Agent OS patterns:

### Tier 1: Strategic Context (Always Load)

**Documents**:
- `mission.md` - Product vision, purpose, goals
- `tech-stack.md` - Technology choices and rationale
- `roadmap.md` - Development phases and priorities

**Characteristics**:
- Lightweight (1 page each)
- Foundational product context
- Always relevant to any work
- High-level guidance

**When to Load**:
- Always load in planning mode
- Always reference during Epic/Story work
- Always check during implementation

**How to Load**:
```
@.aknakos/products/{name}/mission.md
@.aknakos/products/{name}/tech-stack.md
@.aknakos/products/{name}/roadmap.md
```

---

### Tier 2: Detailed Context (Selective Loading)

**Documents**:
- `project-brief.md` - Market analysis, user personas, competitive landscape (5-8 pages)
- `architecture.md` - System architecture, schemas, API design (5-10 pages)
- `ux-flow.md` - User flows, interface structure, interaction patterns (3-8 pages)
- `prd.md` - Formal requirements with SHALL/MUST language

**Characteristics**:
- Detailed, comprehensive
- Larger documents (3-25 pages)
- Not always fully relevant
- Contains specific decisions and rationale

**When to Load**:
- During planning mode: Load relevant sections via @-mentions
- During Epic breakdown: Load PRD sections for specific Epic
- During architecture decisions: Load architecture.md relevant sections
- During UI/UX work: Load ux-flow.md for user flows and interaction patterns

**How to Load**:

**Option A - @-mentions (Small Scope)**:
```
@.aknakos/products/{name}/prd.md#user-authentication
@.aknakos/products/{name}/architecture.md#database-schema
@.aknakos/products/{name}/ux-flow.md#primary-user-flow
```

**Option B - context-fetcher Agent (Large Scope)**:
```
Spawn context-fetcher agent to extract relevant sections from:
- prd.md: User authentication requirements
- architecture.md: Auth flow and security architecture
- ux-flow.md: Login flow and dashboard interaction patterns
- project-brief.md: Security requirements from market analysis
```

---

### Tier 3: Standards Context (Auto-Apply)

**Precedence** (Hybrid approach):
1. **Product-specific** (if exists): `.aknakos/products/{name}/standards/*.yaml`
2. **Framework defaults**: `.aknakos/standards/*.yaml`

**Documents**:
- `coding-conventions.yaml` - Code style, naming, patterns
- `architecture-patterns.yaml` - Common patterns to use/avoid
- `testing-standards.yaml` - Test structure, coverage requirements
- `security-guidelines.yaml` - Security best practices
- `review-checklist.yaml` - Standard review criteria

**Characteristics**:
- Framework defaults: SvelteKit + Svelte 5 + Better-Auth + Drizzle
- Product-specific overrides: Custom tech stack, stricter security, team conventions
- Apply across product (product-specific) or all products (framework defaults)
- Referenced automatically during implementation and review

**When to Load**:
- Planning mode: Reference testing-standards.yaml for test specs
- Implementation: Apply coding-conventions.yaml
- Review: Check against all standards
- Architecture decisions: Reference architecture-patterns.yaml, security-guidelines.yaml

**How to Check Precedence**:
1. Check if `.aknakos/products/{name}/standards/{standard}.yaml` exists
2. If YES: Use product-specific standard
3. If NO: Use framework default `.aknakos/standards/{standard}.yaml`

**How to Load**:
```
@.aknakos/standards/testing-standards.yaml (when writing test specs)
# OR if product-specific exists:
@.aknakos/products/{name}/standards/testing-standards.yaml
@.aknakos/standards/security-guidelines.yaml (when designing auth)
```

---

## Context Loading Strategy by Work Type

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

## Decision Framework

### Option 1: Planning Mode Built-in Tools

**Use When**:
- Single file or component
- Small scope (2-5 files)
- Well-defined search (you know what to look for)
- New/small codebase

**Tools Available in Planning Mode**:
- **@-mentions**: Reference specific files directly
- **Read**: View file contents
- **Glob**: Find files by pattern
- **Grep**: Search file contents
- **Explore subagent**: Fast, specialized codebase search (Haiku-powered)

**Benefits**:
- No additional token cost
- Immediate availability
- Context stays in main conversation
- Perfect for focused exploration

**Example**:
```
"I need to understand the auth system"

→ Use planning mode:
   - Read src/auth/*.ts files
   - Grep for "authentication" patterns
   - Explore subagent: Search for "auth middleware"
```

---

### Option 2: context-fetcher Agent (Selective Context Extraction)

**New Agent**: `.aknakos/agents/context-fetcher.md`

**Use When**:
- Need specific sections from large Tier 2 documents
- Multiple Tier 2 documents to extract from
- Want to avoid loading full 10-25 page documents
- Need focused context summary

**How It Works** (Agent OS pattern):
- Specialized agent extracts ONLY relevant sections
- Conditional loading: "only if not already in context"
- Returns focused summary instead of full documents
- Prevents token bloat from large docs

**Example**:
```
Spawn context-fetcher agent:

Extract from Tier 2 documents:
- prd.md: User authentication requirements (REQ-AUTH-*)
- architecture.md: Security architecture section
- project-brief.md: Security requirements from competitive analysis

Return focused summary of auth-related context.
```

**Benefits**:
- Token-efficient (extracts vs full load)
- DRY principle (single source of truth)
- Avoids redundant context

**Trade-offs**:
- Additional step (spawn, wait, review)
- Risk of missing context if extraction too narrow

---

### Option 3: Context Agent (Large-Scale Codebase Exploration)

**Use When**:
- Large codebase (100+ files)
- Multi-domain context (frontend + backend + database)
- Architecture-wide understanding needed
- Unfamiliar with codebase structure
- Need comprehensive mapping

**How Context Agent Works**:
- Runs in separate context (doesn't bloat main conversation)
- Explores thoroughly (multiple domains, dependencies, patterns)
- Returns summary report (token-efficient)
- Can run in parallel while you work on something else

**Benefits**:
- Thorough exploration without main context bloat
- Handles complexity well
- Returns structured summary
- Can explore multiple domains simultaneously

**Trade-offs**:
- Additional step (spawn, wait, review results)
- Uses tokens in separate context
- Overkill for simple needs

**Example**:
```
"I need to understand how the entire auth system integrates with
payment processing, user management, and the frontend"

→ Spawn Context agent:
   - Maps auth flow across all layers
   - Identifies integration points
   - Documents patterns and dependencies
   - Returns comprehensive summary
```

---

## Analysis Process

### Step 1: Define What You Need

**Questions**:
- What do you need to understand?
- Why do you need this context?
- How many domains are involved?
- How familiar are you with this codebase?

---

### Step 2: Scope Assessment

**Small Scope**:
- Single file or component: @-mention it
- Specific function/class: Grep or Read
- Known location: Direct file access

**Medium Scope**:
- Several related files (2-10): Planning mode Explore
- One domain (just frontend or just backend): Grep + Glob
- Specific pattern search: Planning mode tools sufficient

**Large Scope**:
- Many files (10+): Consider Context agent
- Multiple domains: Likely need Context agent
- Architecture-wide understanding: Context agent recommended
- Unknown territory: Context agent helps map it

---

### Step 3: Recommendation

Based on analysis, recommend:

**Tier 1: @-Mentions** (< 5 known files)
```
Use @-mentions in planning mode:
@src/auth/login.ts
@src/auth/middleware.ts
```

**Tier 2: Planning Mode Tools** (5-10 files or pattern search)
```
Use planning mode:
- Glob: src/**/*auth*.ts
- Grep: "authentication middleware"
- Explore: Search for "JWT token" patterns
```

**Tier 3: context-fetcher Agent** (Selective Tier 2 extraction)
```
Spawn context-fetcher agent:
- Extract user authentication requirements from prd.md
- Extract security architecture section from architecture.md
- Return focused summary
```

**Tier 4: context-gatherer Agent** (Large codebase exploration)
```
Spawn context-gatherer agent:
- Analyze entire auth system across frontend, backend, database
- Map integration points with payment system
- Document patterns and dependencies
```

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

---

## Examples

### Example 1: Small Scope

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

### Example 2: Medium Scope

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

### Example 3: Large Scope

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

## Optimization Tips

### Start Small, Expand if Needed

1. Try planning mode tools first (cheaper, faster)
2. If overwhelmed → Spawn Context agent
3. Use agent results to guide focused exploration

### Parallel Context Gathering

If you know you'll need large context:
- Spawn Context agent early (while working on something else)
- Agent runs in parallel
- Results ready when you need them

### Context Reuse

After spawning Context agent once:
- Summary remains in conversation context
- No need to spawn again for same area
- Reference summary for subsequent work

---

## Common Patterns

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

## Integration with Workflow

**Epic Breakdown Phase**:
- Use this skill before breaking PRD into Epics
- Helps understand existing code structure
- Informs realistic Epic scoping

**Planning Mode Phase**:
- Use this skill before entering planning mode
- Determines if you need context first
- Prevents getting stuck mid-planning

**Architecture Phase**:
- May need Context agent for existing codebase
- Understand current architecture before designing changes

---

## Example Usage

```
User: Should I use a Context agent to understand the auth system?

Claude: Let me analyze your context needs using the context-scope skill.

What do you need to understand about the auth system, and why?

[User explains]

Based on your needs:
- Scope: Medium (several auth files, one domain)
- Familiarity: Moderate (you know where auth code lives)
- Goal: Modify login flow

Recommendation: Planning mode tools sufficient

Here's how:
1. Enter planning mode (Shift+Tab twice)
2. Glob: src/auth/**/*.ts (find all auth files)
3. Read: src/auth/login.ts (start with login)
4. Grep: "login" (find usage patterns)
5. Explore: Search for "auth middleware"

This should give you the context you need without spawning a Context agent.
```

---

## When in Doubt

**Default to planning mode tools first**:
- Faster
- Cheaper (token-wise)
- Sufficient for most cases

**Escalate to Context agent if**:
- Planning mode exploration feels overwhelming
- You're lost in complexity
- Need multi-domain understanding
- Codebase is very large

---

## Related Skills

- **whats-next**: Check what phase you're in
- **epic-breakdown**: Uses context to create realistic Epics
- Planning mode: Built-in exploration tools
- Context agent: Large-scale context gathering
