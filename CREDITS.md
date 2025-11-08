# Credits & Acknowledgments

The Aknakos Framework was inspired by and builds upon the excellent work of several open-source AI agent frameworks. We are deeply grateful to these projects and their communities.

---

## Frameworks That Inspired Aknakos

### BMAD-METHOD

**Repository**: https://github.com/cheddarfox/bmad-method

**What We Learned**:
- Conversational strategic planning and elicitation techniques
- Multi-agent collaboration patterns for comprehensive planning
- Quality assurance integration throughout the development lifecycle
- Agent-as-code approach with markdown-based agent definitions
- Comprehensive test design and risk assessment methodology

**Concepts Used**:
- Iterative questioning approach (our `elicitation` skill)
- Strategic vision phase with deep exploration
- Review and quality gate processes

**License**: Open Source

**Credit**: The BMAD team for pioneering comprehensive AI agent frameworks for development

---

### Agent OS

**Repository**: https://github.com/buildermethods/agent-os

**Creator**: Brian Casel / Builder Methods

**What We Learned**:
- Spec-driven development methodology
- 3-layer context system (Standards, Product, Specs)
- Multi-agent orchestration patterns with Claude Code subagents
- Product-level planning integration (mission, roadmap, tech stack)
- Flexible single-agent and multi-agent workflow modes

**Concepts Used**:
- Parallel agent orchestration for complex features
- Context layer architecture
- Claude Code subagent integration patterns

**License**: Open Source

**Credit**: Builder Methods for systematic spec-driven development with AI

---

### OpenSpec

**Repository**: https://github.com/Fission-AI/OpenSpec

**Creator**: Fission-AI

**What We Learned**:
- Lightweight, fast implementation workflows
- Dual-folder architecture (specs vs changes)
- Formal requirement language (SHALL/MUST)
- Minimal overhead approach to specifications
- Focus on execution speed without sacrificing quality

**Concepts Used**:
- Lightweight Epic structure (acceptance criteria only)
- Fast TDD implementation cycles
- Minimal persistent documentation
- Brownfield-first thinking (modifying existing code)

**License**: MIT License (8,000+ GitHub stars)

**Credit**: Fission-AI for proving spec-driven development can be fast and lightweight

---

### Spec Kit

**Repository**: https://github.com/github/spec-kit

**Creator**: GitHub

**What We Learned**:
- Phased workflow structure (Specify → Plan → Tasks → Implement)
- Clear checkpoints and review stages
- Multi-tool compatibility approach
- Structured task breakdown methodology

**Concepts Used**:
- Phase-based workflow progression
- Clear separation of planning and execution
- Template-based approach to specifications

**License**: Open Source (GitHub official project)

**Credit**: GitHub for providing official guidance on spec-driven AI development

---

## Aknakos Unique Contributions

While inspired by the above frameworks, Aknakos introduces:

1. **Graduated Complexity Architecture**: Heavy documentation only where it matters (PRD), lightweight everywhere else (Epics), ephemeral for implementation (Stories/Tasks)

2. **Integrated TDD Workflow**: Test-driven development enforced through workflow states and automatic review agents, with strict rules about test modification

3. **5 Parallel Review Agents**: Automatic quality gates (test, security, architecture, quality, requirements) running simultaneously after implementation

4. **Hybrid Context Strategy**: Intelligent decision-making between planning mode tools and Context agent based on scope

5. **Claude Code Native Integration**: Optimized specifically for Claude Code's planning mode, not generic agent frameworks

6. **Adaptive Review Depth**: Review intensity automatically adjusts based on implementation complexity (1-9 scale)

7. **State-Driven Workflow**: Explicit workflow.yaml tracking with `whats-next` skill for intelligent guidance

---

## Technology Stack

- **Claude Code**: Anthropic's AI coding assistant (primary platform)
- **Claude Sonnet 4.5**: AI model powering the framework
- **Markdown**: Documentation format for skills, agents, and specifications
- **YAML**: State management and configuration

---

## Community

Aknakos stands on the shoulders of giants. We encourage users to explore all the frameworks listed above to understand the full landscape of AI-assisted development methodologies.

**Explore More**:
- BMAD-METHOD: For multi-domain agent frameworks and comprehensive planning
- Agent OS: For organizational standards and multi-agent orchestration
- OpenSpec: For lightweight spec-driven development
- Spec Kit: For GitHub ecosystem integration

---

## Contributing

If you'd like to contribute to Aknakos or have suggestions for improvement, please open an issue or pull request on our GitHub repository.

**Repository**: https://github.com/aknakos/AknakosAI

---

## License

Aknakos Framework is released under the MIT License, making it free to use, modify, and distribute.

See [LICENSE](./LICENSE) for full details.

---

**Thank you to all the open-source communities building the future of AI-assisted development!** 🙏
