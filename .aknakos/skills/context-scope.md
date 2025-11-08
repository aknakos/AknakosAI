# Context Scope Skill

**Purpose**: Determine optimal context gathering strategy

**Phase**: Before Planning Mode or Epic Breakdown

**When to Use**: When unsure if you need Context agent or planning mode's built-in tools are sufficient

---

## What This Skill Does

This skill analyzes your context needs and recommends whether to:
1. Use planning mode's built-in tools (@-mentions, Explore subagent)
2. Spawn a Context agent for large-scale exploration

**Why This Matters**: Context agents use tokens and take time. Use them when beneficial, not by default.

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

### Option 2: Context Agent

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

**Tier 3: Context Agent** (10+ files or multi-domain)
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

| Situation | Recommendation |
|-----------|---------------|
| Modify specific file | @-mention or Read |
| Understand one feature | Planning mode Explore |
| Understand subsystem | Planning mode tools |
| Architecture overview | Context agent |
| Multi-domain integration | Context agent |
| Large unknown codebase | Context agent |
| Quick lookup | Planning mode |
| Comprehensive mapping | Context agent |

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
