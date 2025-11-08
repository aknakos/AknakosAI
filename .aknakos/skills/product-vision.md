# Product Vision Skill

**Purpose**: Guide strategic product planning through conversational exploration

**Phase**: Phase 1 - Strategic Vision

**When to Use**: Starting a new product or major feature direction

---

## What This Skill Does

This skill helps you explore and define product vision through structured yet conversational discussion. It guides you through key strategic questions to clarify what you're building and why.

---

## Process

### 1. Product Fundamentals

**Questions to Explore**:
- What problem are you solving?
- Who is the target user/customer?
- What is the core value proposition?
- Why does this product need to exist?
- What makes this different from existing solutions?

**Output**: Clear problem statement and value proposition

---

### 2. User Understanding

**Questions to Explore**:
- Who are your primary users? (Create simple personas)
- What are their current pain points?
- What jobs are they trying to do?
- What alternatives do they use today?
- What would make them switch to your solution?

**Output**: User personas and pain points

---

### 3. Product Scope

**Questions to Explore**:
- What is the Minimum Viable Product (MVP)?
- What features are must-haves vs nice-to-haves?
- What is explicitly out of scope (for now)?
- What can we build in 3 months? 6 months? 1 year?

**Output**: Scope boundaries and phasing

---

### 4. Success Metrics

**Questions to Explore**:
- How will you know if this product is successful?
- What metrics matter most? (Usage, revenue, engagement, etc.)
- What are the target numbers for each metric?
- What are the key milestones?

**Output**: Success criteria and metrics

---

### 5. Constraints & Assumptions

**Questions to Explore**:
- What are the technical constraints?
- What are the business constraints? (Budget, timeline, team size)
- What are the key assumptions we're making?
- What are the biggest risks?
- What could cause this product to fail?

**Output**: Constraints, assumptions, and risks

---

## Key Principles

1. **Conversational, Not Formal**: This is exploratory discussion, not documentation
2. **Ask "Why" 5 Times**: Dig deeper to understand the real motivation
3. **Challenge Assumptions**: Don't accept surface-level answers
4. **Stay User-Focused**: Always come back to user value
5. **Embrace Constraints**: Constraints drive creativity

---

## Parallel Research Opportunities

During product vision discussions, consider spawning research agents:

- **market-research agent**: Analyze market size, trends, opportunities
- **competitive-analysis agent**: Research competitors and their offerings

These run in parallel (separate contexts) and report back findings.

---

## Artifacts Created

**During Skill**: In-context conversation (not saved as files)

**After Skill**: Optionally create:
- Brief product vision summary
- User personas
- Problem statement

**Next Step**: Move to Architecture skill or Create PRD skill

---

## Example Usage

```
User: Let's use the product-vision skill to explore this product idea

Claude: Great! Let's explore your product vision. I'll guide you through some key questions.

First, let's start with the fundamentals:
- What problem are you solving?
[Conversational exploration begins...]
```

---

## Tips for Success

- Take time with this phase - rush here = problems later
- Involve stakeholders in the discussion
- Document decisions, not every word
- Revisit and revise as you learn
- Use parallel agents for research to save time

---

## What's Next

After product vision is clear:
- **Option 1**: Explore architecture (architecture skill)
- **Option 2**: Create formal PRD (create-prd skill)
- **Option 3**: Do more research (spawn market-research agents)

Use `whats-next` skill to get personalized guidance based on current workflow state.
