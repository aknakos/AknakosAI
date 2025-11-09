# Conflict Report

**Date**: 2025-11-10
**Type**: Requirements
**Phase**: Planning
**Severity**: Critical

---

## Conflict Description

PRD contains contradictory performance and feature requirements that cannot both be satisfied.

**REQ-PERF-001** specifies system SHALL respond within 100ms (95th percentile)
**REQ-FEAT-010** requires sentiment analysis on user posts (on every request)

Sentiment analysis using current ML models takes 300-500ms, making the 100ms requirement impossible to meet.

---

## Affected Documents

**Upper-level doc that needs change**:
- [ ] mission.md
- [ ] project-brief.md
- [ ] architecture.md
- [ ] tech-stack.md
- [x] prd.md

**Lower-level work affected**:
- Epic: user-content-moderation
- Story: Implement sentiment analysis on posts

---

## Current State

**What's documented** (in PRD):

```markdown
### Performance Requirements

**REQ-PERF-001**: The system SHALL respond to user requests within 100ms for 95th percentile.

### Content Features

**REQ-FEAT-010**: The system SHALL perform sentiment analysis on user posts to detect potentially harmful content.

**Scenarios**:
- Given a user submits a post
- When the post is processed
- Then sentiment analysis SHALL be performed
- And post SHALL be flagged if negative sentiment detected
```

**What's needed** (for implementation):

Either:
- A) Relax performance requirement to 500ms (breaks user experience goals)
- B) Make sentiment analysis asynchronous (doesn't block post submission)
- C) Use simpler/faster model (sacrifices accuracy)

---

## Why This is a Conflict

**Technical Analysis**:
- Current sentiment analysis model (BERT-based) requires 300-500ms inference time
- Even with GPU acceleration, cannot consistently achieve <100ms
- Synchronous execution blocks post submission
- 100ms requirement is based on "instant feedback" UX principle from mission.md

**Business Impact**:
- Can't ship both requirements as written
- Must choose between performance OR accuracy
- Affects core product experience

---

## Impact

**If not resolved**:
- **Product**: Cannot implement content moderation (safety risk)
- **Timeline**: Planning blocked, cannot estimate Epic work
- **Technical Quality**: Either poor UX (slow) OR poor safety (inaccurate/no moderation)

---

## Proposed Resolution

### Option 1: Asynchronous Processing (Recommended)
- **Change required**: Update REQ-FEAT-010 to specify async processing
- **Pros**:
  - Maintains 100ms response time (user experience preserved)
  - Maintains model accuracy (safety preserved)
  - Scalable (background job queue)
- **Cons**:
  - Post published before moderation complete (small time window of risk)
  - Need to implement background job infrastructure
  - Need post takedown mechanism if flagged after publishing
- **Impact**: Moderate - requires background job system (6-8 hours additional work)

### Option 2: Relax Performance Requirement
- **Change required**: Update REQ-PERF-001 to 500ms
- **Pros**:
  - Simpler implementation (synchronous)
  - Immediate moderation result before publishing
- **Cons**:
  - Violates "instant feedback" UX principle
  - 500ms feels sluggish to users
  - Mission.md emphasizes "fast, responsive UI"
- **Impact**: High - affects user experience across entire product

### Option 3: Simpler ML Model
- **Change required**: Update REQ-FEAT-010 to accept lower accuracy
- **Pros**:
  - Can achieve 100ms with simpler model
  - Synchronous processing (simpler)
- **Cons**:
  - Lower accuracy means more harmful content published
  - Safety risk (mission principle: "user safety first")
- **Impact**: High - compromises safety (unacceptable)

### Recommended: Option 1 (Asynchronous Processing)

**Rationale**:
- Preserves both UX performance AND safety accuracy
- Aligns with mission.md principles (fast + safe)
- Small time window risk (1-5 seconds) is acceptable with takedown mechanism
- Industry standard pattern (Twitter, Facebook use async moderation)

---

## Resolution Plan

1. **Update PRD REQ-FEAT-010**:
   ```markdown
   **REQ-FEAT-010**: The system SHALL perform sentiment analysis on user posts asynchronously within 5 seconds of posting.

   **Updated** (2025-11-10): Made asynchronous to preserve 100ms response time (REQ-PERF-001) while maintaining analysis accuracy.

   **Scenarios**:
   - Given a user submits a post
   - When the post is accepted
   - Then the system SHALL respond within 100ms
   - And the system SHALL queue sentiment analysis job
   - And the analysis SHALL complete within 5 seconds
   - And the post SHALL be flagged/removed if negative sentiment detected
   ```

2. **Add new requirement for takedown mechanism**:
   ```markdown
   **REQ-FEAT-011**: The system SHALL automatically remove posts flagged by sentiment analysis.

   **Scenarios**:
   - Given a post has been published
   - When sentiment analysis completes with negative result
   - Then the system SHALL remove the post
   - And SHALL notify the user of removal reason
   ```

3. **Update Epic "user-content-moderation" acceptance criteria**:
   - Add: Implement background job queue for sentiment analysis
   - Add: Implement post takedown mechanism
   - Update: Sentiment analysis async, not blocking post submission

4. **Re-run validate-alignment** to ensure updated PRD aligns with Epics

**Estimated time**: 30 minutes to update docs, 2 hours to re-validate and adjust Epic

---

## Approval

**Requires approval from**: Product Owner / User
**Approved**: Yes
**Approved by**: User (2025-11-10)
**Decision**: Option 1 (Asynchronous Processing)
**Date**: 2025-11-10
