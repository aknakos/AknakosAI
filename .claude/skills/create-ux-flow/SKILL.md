---
name: create-ux-flow
description: Create user experience flow specification through conversational UX design exploration. Generate UX flow document (3-8 pages) defining user journeys, interface structure, interaction patterns, design principles. Use for user-facing products (Complexity 4-9) with significant UI/UX needs.
---

## Instructions

Generate UX flow document through conversational user-centered design exploration.

### When to Use

**Use**: User-facing products (Complexity 4-9), significant UI/UX complexity

**Prerequisites**: mission.md + tech-stack.md exist; architecture.md helpful

**Time**: 15-25 min UX conversation

**Output**: ux-flow.md (3-8 pages)

**Phase**: 1d (after architecture, before PRD)

### Role

**Pragmatic UX designer** focused on user-centered design:
- User needs drive interface decisions
- Simple, intuitive, accessible design
- Design system consistency
- Mobile-first when appropriate
- Connect UX to product goals

### Context to Load

```
.aknakos/products/{name}/mission.md
.aknakos/products/{name}/tech-stack.md
.aknakos/products/{name}/YYYY-MM-DD-architecture.md (if exists)
.aknakos/products/{name}/YYYY-MM-DD-project-brief.md (if exists)
```

### Conversation Flow (7 Phases)

**Phase 1: User Context** (3-5 min)
1. "Who are your primary users?" (personas, technical proficiency, devices, context of use)
2. "What are the 2-3 most critical user goals?" (what users need, frequency, time constraints, success metrics)
3. "What's the expected user journey?" (entry point, first-time vs returning, workflow, completion)

**Phase 2: Core User Flows** (8-10 min)
4. "Walk me through the primary user flow step-by-step." (For each flow: entry point, steps, decision points, success state, error scenarios)
5. "Are there secondary flows users might take?" (alternative paths, edge cases, admin flows, error recovery)
6. "What feedback should users get at each step?" (loading indicators, success/error messages, progress, empty states)

**Phase 3: Interface Structure** (5-7 min)
7. "How should information be organized?" (page hierarchy, navigation structure, content grouping, mobile approach)
8. "What's on the home/landing page?" (hero section, key actions/CTAs, navigation, content preview)
9. "What are the key screens/pages?" (For each: purpose, key content, primary actions, navigation to/from)
10. "How should users navigate between sections?" (primary navigation visibility, secondary navigation, mobile considerations, deep linking)

**Phase 4: Interaction Patterns** (4-6 min)
11. "How should forms work?" (validation: real-time/on-submit, error display: inline/summary, multi-step vs single page, auto-save)
12. "How should data be displayed?" (lists: table/cards/grid, filtering, sorting, pagination vs infinite scroll, default view, empty states)
13. "What feedback patterns do you want?" (toast notifications, modal confirmations, inline messages, loading skeletons vs spinners, undo capability)
14. "Any complex interactions?" (drag & drop, inline editing, keyboard shortcuts, bulk actions)

**Phase 5: Design System & Components** (3-4 min)
15. "Are you using an existing design system?" (Material Design, Ant Design, custom; component library choice; alignment with tech stack)
16. "What's your design philosophy?" (minimal vs feature-rich, playful vs professional, colorful vs neutral, dense vs spacious)
17. "What core components do you need?" (buttons, forms, feedback, navigation, data display)

**Phase 6: Accessibility & Responsive Design** (2-3 min)
18. "What accessibility level are you targeting?" (WCAG A/AA/AAA, keyboard navigation, screen reader support, color contrast)
19. "What devices need support?" (desktop only, mobile-first, both; breakpoints; touch vs mouse; responsive patterns)
20. "Any specific accessibility considerations?" (high contrast mode, reduced motion, large text support, focus indicators)

**Phase 7: UX Principles** (2-3 min)
21. "What are your top 3 UX principles for this product?" (Examples: Simplicity, Speed, Clarity, Delight, Accessibility, Consistency)
22. "How does this UX support your mission?" (Connect UX decisions to mission.md goals)

### Document Generation

Use template: `.aknakos/templates/ux-flow-template.md`

**Fill sections**:
- Overview: Purpose, scope, target users (Q1, Q2)
- User Flows: Primary and secondary flows with steps, edge cases (Q4, Q5)
- Interface Structure: Page hierarchy, navigation patterns (Q7-Q10)
- Interaction Patterns: Forms, data display, feedback, complex interactions (Q11-Q14)
- UX Principles: Core principles, design philosophy (Q21, Q22)
- Component Library: Core components, reusable patterns (Q15-Q17)
- Accessibility Considerations: WCAG compliance, inclusive design (Q18-Q20)
- Design System References: Framework, color, typography, spacing (Q15, Q16)
- Traceability: Links to mission, architecture, PRD
- Wireframes: ASCII or descriptions for key screens

**Save to**: `.aknakos/products/{product-name}/YYYY-MM-DD-ux-flow.md`

### Wireframe Creation

**For key screens, create ASCII wireframes**:

```
+------------------------------------------+
| Logo   [Nav Item 1] [Nav Item 2] [User] |
+------------------------------------------+
| Sidebar      | Main Content             |
|              |                          |
| - Item 1     | [Page Title]             |
| - Item 2     |                          |
| - Item 3     | [Content here]           |
|              |                          |
|              | [CTA Button]             |
+------------------------------------------+
```

**Cover**: Home/landing page, primary user flow screens, key interaction screens (forms, data views), mobile layouts (if different)

### Alignment with Architecture

Connect UX to tech stack:
- Component library matches frontend framework (from tech-stack.md)
- Interaction patterns align with framework capabilities
- Performance expectations match architecture
- API patterns support UX needs

**Example**: "Since you're using SvelteKit, we can leverage its server-side rendering for faster initial loads, supporting your 'Speed' UX principle."

### Validation with User

Before finalizing, review key UX decisions:

"Let me confirm the core UX approach:"
- Primary user flow: {describe}
- Navigation pattern: {top nav, sidebar, etc.}
- Key interactions: {forms, data display}
- Design system: {Material, custom, etc.}
- Accessibility target: {WCAG AA}
- Top UX principles: {list 3}

"Does this UX approach support your users and product goals?"

### Output Checklist

- [ ] ux-flow.md created at `.aknakos/products/{name}/YYYY-MM-DD-ux-flow.md`
- [ ] Primary user flows documented with steps and edge cases
- [ ] Interface structure defined (pages, navigation)
- [ ] Interaction patterns specified (forms, data, feedback)
- [ ] UX principles clearly stated
- [ ] Component library identified
- [ ] Accessibility considerations included
- [ ] Wireframes created for key screens
- [ ] Alignment with mission and architecture verified
- [ ] User validated the UX approach

### Update Workflow State

Update `.aknakos/state/workflow.yaml`:
```yaml
products:
  {product-name}:
    current_phase: ux_flow_created
    ux_flow_created: true
    ux_flow_file: "YYYY-MM-DD-ux-flow.md"
```

### Next Steps

After creating UX flow:
- Create PRD (use `create-prd` skill) - PRD should reference ux-flow.md
- OR if PRD already exists, ensure alignment with UX flow

### Key Principles

**Keep it user-centric**:
- Always ask "why does the user need this?"
- Prioritize simplicity over feature completeness
- Consider first-time user experience
- Design for common cases, handle edge cases

**Validate assumptions**:
- "How often will users do this?"
- "What's the user's mental model?"
- "What similar products have they used?"

**Connect to product goals**:
- Reference mission.md to ensure UX supports goals
- Align with architecture.md for technical feasibility
- Consider tech-stack.md capabilities/constraints

**Design for accessibility**:
- Include keyboard navigation from start
- Consider screen readers in interaction design
- Plan for color contrast and focus indicators
- Support reduced motion preferences

**Related Files**: ux-flow-template.md (structure), mission.md (vision), tech-stack.md (frontend framework), architecture.md (constraints), project-brief.md (user context)
