# Advanced Elicitation Techniques

BMAD-inspired techniques for conversational discovery and requirements elicitation.

**Version**: 1.0
**Last Updated**: 2025-11-08
**Source**: BMAD Method advanced elicitation practices

---

## Purpose

Provide advanced questioning and discovery techniques for strategic planning skills (create-mission, create-project-brief, create-architecture-doc).

---

## Core Principles

1. **Conversational, not template-filling**: Adaptive questions based on responses
2. **One question at a time**: Don't overwhelm
3. **Dig deeper**: Surface answers get "why" questions
4. **Challenge assumptions**: Gently question stated "facts"
5. **Seek verifiable evidence**: "How do you know?" "What data supports this?"

---

## Technique 1: 5 Whys

**Purpose**: Uncover root causes

**Process**:
1. Ask "Why?" to the initial problem
2. For each answer, ask "Why?" again
3. Repeat 5 times (or until root cause found)
4. Identify the deepest "why" as root cause

**Example**:

```
Problem: "Users abandon our app after first use"

Why? → "It's too complicated"
Why? → "Too many steps to complete first task"
Why? → "We ask for too much information upfront"
Why? → "Product team wanted to personalize experience"
Why? → "We assumed users want personalization before core value"

Root Cause: Prioritizing personalization over immediate value delivery
```

**When to Use**:
- create-project-brief: Understanding pain points (Q2)
- create-architecture-doc: Understanding technical constraints
- Any time surface answer seems incomplete

---

## Technique 2: 6 Thinking Hats

**Purpose**: Multi-perspective analysis

**Process**: Examine problem from 6 different perspectives

**Hats**:

1. **White Hat** (Facts):
   - "What data do we have?"
   - "What are the facts?"
   - "What information is missing?"

2. **Red Hat** (Emotions):
   - "How do users *feel* about current solutions?"
   - "What's your gut reaction to this approach?"
   - "What emotions drive user behavior here?"

3. **Black Hat** (Critical):
   - "What could go wrong?"
   - "What are the weaknesses?"
   - "Why might this fail?"

4. **Yellow Hat** (Positive):
   - "What are the benefits?"
   - "What opportunities exist?"
   - "What's the best-case scenario?"

5. **Green Hat** (Creative):
   - "What unconventional approaches exist?"
   - "How might we solve this differently?"
   - "What if constraints were removed?"

6. **Blue Hat** (Process):
   - "What's our next step?"
   - "What have we learned?"
   - "What decision needs to be made?"

**Example (Competitive Analysis)**:

```
User: "Our competitors focus on features, we should too"

White Hat: "What data shows users want more features vs simpler experience?"
Red Hat: "How do users feel when overwhelmed by features?"
Black Hat: "What if feature bloat makes us unusable like competitors?"
Yellow Hat: "What if simplicity becomes our differentiator?"
Green Hat: "What if we let users choose: simple mode vs power user mode?"
Blue Hat: "Should we validate with user research before deciding?"
```

**When to Use**:
- create-project-brief: Competitive analysis (Q5-Q7)
- create-architecture-doc: Tech stack decisions
- Exploring alternatives

---

## Technique 3: Role-Playing

**Purpose**: Understand user perspective

**Process**:
1. Ask user to imagine being the end user
2. Walk through specific scenarios
3. Capture frustrations, needs, desires

**Prompts**:
- "Imagine you're [persona name]. Walk me through a typical day."
- "You're trying to [complete task]. What happens?"
- "At what point do you get frustrated? Why?"

**Example**:

```
"Imagine you're Sarah, the busy professional. It's Monday morning.
You have 10 meetings today and want to track a health goal.
Walk me through using the current solutions. What happens?"

User response reveals: "I open 3 different apps, takes 5 minutes, I give up"
→ Pain point discovered: Time friction, not feature gaps
```

**When to Use**:
- create-project-brief: User personas (Q8-Q10)
- create-mission: Understanding user needs
- Validating solutions

---

## Technique 4: Self-Critique

**Purpose**: Challenge user's own assumptions

**Prompts**:
- "Let's play devil's advocate. Critique your own idea."
- "If this fails in 6 months, what would be the cause?"
- "What assumptions are we making that might be wrong?"
- "What concerns would you raise if someone else proposed this?"

**Example**:

```
User: "We need AI-powered recommendations"

"If someone else proposed AI recommendations, what concerns would you raise?"

User: "Well... it's complex, might not be accurate initially, users might not trust it"

→ Reveals: User recognizes complexity/risk, might be simpler alternative
```

**When to Use**:
- create-project-brief: Risk analysis (Q15-Q16)
- create-architecture-doc: Tech decisions
- Validating "must-have" features

---

## Technique 5: Hindsight Retrospective

**Purpose**: Future-backward thinking

**Process**:
1. Imagine product launched and succeeded (or failed)
2. Work backwards: "What led to this outcome?"
3. Identify critical decisions or risks

**Prompts**:
- **Success**: "It's 6 months from now, your product is a huge success. What happened?"
- **Failure**: "It's 6 months from now, the product failed. Why?"

**Example**:

```
"Imagine it's 6 months from launch and the product failed. Users abandoned it.
Looking back, what went wrong?"

User: "We overengineered it. Took too long to launch. Market moved on."

→ Reveals: Speed to market more important than perfection
```

**When to Use**:
- create-project-brief: Success criteria (Q14)
- create-architecture-doc: Architecture decisions
- Risk identification

---

## Technique 6: Assumption Challenging

**Purpose**: Uncover hidden assumptions

**Process**:
1. Listen for assumptions in statements
2. Gently challenge: "How do we know?" "What if that's not true?"
3. Seek evidence

**Example**:

```
User: "Users want more features"

"How do we know users want more features? What data supports this?"

User: "Well, competitors have more features"

"Do we have evidence users are choosing competitors because of features,
not despite features?"

→ Challenges assumption, seeks evidence
```

**When to Use**:
- Anytime user states assumption as fact
- During competitive analysis
- Validating priorities

---

## Technique 7: Evidence-Based Discovery

**Purpose**: Ground decisions in data

**Prompts**:
- "What evidence supports this?"
- "How did you validate this assumption?"
- "What user research informed this?"
- "Can you quantify that?"

**Example**:

```
User: "Our target market is huge"

"Can you quantify that? What's the TAM, SAM, SOM?"

User: "I estimate 10 million potential users"

"How did you arrive at that estimate? What data?"

→ Either validates or reveals need for research
```

**When to Use**:
- create-project-brief: Market analysis (Q4)
- Competitive analysis
- Success metrics definition

---

## Technique 8: Forced Prioritization

**Purpose**: Identify true priorities

**Prompts**:
- "If you could only build ONE feature, which would it be? Why?"
- "If you had to cut 50% of features, which would you keep?"
- "What's the absolute minimum to validate your hypothesis?"

**Example**:

```
User: "We need authentication, payments, notifications, analytics, admin panel"

"If you could only launch with ONE of these, which would you choose?"

User: "Authentication, obviously"

"If you had to launch with two?"

User: "Authentication and payments"

→ Reveals: Auth + payments = MVP, rest can wait
```

**When to Use**:
- create-prd: MoSCoW prioritization
- create-mission: Core feature identification
- Scope definition

---

## Technique 9: Contextual Inquiry

**Purpose**: Understand real-world usage

**Prompts**:
- "Describe a specific time when [problem] happened"
- "Walk me through the last time you [did task]"
- "What was the context? Where were you? What were you doing?"

**Example**:

```
User: "Users need better notifications"

"Describe the last time you missed an important notification. What happened?"

User: "I was in a meeting, phone on silent, missed a delivery notification,
package was left in rain"

→ Reveals: Context matters (in meeting), notification needs to adapt
```

**When to Use**:
- create-project-brief: User personas
- Understanding pain points
- Feature validation

---

## Technique 10: Alternatives Exploration

**Purpose**: Ensure best solution chosen

**Process**:
1. For every major decision, identify 2-3 alternatives
2. Explore pros/cons of each
3. Discuss trade-offs
4. User makes informed choice

**Example**:

```
Decision: Database choice

Alternative A: PostgreSQL
- Pros: ACID, relational, mature
- Cons: Harder to scale horizontally

Alternative B: MongoDB
- Pros: Flexible schema, horizontal scaling
- Cons: No transactions (older versions), different query patterns

Alternative C: MySQL
- Pros: Widely supported, good tooling
- Cons: Fewer features than Postgres

"Which aligns best with your scale needs and data model?"
```

**When to Use**:
- create-architecture-doc: All tech decisions (MANDATORY)
- create-project-brief: Strategic approach alternatives
- create-prd: Alternative approaches section

---

## Combining Techniques

**Example Flow** (create-project-brief):

1. **Start with open question**: "What problem does this solve?"
2. **5 Whys**: Dig to root cause
3. **Evidence**: "What data shows this is a real problem?"
4. **Role-playing**: "Walk me through a user's experience"
5. **6 Hats**: Explore competitive landscape from multiple angles
6. **Self-critique**: "What concerns would you raise about this approach?"
7. **Hindsight**: "If this fails, why?"
8. **Forced prioritization**: "What's the minimum viable solution?"
9. **Alternatives**: "What other approaches exist?"
10. **Contextual inquiry**: "Describe a specific instance when..."

---

## Best Practices

**DO**:
- ✅ Ask one question at a time
- ✅ Wait for complete answers
- ✅ Follow up on vague responses
- ✅ Adapt questions based on answers
- ✅ Seek specific examples, not generalizations
- ✅ Challenge respectfully

**DON'T**:
- ❌ Ask leading questions
- ❌ Accept surface answers
- ❌ Skip to solutions too quickly
- ❌ Overwhelm with multiple questions
- ❌ Assume you understand without clarifying

---

## When to Use Which Technique

| Technique | Best For | Skill |
|-----------|----------|-------|
| 5 Whys | Root cause analysis, pain points | create-project-brief (Q2) |
| 6 Hats | Multi-perspective analysis | create-project-brief (Q5-Q7) |
| Role-Playing | User understanding | create-project-brief (Q8-Q10) |
| Self-Critique | Risk identification | create-project-brief (Q15-Q16) |
| Hindsight | Success/failure scenarios | create-project-brief (Q14-Q15) |
| Assumption Challenging | Validating beliefs | All skills |
| Evidence-Based | Data-driven decisions | create-project-brief (Q4) |
| Forced Prioritization | Feature selection | create-prd, create-mission |
| Contextual Inquiry | Real usage understanding | create-project-brief (Q8-Q10) |
| Alternatives | Decision-making | create-architecture-doc (MANDATORY) |

---

## Example Conversations

See skill files for full examples:
- create-mission.md: Mission discovery conversation
- create-project-brief.md: BMAD Analyst conversation
- create-architecture-doc.md: BMAD Architect conversation with alternatives

---

## References

- BMAD Method: Advanced elicitation practices
- "The Ethnographic Interview" - James Spradley
- "Just Enough Research" - Erika Hall
- "User Story Mapping" - Jeff Patton
