# Aknakos Framework

**A hybrid AI agent framework for Claude Code that balances strategic depth with implementation speed.**

Version 1.0 | Built for Claude Code | Optimized for TDD

---

## What is Aknakos?

Aknakos combines the best of multiple AI agent frameworks:

- **Strategic Planning** (BMAD-inspired): Conversational exploration, formal PRDs, thorough architecture decisions
- **Fast Implementation** (OpenSpec-inspired): Lightweight Epics, native Claude planning mode, minimal overhead
- **Integrated TDD**: Test-driven development enforced through workflow and automatic review agents
- **Parallel Processing** (Agent OS-inspired): Research and review agents run in parallel for speed

**Core Philosophy**: Heavy documentation only where it matters (strategy), lightweight everywhere else (implementation).

---

## Quick Start

### 1. Read the Framework Manual

**Start here**: [`CLAUDE.md`](./CLAUDE.md) - Complete framework documentation for Claude

### 2. Understand the Workflow

```
Vision → PRD → Epics → Planning Mode → TDD → Automatic Review → Complete
```

### 3. Use the Framework

Talk to Claude and use skills/agents:

```
"Let's use the product-vision skill to explore this product idea"
"Use create-prd skill to formalize our requirements"
"Use epic-breakdown skill to break this into Epics"
"What's next?" (use whats-next skill for guidance)
```

---

## Installation & Setup

### First Use (This Project)

Already installed! Everything is ready in `.aknakos/` and `CLAUDE.md`.

Just start talking to Claude: `"Let's use the elicitation skill to explore a product idea"`

### Copy to New Project

**Quick copy** (from this project to another):

```bash
# Navigate to your new project
cd /path/to/new-project

# Copy framework files
cp -r /path/to/AknakosAI/.aknakos .
cp /path/to/AknakosAI/CLAUDE.md .
```

**Create reusable template** (one-time setup):

```bash
# Save as template (do this once)
mkdir -p ~/.aknakos-template
cp -r .aknakos ~/.aknakos-template/
cp CLAUDE.md ~/.aknakos-template/

# Then use in any new project
cd /path/to/new-project
cp -r ~/.aknakos-template/.aknakos .
cp ~/.aknakos-template/CLAUDE.md .
```

That's it! No `npm install`, no dependencies, no setup scripts.

---

## Framework Structure

```
CLAUDE.md                    # ⭐ START HERE - Framework manual for Claude
Aknakos_Framework_Specification.md    # Complete spec for humans

.aknakos/
├── state/workflow.yaml      # Tracks workflow state
├── skills/                  # 7 Claude Skills for strategic work
├── agents/                  # 9 Agents for parallel work
│   └── review/              # 5 Review agents (automatic quality gates)
└── templates/               # PRD and Epic templates

products/                    # Your products go here
└── {product-name}/
    ├── YYYY-MM-DD-prd.md   # Formal PRD
    ├── epics/               # Lightweight Epics
    ├── plans/               # Optional saved plans
    └── reviews/             # Review reports
```

---

## Key Features

### ✅ Graduated Complexity

- **Heavy**: Only PRD (formal requirements with SHALL/MUST)
- **Light**: Epics (just acceptance criteria)
- **Ephemeral**: Stories/Tasks (planning mode only, not saved)

### ✅ TDD Integrated

- Tests written first (RED)
- Tests reviewed against plan
- Implementation makes tests pass (GREEN)
- Automatic verification via test-reviewer agent

### ✅ Automatic Quality Gates

5 parallel review agents run automatically after implementation:
- Test Reviewer (TDD compliance, coverage)
- Security Reviewer (vulnerabilities, best practices)
- Architecture Reviewer (patterns, design quality)
- Quality Reviewer (code quality, maintainability)
- Requirements Reviewer (acceptance criteria completeness)

### ✅ Claude Code Native

- Uses Claude's planning mode (not rigid agent frameworks)
- Leverages native tools (Explore, Read, Grep, Glob)
- Optional Context agent for large codebases
- Fast and flexible

---

## Documentation

| Document | Purpose | Audience |
|----------|---------|----------|
| **CLAUDE.md** | Framework instruction manual | Claude (AI) |
| **Aknakos_Framework_Specification.md** | Complete framework spec | Humans |
| **README.md** (this file) | Quick overview | Humans |
| **AI_Agent_Frameworks_Comparison.md** | Background research | Reference |

---

## Skills (8 total)

Skills stay in main conversation context:

1. **elicitation**: Iterative questioning (BMAD-style deep exploration)
2. **product-vision**: Strategic product planning
3. **architecture**: Tech stack and pattern decisions
4. **create-prd**: Generate formal PRD
5. **epic-breakdown**: Break PRD into Epics
6. **whats-next**: Show what to do next (use this frequently!)
7. **context-scope**: Decide if Context agent needed
8. **epic-review**: Synthesize review learnings

---

## Agents (9 total)

Agents run in parallel in separate contexts:

**Research/Exploration** (4 agents):
1. **market-research**: Market analysis, competitors
2. **tech-exploration**: Compare tech options
3. **epic-parallel**: Generate multiple Epics simultaneously
4. **context-gatherer**: Map large codebases

**Review** (5 agents - automatic):
5. **test-reviewer**: TDD compliance, test quality
6. **security-reviewer**: Security audit
7. **architecture-reviewer**: Design consistency
8. **quality-reviewer**: Code quality
9. **requirements-reviewer**: Acceptance criteria

---

## Workflow Phases

1. **Strategic Vision** (Skills + Research Agents)
2. **PRD Creation** (Formal documentation - last heavy doc!)
3. **Epic Breakdown** (Lightweight files)
4. **Planning Mode** (Stories + Tasks + Test Specs)
5. **TDD Implementation** (RED → GREEN → REFACTOR)
6. **Automatic Review** (5 parallel agents)
7. **Epic Completion** (Synthesize learnings)

---

## When to Use This Framework

**Perfect For**:
- Solo developers wanting structure without overhead
- Small teams needing consistent quality
- Projects where TDD is important
- Those who love Claude Code's planning mode

**Not Ideal For**:
- Teams needing heavyweight project management
- Projects where TDD doesn't fit
- Those preferring completely ad-hoc development

---

## Core Principles

1. **Strategic Depth**: Thorough planning where it matters (vision, architecture, PRD)
2. **Implementation Speed**: Fast TDD cycles with minimal documentation overhead
3. **TDD by Default**: Tests first, always
4. **Adaptive Review**: Review intensity matches complexity
5. **Parallel When Beneficial**: Research and review in parallel, implementation focused

---

## Example Session

```
You: Let's build a task management app

Claude: Great! Let's start with the product-vision skill to explore your idea.

[Vision exploration - conversational]

You: Now let's formalize this

Claude: I'll use the create-prd skill to create a formal PRD...

[PRD created: products/task-app/2025-11-08-prd.md]

You: Break this into Epics

Claude: Using epic-breakdown skill...

[Epics created: user-auth, task-management, dashboard, etc.]

You: What's next?

Claude: [Uses whats-next skill]
Ready to implement user-auth Epic!
Enter planning mode (Shift+Tab twice) to create Stories, Tasks, and Test Specifications.

[You enter planning mode, create plan with test specs]

You: [Exit planning mode, write tests, implement, refactor]

Claude: Implementation complete! Spawning 5 review agents...

[Review agents run in parallel, return reports]

Claude: Review complete!
- Test Review: PASS
- Security Review: CONCERNS (password reset token expiration)
- Architecture Review: PASS
- Quality Review: PASS
- Requirements Review: PASS

Please address security concern, then we can complete the Epic.
```

---

## Getting Help

- **"What's next?"** → Use `whats-next` skill
- **"Should I use Context agent?"** → Use `context-scope` skill
- **"What did we learn?"** → Use `epic-review` skill after Epic completion
- **Read CLAUDE.md** → Complete framework documentation
- **Check workflow.yaml** → See current state

---

## Version

**Version**: 1.0
**Release Date**: 2025-11-08
**Compatible With**: Claude Code (Sonnet 4.5)

---

## Credits

Inspired by:
- **BMAD-METHOD**: Strategic planning and multi-agent collaboration
- **Agent OS**: Context layers and orchestration
- **OpenSpec**: Lightweight implementation
- **Spec Kit**: Phased workflow structure

Optimized specifically for **Claude Code** with integrated **TDD methodology**.

---

## License

Open source - use and modify as needed for your projects.

---

**Ready to start?** Read [`CLAUDE.md`](./CLAUDE.md) and begin with the `product-vision` skill!
