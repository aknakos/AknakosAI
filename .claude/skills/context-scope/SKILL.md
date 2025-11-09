---
name: context-scope
description: Determine optimal context gathering strategy using 3-tier hierarchy (Strategic/Detailed/Standards). Recommends @-mentions, planning mode tools, context-fetcher agent, or context-gatherer agent based on scope assessment. Use before planning mode or Epic breakdown when unsure which context loading strategy to use.
---

## Instructions

Analyze context needs using 3-tier hierarchy and recommend whether to load Tier 1 (Strategic) always, selectively load Tier 2 (Detailed) via @-mentions or context-fetcher, auto-apply Tier 3 (Standards), or spawn Context agent for large-scale exploration.

### When to Use

**Use**: Before planning mode or Epic breakdown when unsure which context loading strategy to use

**Don't Use**: Clear simple scope (just read the file directly)

---

## Context Hierarchy (3-Tier Model)

Based on BMAD + Agent OS patterns.

### Tier 1: Strategic Context (Always Load)

**Documents**: mission.md (vision, goals), tech-stack.md (technology choices), roadmap.md (phases, priorities)

**Characteristics**: Lightweight (1 page each), foundational product context, always relevant, high-level guidance

**When to Load**: Always in planning mode, always during Epic/Story work, always during implementation

**How to Load**:
```
@.aknakos/products/{name}/mission.md
@.aknakos/products/{name}/tech-stack.md
@.aknakos/products/{name}/roadmap.md
```

---

### Tier 2: Detailed Context (Selective Loading)

**Documents**: project-brief.md (5-8 pages: market, personas, competitive), architecture.md (5-10 pages: system, schemas, API), ux-flow.md (3-8 pages: flows, interface, interactions), prd.md (formal requirements SHALL/MUST)

**Characteristics**: Detailed comprehensive, larger documents (3-25 pages), not always fully relevant, specific decisions and rationale

**When to Load**: During planning mode (relevant sections via @-mentions), Epic breakdown (PRD sections), architecture decisions (architecture.md sections), UI/UX work (ux-flow.md)

**How to Load**:

**Option A - @-mentions** (Small Scope):
```
@.aknakos/products/{name}/prd.md#user-authentication
@.aknakos/products/{name}/architecture.md#database-schema
@.aknakos/products/{name}/ux-flow.md#primary-user-flow
```

**Option B - context-fetcher Agent** (Large Scope):
```
Spawn context-fetcher agent to extract relevant sections from:
- prd.md: User authentication requirements
- architecture.md: Auth flow and security architecture
- ux-flow.md: Login flow and dashboard interaction patterns
- project-brief.md: Security requirements from market analysis
```

---

### Tier 3: Standards Context (Auto-Apply)

**Precedence** (Hybrid):
1. **Product-specific** (if exists): `.aknakos/products/{name}/standards/*.yaml`
2. **Framework defaults**: `.aknakos/standards/*.yaml`

**Documents**: coding-conventions.yaml, architecture-patterns.yaml, testing-standards.yaml, security-guidelines.yaml, review-checklist.yaml

**Characteristics**: Framework defaults (SvelteKit + Svelte 5 + Better-Auth + Drizzle), product-specific overrides (custom tech, stricter security, team conventions), referenced automatically during implementation and review

**When to Load**: Planning mode (testing-standards.yaml for test specs), Implementation (coding-conventions.yaml), Review (all standards), Architecture decisions (architecture-patterns.yaml, security-guidelines.yaml)

**How to Check Precedence**:
1. Check if `.aknakos/products/{name}/standards/{standard}.yaml` exists
2. If YES: Use product-specific standard
3. If NO: Use framework default `.aknakos/standards/{standard}.yaml`

---

## Decision Framework

### Option 1: Planning Mode Built-in Tools

**Use When**: Single file or component (1 file), small scope (2-5 files), well-defined search (know what to look for), new/small codebase

**Tools Available**: @-mentions (reference specific files), Read (view file contents), Glob (find files by pattern), Grep (search file contents), Explore subagent (fast specialized codebase search, Haiku-powered)

**Benefits**: No additional token cost, immediate availability, context stays in main conversation, perfect for focused exploration

---

### Option 2: context-fetcher Agent (Selective Context Extraction)

**Use When**: Need specific sections from large Tier 2 documents, multiple Tier 2 documents to extract from, want to avoid loading full 10-25 page documents, need focused context summary

**How It Works** (Agent OS pattern): Specialized agent extracts ONLY relevant sections, conditional loading ("only if not already in context"), returns focused summary instead of full documents, prevents token bloat

**Benefits**: Token-efficient (extracts vs full load), DRY principle (single source of truth), avoids redundant context

**Trade-offs**: Additional step (spawn, wait, review), risk of missing context if extraction too narrow

---

### Option 3: context-gatherer Agent (Large-Scale Codebase Exploration)

**Use When**: Large codebase (100+ files), multi-domain context (frontend + backend + database), architecture-wide understanding needed, unfamiliar with codebase structure, need comprehensive mapping

**How It Works**: Runs in separate context (doesn't bloat main conversation), explores thoroughly (multiple domains, dependencies, patterns), returns summary report (token-efficient), can run in parallel while you work

**Benefits**: Thorough exploration without main context bloat, handles complexity well, returns structured summary, can explore multiple domains simultaneously

**Trade-offs**: Additional step (spawn, wait, review results), uses tokens in separate context, overkill for simple needs

---

## Analysis Process

### Step 1: Define What You Need

Questions: What do you need to understand? Why do you need this context? How many domains are involved? How familiar are you with this codebase?

### Step 2: Scope Assessment

**Small Scope**: Single file/component (@-mention), specific function/class (Grep or Read), known location (direct file access)

**Medium Scope**: Several related files 2-10 (planning mode Explore), one domain just frontend or backend (Grep + Glob), specific pattern search (planning mode tools)

**Large Scope**: Many files 10+ (consider Context agent), multiple domains (likely need Context agent), architecture-wide understanding (Context agent recommended), unknown territory (Context agent helps map it)

### Step 3: Recommendation

Based on analysis, recommend:

**Tier 1: @-Mentions** (< 5 known files):
```
Use @-mentions in planning mode:
@src/auth/login.ts
@src/auth/middleware.ts
```

**Tier 2: Planning Mode Tools** (5-10 files or pattern search):
```
Use planning mode:
- Glob: src/**/*auth*.ts
- Grep: "authentication middleware"
- Explore: Search for "JWT token" patterns
```

**Tier 3: context-fetcher Agent** (Selective Tier 2 extraction):
```
Spawn context-fetcher agent:
- Extract user authentication requirements from prd.md
- Extract security architecture section from architecture.md
- Return focused summary
```

**Tier 4: context-gatherer Agent** (Large codebase exploration):
```
Spawn context-gatherer agent:
- Analyze entire auth system across frontend, backend, database
- Map integration points with payment system
- Document patterns and dependencies
```

See `.aknakos/examples/context-scope/context-strategy-examples.md` for detailed examples.

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

## When in Doubt

**Default to planning mode tools first**: Faster, cheaper (token-wise), sufficient for most cases

**Escalate to Context agent if**: Planning mode exploration feels overwhelming, you're lost in complexity, need multi-domain understanding, codebase is very large

---

## Related Skills

- `whats-next`: Check what phase you're in
- `epic-breakdown`: Uses context to create realistic Epics
- Planning mode: Built-in exploration tools
- Context agents: Large-scale context gathering
