---
name: elicitation
description: BMAD-style iterative questioning for deep product vision exploration. Ask one question, wait for answer, follow up based on response. Use when starting new product or need deep exploration through back-and-forth questioning (vs product-vision skill which lists questions).
---

## Instructions

Iterative, conversational questioning that digs deep into product vision through true back-and-forth dialogue.

### When to Use

**Use**: Starting new product, need deep exploration through back-and-forth questioning

**Phase**: 1 (Strategic Vision)

**BMAD-style approach**: Ask → Listen → Probe deeper → Repeat

---

## Process

### Starting Point

Begin with fundamental question, then follow conversation naturally based on answers.

### Question Flow (Adaptive)

Start broad, go deep:

**1. Problem**: "What problem are you solving?"
- Listen to answer
- Follow-up: "Why is this a problem?"
- Follow-up: "Who experiences this problem most acutely?"
- Follow-up: "What do they do today to solve it?"
- Follow-up: "Why doesn't that solution work well enough?"

**2. Users**: "Who is this for?"
- Listen to answer
- Follow-up: "Tell me more about them - what's their day like?"
- Follow-up: "When do they encounter this problem?"
- Follow-up: "What would make them willing to try a new solution?"
- Follow-up: "What would make them switch from current solution?"

**3. Value**: "What makes your solution better?"
- Listen to answer
- Follow-up: "Why can't competitors do that?"
- Follow-up: "What's your unique advantage?"
- Follow-up: "What could make this advantage go away?"

**4. Vision**: "What does success look like in 1 year?"
- Listen to answer
- Follow-up: "What needs to be true for that to happen?"
- Follow-up: "What's the biggest risk to getting there?"
- Follow-up: "What assumptions are you making?"

**5. Scope**: "What are you building first?"
- Listen to answer
- Follow-up: "Why start there vs something else?"
- Follow-up: "What's the minimum that proves the value?"
- Follow-up: "What are you explicitly NOT building in v1?"

---

## The "5 Whys" Technique

When answer seems surface-level, dig deeper:

Example:
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

---

## Listening and Adapting

**After each answer**:
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

## When to Use vs product-vision Skill

**Use elicitation skill when**: Need deep exploration through questioning, user benefits from guided discovery process, product vision is unclear or evolving, want to challenge assumptions and dig into "why"

**Use product-vision skill when**: User already has clarity (just needs to articulate it), want structured framework to consider all aspects, prefer self-guided exploration with question prompts, need to cover all bases systematically

**Can use both**: Start with elicitation for discovery, then product-vision to ensure completeness

---

## Transitioning Out

After thorough elicitation, summarize findings:

Summary Format:
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

## Tips

**DO**:
- ✅ Listen actively to answers
- ✅ Ask follow-ups based on what you hear
- ✅ Challenge vague or assumed statements gently
- ✅ Dig until you understand the "why"
- ✅ Acknowledge good insights
- ✅ Keep questions focused and clear

**DON'T**:
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

**Next Steps**: Use findings to inform architecture decisions, PRD creation, market research focus, Epic prioritization

---

## Related Skills

- `product-vision`: Structured exploration with question framework
- `architecture`: Technical decisions after vision clear
- `create-prd`: Formalize vision into requirements
