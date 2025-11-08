# Elicitation Skill

**Purpose**: BMAD-style iterative questioning for deep product vision exploration

**Phase**: Phase 1 - Strategic Vision

**When to Use**: Starting new product, need deep exploration through back-and-forth questioning

---

## What This Skill Does

Iterative, conversational questioning that digs deep into product vision through true back-and-forth dialogue. Unlike `product-vision` skill (which lists questions), this asks one question, waits for answer, follows up based on response.

**BMAD-style approach**: Ask → Listen → Probe deeper → Repeat

---

## Process

### Starting Point

Begin with fundamental question, then follow conversation naturally based on answers.

### Question Flow (Adaptive)

**Start broad, go deep:**

1. **Problem**: "What problem are you solving?"
   - Listen to answer
   - Follow-up: "Why is this a problem?"
   - Follow-up: "Who experiences this problem most acutely?"
   - Follow-up: "What do they do today to solve it?"
   - Follow-up: "Why doesn't that solution work well enough?"

2. **Users**: "Who is this for?"
   - Listen to answer
   - Follow-up: "Tell me more about them - what's their day like?"
   - Follow-up: "When do they encounter this problem?"
   - Follow-up: "What would make them willing to try a new solution?"
   - Follow-up: "What would make them switch from current solution?"

3. **Value**: "What makes your solution better?"
   - Listen to answer
   - Follow-up: "Why can't competitors do that?"
   - Follow-up: "What's your unique advantage?"
   - Follow-up: "What could make this advantage go away?"

4. **Vision**: "What does success look like in 1 year?"
   - Listen to answer
   - Follow-up: "What needs to be true for that to happen?"
   - Follow-up: "What's the biggest risk to getting there?"
   - Follow-up: "What assumptions are you making?"

5. **Scope**: "What are you building first?"
   - Listen to answer
   - Follow-up: "Why start there vs something else?"
   - Follow-up: "What's the minimum that proves the value?"
   - Follow-up: "What are you explicitly NOT building in v1?"

### The "5 Whys" Technique

When answer seems surface-level, dig deeper:

**Example**:
```
You: "We need better project management tools"
Claude: "Why do you need better project management?"
You: "Current tools are too complex"
Claude: "Why is complexity a problem?"
You: "Teams don't use them consistently"
Claude: "Why don't teams use them?"
You: "Too much overhead to maintain"
Claude: "Why is there overhead?"
You: "Tools require too much manual data entry"
Claude: "Why is manual entry required?"
[Now we've found root problem: automation gap, not complexity]
```

### Listening and Adapting

**After each answer:**
- Acknowledge the response
- Identify what's unclear or worth exploring
- Ask follow-up that goes deeper
- Don't move to next topic until current one exhausted

**Red flags to probe**:
- Vague answers → Ask for specifics
- "Everyone" → Ask who specifically
- "Better" → Ask how measured
- "Easy" → Ask what's hard about current way
- Assumptions stated as facts → Challenge gently

---

## Key Principles

1. **One question at a time**: Wait for answer before next question
2. **Follow the conversation**: Don't stick to script, adapt based on answers
3. **Dig deeper**: Surface-level answers get "why" questions
4. **Challenge assumptions**: Gently question things stated as obvious
5. **Find the "why"**: Understand motivation, not just what
6. **No rush**: Take time to understand fully before moving on

---

## Example Session

**Goal**: Understand product vision for task management app

```
Claude: Let's explore your product idea through some questions.
        What problem are you solving?

You: Teams lose track of tasks across tools

Claude: Tell me more - where do tasks get lost?

You: Slack, email, meetings, different project tools

Claude: Which of those is the biggest pain point?

You: Probably Slack - important things get buried in conversations

Claude: Why is that a bigger problem than email or meetings?

You: Slack is where most day-to-day work happens, so most tasks originate there

Claude: What do teams do today when important things get buried?

You: They either forget about it, or someone has to dig through history

Claude: How often does forgetting happen? What's the impact?

You: Maybe 20-30% of verbal commitments get forgotten. Impact is missed deadlines, frustrated teammates

Claude: That's significant. Why can't existing task tools solve this?

You: They require context switching - people don't leave Slack to log tasks

Claude: So the real problem is context switching friction?

You: Yes! If it's not in Slack, it doesn't get captured

Claude: Interesting. So your solution needs to work within Slack?

You: Exactly, that's the key insight

Claude: What would this look like? How would someone create a task without leaving Slack?

[Conversation continues, digging deeper into solution approach...]
```

---

## When to Use vs product-vision Skill

**Use elicitation skill when**:
- Need deep exploration through questioning
- User benefits from guided discovery process
- Product vision is unclear or evolving
- Want to challenge assumptions and dig into "why"

**Use product-vision skill when**:
- User already has clarity, just needs to articulate it
- Want structured framework to consider all aspects
- Prefer self-guided exploration with question prompts
- Need to cover all bases systematically

**Can use both**: Start with elicitation for discovery, then product-vision to ensure completeness

---

## Transitioning Out

After thorough elicitation, summarize findings:

**Summary Format**:
```
Based on our conversation, here's what I understand:

**Problem**: [Core problem identified]
**Users**: [Who experiences this]
**Current Solution**: [What they do today]
**Why It Fails**: [Root cause]
**Your Solution**: [Proposed approach]
**Key Insight**: [Unique angle or advantage]
**Success Metric**: [How to measure]

Does this capture it? Anything to refine?
```

Then transition to next phase:
- Architecture exploration (if technical decisions needed)
- PRD creation (if vision is clear)
- Market research (if need validation)

---

## Tips for Effective Elicitation

**Do**:
- ✅ Listen actively to answers
- ✅ Ask follow-ups based on what you hear
- ✅ Challenge vague or assumed statements gently
- ✅ Dig until you understand the "why"
- ✅ Acknowledge good insights
- ✅ Keep questions focused and clear

**Don't**:
- ❌ Ask multiple questions at once
- ❌ Move on before fully understanding current topic
- ❌ Accept surface-level answers
- ❌ Follow rigid script regardless of answers
- ❌ Rush through questions
- ❌ Make it feel like interrogation (stay conversational)

---

## Output

**During Skill**: Conversational (stays in context, not saved)

**After Skill**: Optional summary of key findings

**Next Steps**: Use findings to inform:
- Architecture decisions
- PRD creation
- Market research focus
- Epic prioritization

---

## Related Skills

- **product-vision**: Structured exploration with question framework
- **architecture**: Technical decisions after vision clear
- **create-prd**: Formalize vision into requirements
