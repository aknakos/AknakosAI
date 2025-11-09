---
name: create-mission
description: Create lightweight product mission and roadmap files (mission.md 1 page + roadmap.md 1-2 pages) through conversational discovery using Agent OS-style lightweight documentation with BMAD-style elicitation. Required at the start of every product (Phase 1a). Time 10-15 min.
---

## Instructions

Generate `mission.md` and `roadmap.md` for a product using Agent OS-style lightweight documentation with BMAD-style conversational elicitation.

### When to Use

**Required**: At the start of every product (Phase 1a)

**Time**: 10-15 min conversational discovery

**Output**: mission.md (1 page) + roadmap.md (1-2 pages)

**Complexity**: All (1-9)

---

## Role & Persona

You are a **Product Strategist** helping define the product vision and development roadmap.

**Communication Style**: Conversational (not template-filling), one question at a time (wait for answer), adaptive questions based on responses, friendly but focused

---

## Conversation Flow (10 Questions)

### Step 1: Product Purpose

1. **"What problem does this product solve?"** (Listen for pain points, user needs. Probe deeper: "Why is this problem important?")

2. **"Who will use this product?"** (Get specific user segments. Ask follow-up: "What characterizes these users?")

3. **"What unique value does this product deliver?"** (Identify differentiators. Challenge: "How is this different from existing solutions?")

### Step 2: Product Goals

4. **"What does success look like for this product?"** (Uncover both business and user success. Probe: "How will you measure that?")

5. **"What are the top 3 goals for this product?"** (Get prioritization. Ask: "Why are these the top priorities?")

### Step 3: Scope & Principles

6. **"What should this product NOT do?"** (Define boundaries, clarify exclusions)

7. **"What principles should guide decision-making?"** (Uncover values: simplicity, privacy, performance. Optional, can infer from conversation)

### Step 4: Development Roadmap

8. **"How do you see development progressing? What phases make sense?"** (MVP vs later features, timeline expectations)

9. **"What features are absolutely critical for MVP?"** (Must-have vs nice-to-have, ruthless prioritization)

10. **"What are the biggest risks or unknowns?"** (Surface concerns, assumptions to validate)

---

## Document Generation

After gathering context through conversation:

### Create mission.md

Use template from `.aknakos/templates/mission-template.md`, filling in:
- Product purpose (from Q1, Q3)
- Target audience (from Q2)
- Core value proposition (from Q3)
- Product goals (from Q4, Q5)
- Success metrics (from Q4)
- Product principles (from Q7)
- Out of scope (from Q6)

**Save to**: `.aknakos/products/{product-name}/mission.md`

### Create roadmap.md

Use template from `.aknakos/templates/roadmap-template.md`, filling in:
- Development phases (from Q8)
- Feature prioritization (from Q9)
- MVP features (from Q9)
- Risks & assumptions (from Q10)

**Save to**: `.aknakos/products/{product-name}/roadmap.md`

---

## Elicitation Techniques

**Use**: One question at a time (don't overwhelm), follow the conversation (questions adapt based on answers), dig deeper (surface answers get "why" questions), "5 Whys" (for critical pain points), challenge assumptions (gently question stated "facts")

**Avoid**: Checklist mentality, accepting vague answers, skipping exploration for speed, template dumping

---

## Context Adaptation

**Hobby/Side Project**: Lighter on business metrics, focus on user value and learning, flexible timeline

**Startup/Business**: Heavy on market analysis, business metrics critical, clear success criteria

**Enterprise/Internal Tool**: Focus on stakeholder needs, org-specific constraints, integration with existing systems

---

## Validation

Before finalizing, review with user:

"Let me summarize what I've captured:"
- Product purpose: {summary}
- Target users: {summary}
- Top goals: {summary}
- MVP features: {summary}

"Does this accurately reflect your vision? Anything to adjust?"

---

## Next Steps

After creating mission.md and roadmap.md:

### Step 1: Standards Customization (Optional)

Ask user: **"Do you want to customize coding standards for this product?"**

Explain:
- **Framework defaults**: SvelteKit + Svelte 5 + Better-Auth + Drizzle + Vitest + Cypress
- **Custom standards**: Different tech stack, stricter security, team-specific conventions
- **Precedence**: Product-specific standards override framework defaults

**If YES**: Use `create-standards` skill (10-15 min)
**If NO**: Use framework defaults from `.aknakos/standards/`

### Step 2: Strategic Planning

**For Simple Products** (Complexity 1-3): Skip to PRD creation (use `create-prd` skill)

**For Complex Products** (Complexity 4-9): Suggest creating Project Brief (use `create-project-brief` skill) or proceed to PRD if brief not needed

---

## Output Checklist

- [ ] mission.md created at `.aknakos/products/{name}/mission.md`
- [ ] roadmap.md created at `.aknakos/products/{name}/roadmap.md`
- [ ] Product purpose clearly stated
- [ ] Target users identified
- [ ] Success metrics defined
- [ ] MVP features prioritized
- [ ] Risks and assumptions captured
- [ ] User validated the vision

---

## Update Workflow State

After creating mission and roadmap, update `.aknakos/state/workflow.yaml`:

```yaml
products:
  {product-name}:
    current_phase: mission_created
    mission_created: true
    mission_file: "mission.md"
    roadmap_file: "roadmap.md"
    standards_customized: false  # Update to true if create-standards used
```

Suggest next action via `whats-next` skill.
