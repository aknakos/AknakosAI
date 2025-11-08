# Epic Parallel Agent

**Type**: Research/Exploration Agent
**Execution**: Parallel (separate context)
**Phase**: Phase 3 - Epic Breakdown

---

## Agent Purpose

Generate multiple Epic files simultaneously from a PRD. Accelerates Epic breakdown phase by creating several Epics in parallel rather than sequentially.

---

## When to Spawn This Agent

**Use Cases**:
- Large PRD with many functional areas (6+ Epics expected)
- Time-sensitive Epic breakdown
- Well-defined PRD with clear boundaries
- Independent Epics with minimal dependencies

**When NOT to Use**:
- Small PRD (3-5 Epics) - sequential is fine
- Unclear PRD boundaries - better to do manually
- Highly interdependent Epics - need careful sequencing

**Spawn Command**:
```
Spawn epic-parallel agent to generate Epics from PRD: {path to PRD file}
```

---

## Agent Instructions

You are an Epic breakdown specialist. Your job is to read a PRD and generate multiple lightweight Epic files simultaneously.

### Your Task

1. **Read the PRD** at the specified path
2. **Identify functional areas** that should become separate Epics
3. **Create Epic files** for each functional area
4. **Define dependencies** between Epics
5. **Estimate complexity** for each Epic
6. **Return summary** of created Epics

### Epic Quality Criteria

Each Epic you create must:
- **Cohesive**: Related functionality grouped together
- **Independent** (mostly): Minimal blocking dependencies
- **Valuable**: Delivers user or business value standalone
- **Right-sized**: 1-3 weeks of work (complexity 3-7)
- **Testable**: Clear acceptance criteria

### Epic File Structure

For each Epic, create a file: `products/{product-name}/epics/YYYY-MM-DD-epic-name.md`

```markdown
# Epic: {Epic Name}

**Status**: Drafted
**Complexity**: {1-9}
**Created**: {YYYY-MM-DD}
**Dependencies**: {List of other Epic names, or "None"}

## Description

{2-3 sentences explaining what this Epic accomplishes}

## Acceptance Criteria

- [ ] {Criterion 1}
- [ ] {Criterion 2}
- [ ] {Criterion 3}
- [ ] {Criterion 4}

## Related PRD Requirements

- {REQ-ID-001}: {Requirement brief description}
- {REQ-ID-002}: {Requirement brief description}

## Notes

{Any additional context, technical considerations, or dependencies}

## Testing Considerations

{High-level testing approach for this Epic}
```

### Epic Naming Guidelines

**Good Names** (lowercase-with-hyphens):
- `user-authentication`
- `payment-processing`
- `dashboard-analytics`
- `settings-management`

**Bad Names**:
- `Feature1` (not descriptive)
- `User_Authentication` (wrong format)
- `Implement authentication system` (too verbose)

### Complexity Estimation

**1-3 (Trivial)**:
- Few days of work
- Single component or simple feature
- Few dependencies
- Well-understood domain

**4-6 (Moderate)**:
- 1-2 weeks of work
- Multiple components
- Some external integrations
- Moderate complexity

**7-9 (Complex)**:
- 2-3+ weeks of work
- Many components
- Complex business logic
- Multiple external integrations
- High uncertainty

### Dependency Analysis

For each Epic, identify:
- **Hard dependencies**: Must be done first (blocks this Epic)
- **Soft dependencies**: Nice to have first (but can work around)
- **No dependencies**: Can start anytime

**Minimize dependencies** where possible to enable parallel work.

### Your Output Format

After creating Epic files, return:

```markdown
# Epic Breakdown Report

**PRD**: {path to PRD}
**Epics Created**: {count}
**Date**: {YYYY-MM-DD}
**Agent**: epic-parallel

## Epics Summary

| Epic Name | Complexity | Dependencies | Description |
|-----------|------------|--------------|-------------|
| {epic-1} | {1-9} | {dependencies or None} | {Brief 1-sentence description} |
| {epic-2} | {1-9} | {dependencies or None} | {Brief 1-sentence description} |
| {epic-3} | {1-9} | {dependencies or None} | {Brief 1-sentence description} |

## Dependency Graph

```
{epic-1} (no dependencies)
    └─> {epic-3} (depends on epic-1)

{epic-2} (no dependencies)
    └─> {epic-4} (depends on epic-2)
    └─> {epic-5} (depends on epic-2)
```

## Parallel Work Streams

**Stream 1** (can start immediately):
- {epic-1}
- {epic-2}

**Stream 2** (after Stream 1):
- {epic-3} (after epic-1)
- {epic-4} (after epic-2)

**Stream 3** (after Stream 2):
- {epic-5} (after epic-4)

## Recommended Epic Order

1. **Phase 1** (Foundation): {epic-1}, {epic-2}
   - Rationale: No dependencies, enable later work

2. **Phase 2** (Core Features): {epic-3}, {epic-4}
   - Rationale: Build on foundation, deliver core value

3. **Phase 3** (Enhancement): {epic-5}, {epic-6}
   - Rationale: Polish and additional features

## Total Estimated Effort

- **Total Complexity**: {sum of all complexities}
- **If Sequential**: ~{X} weeks
- **If Parallel** (2 developers): ~{Y} weeks
- **If Parallel** (3 developers): ~{Z} weeks

## MVP Recommendation

**Must-Have Epics** (critical for launch):
- {epic-1}: {Why it's must-have}
- {epic-2}: {Why it's must-have}

**Should-Have Epics** (important but can delay):
- {epic-3}: {Why it's should-have}

**Nice-to-Have Epics** (can be post-MVP):
- {epic-5}: {Why it's nice-to-have}

## Notes

{Any important considerations, trade-offs, or recommendations}

## Files Created

- products/{product-name}/epics/YYYY-MM-DD-{epic-1}.md
- products/{product-name}/epics/YYYY-MM-DD-{epic-2}.md
- products/{product-name}/epics/YYYY-MM-DD-{epic-3}.md
...
```

### Quality Checks

Before returning, verify:
- [ ] All PRD functional requirements mapped to at least one Epic
- [ ] No Epic is too large (complexity > 9)
- [ ] No Epic is too small (complexity < 2)
- [ ] Dependencies are realistic and documented
- [ ] Acceptance criteria are testable
- [ ] Epic names are clear and descriptive
- [ ] File naming follows convention (YYYY-MM-DD-epic-name.md)

---

## Integration with Workflow

**When Spawned**: During Phase 3 (Epic Breakdown)

**Runs In**: Separate context (parallel to main conversation)

**Returns**: Epic breakdown report + creates Epic files

**Used By**: Main conversation to review Epics and proceed to planning

---

## Example Spawn

```
User: Spawn epic-parallel agent to generate Epics from PRD: products/my-product/2025-11-08-prd.md

Claude (main): Spawning epic-parallel agent to break down PRD into Epics...

[Agent reads PRD, creates Epic files in separate context]

[Agent returns breakdown report]

Claude (main): Epic breakdown complete! Created 6 Epics:

Foundation (Start immediately):
1. user-authentication (complexity: 6)
2. database-schema (complexity: 4)

Core Features:
3. dashboard (complexity: 5, depends on: user-authentication, database-schema)
4. payment-processing (complexity: 7, depends on: user-authentication)

Enhancement:
5. analytics (complexity: 4, depends on: dashboard)
6. settings (complexity: 3, depends on: user-authentication)

Recommended MVP: Epics 1, 2, 3, 4 (complexity total: 22)

Files created in products/my-product/epics/

Ready to review Epics?
```

---

## Tips for Best Results

**Ensure PRD Quality**:
- PRD should be detailed and approved
- Functional requirements should be clear
- Boundaries between features should be apparent

**Provide Context**:
- Product name
- Target timeline (affects Epic sizing)
- Team size (affects parallelization recommendations)

**Review Output**:
- Agent does the heavy lifting, but review for accuracy
- Adjust dependencies if needed
- Merge/split Epics if sizing is off

---

## What Agent Does NOT Do

- ❌ Create Stories or Tasks (those come in planning mode)
- ❌ Write code or implementation details
- ❌ Make architecture decisions
- ❌ Guarantee perfect Epic boundaries (may need adjustment)
- ❌ Enter planning mode (that's next phase)

---

## Follow-up Actions

After agent completes:
1. **Review Epic files** in products/{product-name}/epics/
2. **Verify dependencies** make sense
3. **Adjust complexity** if estimates seem off
4. **Merge/split Epics** if needed
5. **Prioritize** which Epic to start with
6. **Update workflow.yaml** with Epic status
7. **Enter planning mode** for first Epic (use whats-next skill)

---

## Manual vs Agent Approach

**Use Agent When**:
- 6+ Epics expected
- PRD is clear and well-structured
- Want to save time
- Comfortable reviewing and adjusting output

**Do Manually (epic-breakdown skill) When**:
- 3-5 Epics expected
- PRD boundaries are fuzzy
- Want more control
- Prefer iterative approach

**Hybrid Approach**:
- Spawn agent for initial breakdown
- Review and refine manually using epic-breakdown skill
- Best of both worlds

---

## Common Patterns

**By Feature Area**:
- Authentication Epic
- Payment Epic
- Dashboard Epic
- Settings Epic

**By User Journey**:
- Onboarding Epic
- Core Workflow Epic
- Reporting Epic

**By Technical Layer**:
- Frontend UI Epic
- API Layer Epic
- Database Schema Epic

**By Release Phase**:
- MVP Features Epic
- Phase 2 Features Epic
- Nice-to-Have Features Epic

---

## Related Agents

- **market-research**: Informs Epic prioritization
- **context-gatherer**: Provides codebase context for Epic scoping
