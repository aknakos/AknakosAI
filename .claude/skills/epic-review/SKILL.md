---
name: epic-review
description: Synthesize review reports and extract learnings after Epic completion Use when: **Trigger**: After Epic reviews complete and all concerns addressed
---


**Purpose**: Synthesize review reports and extract learnings after Epic completion

**Phase**: Phase 7 - Epic Completion Review

**When to Use**: After all Stories in an Epic are implemented and reviewed

---

## What This Skill Does

This skill helps you:
1. Synthesize findings from 5 parallel review reports
2. Extract learnings and patterns
3. Create retrospective for future Epics
4. Document what worked and what didn't

---

## When to Use

**Trigger**: After Epic reviews complete and all concerns addressed

**Inputs**:
- Test review report
- Security review report
- Architecture review report
- Quality review report
- Requirements review report

**Output**: Epic-level review document with learnings

---

## Review Synthesis Process

### 1. Collect Review Reports

**Location**: `.aknakos/products/{product-name}/reviews/{epic-name}/`

**Files**:
- `YYYY-MM-DD-test-review.md`
- `YYYY-MM-DD-security-review.md`
- `YYYY-MM-DD-architecture-review.md`
- `YYYY-MM-DD-quality-review.md`
- `YYYY-MM-DD-requirements-review.md`

**Action**: Read all 5 reports

---

### 2. Identify Patterns

**Look For**:

**Positive Patterns**:
- What went well?
- What approaches were successful?
- What patterns should be repeated?
- What made reviews pass easily?

**Negative Patterns**:
- What caused concerns or failures?
- What issues were repeated across reviews?
- What was harder than expected?
- What would we do differently?

**Cross-Review Patterns**:
- Did multiple reviewers mention the same issue?
- Are there systemic issues vs one-off problems?
- Do patterns suggest architectural changes needed?

---

### 3. Extract Learnings

**Categories**:

**Technical Learnings**:
- Architectural insights
- Better patterns discovered
- Tech debt created or resolved
- Performance considerations

**Process Learnings**:
- TDD effectiveness
- Planning accuracy
- Estimation accuracy
- Review process effectiveness

**Quality Learnings**:
- Test coverage insights
- Security practices
- Code quality patterns
- Documentation effectiveness

---

### 4. Create Recommendations

**For Future Epics**:
- What to do more of
- What to avoid
- What to change in process
- What to add to PRD or standards

**For Current Product**:
- Tech debt to address
- Refactoring opportunities
- Cross-Epic improvements
- Documentation needs

---

## Epic Review Document Structure

```markdown
# Epic Review: {Epic Name}

**Epic**: {epic-name}
**Completed**: {YYYY-MM-DD}
**Complexity**: {1-9}
**Duration**: {actual time taken}

## Summary

{2-3 sentence summary of what was accomplished}

## Review Outcomes

- Test Review: {PASS/CONCERNS/FAIL → final outcome}
- Security Review: {PASS/CONCERNS/FAIL → final outcome}
- Architecture Review: {PASS/CONCERNS/FAIL → final outcome}
- Quality Review: {PASS/CONCERNS/FAIL → final outcome}
- Requirements Review: {PASS/CONCERNS/FAIL → final outcome}

## What Went Well

### Technical
- {Positive technical pattern 1}
- {Positive technical pattern 2}

### Process
- {Positive process pattern 1}
- {Positive process pattern 2}

### Quality
- {Positive quality pattern 1}
- {Positive quality pattern 2}

## What Could Improve

### Technical
- {Area for improvement 1}
- {Area for improvement 2}

### Process
- {Process improvement 1}
- {Process improvement 2}

### Quality
- {Quality improvement 1}
- {Quality improvement 2}

## Key Learnings

1. {Major learning 1}
2. {Major learning 2}
3. {Major learning 3}

## Patterns Identified

### Successful Patterns to Repeat
- {Pattern 1}: {Why it worked}
- {Pattern 2}: {Why it worked}

### Anti-Patterns to Avoid
- {Anti-pattern 1}: {Why it caused issues}
- {Anti-pattern 2}: {Why it caused issues}

## Recommendations

### For Next Epics
- {Recommendation 1}
- {Recommendation 2}

### For Product Architecture
- {Architectural recommendation 1}
- {Architectural recommendation 2}

### For Process
- {Process recommendation 1}
- {Process recommendation 2}

## Metrics

- **Planned Complexity**: {1-9}
- **Actual Complexity**: {1-9 based on experience}
- **Estimation Accuracy**: {Over/under/accurate}
- **Test Coverage**: {percentage}
- **Review Iterations**: {number of re-reviews needed}
- **Concerns Raised**: {total across all reviewers}
- **Time to Resolution**: {how long to address all concerns}

## Tech Debt Created

- {Tech debt item 1}: {Why created, when to address}
- {Tech debt item 2}: {Why created, when to address}

## Follow-up Actions

- [ ] {Action item 1}
- [ ] {Action item 2}
- [ ] {Action item 3}

## Notes

{Any additional context, observations, or insights}
```

---

## Example Epic Review

```markdown
# Epic Review: User Authentication

**Epic**: user-authentication
**Completed**: 2025-11-10
**Complexity**: 6 (planned), 7 (actual)
**Duration**: 10 days (planned: 8 days)

## Summary

Implemented secure user authentication system with email/password registration, login, logout, and password reset functionality. All features working with comprehensive test coverage.

## Review Outcomes

- Test Review: PASS (after addressing test coverage gap)
- Security Review: PASS (after fixing password reset token expiration)
- Architecture Review: PASS (after improving token storage pattern)
- Quality Review: PASS
- Requirements Review: PASS

## What Went Well

### Technical
- JWT token implementation clean and secure
- Password hashing with bcrypt well-implemented
- Database schema design solid

### Process
- TDD approach prevented many bugs
- Planning mode test specifications were accurate
- Parallel review agents caught issues early

### Quality
- Test coverage 92% (exceeded 80% target)
- All edge cases covered in tests
- Code maintainability high

## What Could Improve

### Technical
- Token storage pattern needed revision (caught in review)
- Email service integration more complex than expected

### Process
- Underestimated complexity (6 → 7)
- Didn't account for email integration time
- Test review caught gap in error handling tests

### Quality
- Initial password reset token expiration too long (security issue)
- Some test scenarios missing from initial plan

## Key Learnings

1. **Email integration adds complexity**: Factor this into Epic estimation
2. **Security review critical**: Caught password reset token issue we missed
3. **Test specifications in plan prevented scope creep**: Clear test specs kept focus tight
4. **Architecture review valuable**: Token storage improvement will benefit future features

## Patterns Identified

### Successful Patterns to Repeat
- **Comprehensive test specifications in planning**: Having detailed test specs in the plan made TDD cycle smooth
- **Early security consideration**: Thinking about security from planning prevented major rewrites
- **Modular authentication middleware**: Clean separation makes testing easy

### Anti-Patterns to Avoid
- **Underestimating third-party integration**: Email service took 2 days vs planned 0.5 days
- **Security assumptions**: Don't assume default timeouts are secure
- **Missing error scenarios in tests**: Initially missed testing error paths

## Recommendations

### For Next Epics
- **Add 2x buffer for third-party integrations** (email, payments, etc.)
- **Include error scenarios in test specifications** from the start
- **Have security reviewer look at plan** before implementation for high-risk features

### For Product Architecture
- **Create reusable email service abstraction** for use in other Epics
- **Document token storage pattern** for consistency across features
- **Consider adding rate limiting** to auth endpoints (future enhancement)

### For Process
- **Add "integration complexity" to Epic estimation** (internal vs third-party)
- **Include security review of test specifications** for auth-related features
- **Update PRD** to include rate limiting requirement

## Metrics

- **Planned Complexity**: 6
- **Actual Complexity**: 7 (+1)
- **Estimation Accuracy**: Underestimated (external dependency not fully considered)
- **Test Coverage**: 92%
- **Review Iterations**: 2 (initial review → addressed concerns → final pass)
- **Concerns Raised**: 3 (architecture, security, test coverage)
- **Time to Resolution**: 1 day (fast turnaround on concerns)

## Tech Debt Created

- **Email service coupling**: Currently tightly coupled to specific provider
  - **Why**: Needed to ship fast
  - **When to address**: Before adding second email use case
  - **Effort**: 1 day

- **Token refresh not implemented**: Only access tokens, no refresh mechanism
  - **Why**: Not in MVP scope
  - **When to address**: Phase 2 (after MVP launch)
  - **Effort**: 2-3 days

## Follow-up Actions

- [x] Document token storage pattern in architecture docs
- [x] Update PRD to include rate limiting for Phase 2
- [ ] Create reusable email service abstraction (before next Epic using email)
- [ ] Add security review checkpoint for auth-related planning
- [ ] Update Epic estimation guide to include integration complexity factor

## Notes

Overall successful Epic. TDD approach worked very well - caught many edge cases early. Parallel review agents incredibly valuable, especially security and architecture reviewers. The 2-day underestimation was entirely due to email integration complexity - good learning for future.

Would recommend using same approach (planning mode with test specs → TDD cycle → parallel reviews) for remaining Epics.
```

---

## Analysis Questions

When reviewing, ask:

**Estimation**:
- Was complexity estimate accurate?
- What caused underestimation/overestimation?
- What factors weren't considered?

**Quality**:
- Did TDD approach work well?
- Were test specifications accurate?
- Did reviews catch real issues?

**Process**:
- Was planning mode effective?
- Did parallel reviews save time?
- Were concerns addressed efficiently?

**Technical**:
- Were architecture decisions good?
- Is code maintainable?
- Is there tech debt?

**Learning**:
- What surprised us?
- What would we change?
- What should we keep?

---

## Output Artifacts

**File Location**: `.aknakos/products/{product-name}/reviews/epic-reviews/YYYY-MM-DD-{epic-name}-review.md`

**Example**: `products/my-product/reviews/epic-reviews/2025-11-10-user-authentication-review.md`

---

## Integration with Workflow

**After Epic Completion**:
1. All review concerns addressed
2. Epic marked complete in workflow.yaml
3. Use epic-review skill to synthesize
4. Document learnings
5. Update process/standards based on learnings
6. Proceed to next Epic with improvements

---

## Update Workflow State

After epic review:

```yaml
# .aknakos/state/workflow.yaml
products:
  my-product:
    epics:
      - name: "user-authentication"
        status: "complete"
        completion_date: "2025-11-10"
        epic_review:
          file: "reviews/epic-reviews/2025-11-10-user-authentication-review.md"
          key_learnings:
            - "Email integration adds 2x complexity"
            - "Security review critical for auth features"
            - "Test specifications prevent scope creep"
```

---

## Benefits of Epic Reviews

**Short-term**:
- Capture learnings while fresh
- Identify immediate follow-up actions
- Celebrate successes
- Address concerns

**Long-term**:
- Improve estimation accuracy
- Refine processes
- Build knowledge base
- Inform future architecture decisions

---

## Example Usage

```
User: Let's use the epic-review skill to review the user-authentication Epic

Claude: Great! I'll help synthesize the review reports and extract learnings.

Let me read the review reports from products/my-product/reviews/user-authentication/

[Reads all 5 review reports]

I can see:
- All reviews passed (after addressing concerns)
- 3 concerns raised initially (architecture, security, test coverage)
- All resolved within 1 day

Let me create a comprehensive Epic review...

[Creates epic review document]

Key learnings:
1. Email integration complexity underestimated
2. Security review caught critical password reset issue
3. Test specifications in planning mode were very effective

Should I create the epic review file at products/my-product/reviews/epic-reviews/2025-11-10-user-authentication-review.md?
```

---

## Tips for Effective Reviews

- **Do it soon**: Review while Epic is fresh in mind
- **Be honest**: Document what didn't work, not just successes
- **Be specific**: "Tests were good" → "Test coverage 92%, edge cases well covered"
- **Extract patterns**: One issue = note it; repeated issues = pattern
- **Make it actionable**: Every learning should inform future behavior
- **Keep it concise**: 1-2 pages maximum

---

## Common Pitfalls

**Avoid**:
- Skipping epic reviews ("too busy")
- Only documenting successes (miss learning opportunities)
- Vague learnings ("do better next time")
- Not following up on recommendations
- Treating it as blame exercise

**Instead**:
- Make time for reviews (15-30 minutes)
- Document failures and successes equally
- Specific, actionable learnings
- Track follow-up actions
- Treat as learning exercise

---

## What's Next

After Epic review complete:
- Apply learnings to next Epic
- Update estimation approach if needed
- Improve process based on insights
- Address follow-up actions
- Start next Epic (use whats-next skill)

---

## Related Skills

- **whats-next**: Determines which Epic to do next
- **epic-breakdown**: Informed by previous Epic reviews
- Review agents: Provide the reports being synthesized
