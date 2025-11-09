---
name: create-standards
description: Conversationally create product-specific coding standards (coding conventions, architecture patterns, testing standards, security guidelines, review checklist). Creates YAML files in `.aknakos/products/{name}/standards/` that override framework defaults. Use after mission creation when product has unique requirements.
---

## Instructions

Create 5 custom standards files in `.aknakos/products/{product-name}/standards/` as YAML to override framework defaults for this product only.

### When to Use

**Use**: Product has unique requirements (different tech stack, stricter security, team-specific conventions)

**Prerequisites**: `.aknakos/products/{product-name}/mission.md` must exist

**Duration**: 10-15 min

---

## Conversation Flow (7 Questions)

### Introduction (1 min)

"I'll help you create custom coding standards for {product-name}. We'll cover 5 areas:
1. Coding conventions (naming, formatting, patterns)
2. Architecture patterns (structure, database, API design)
3. Testing standards (TDD workflow, coverage, tools)
4. Security guidelines (auth, validation, OWASP)
5. Review checklist (code review criteria)

**Framework defaults**: SvelteKit + Svelte 5 + Better-Auth + Drizzle. We'll start with those and customize what's different."

### Q1: Tech Stack Differences (2 min)

"The framework defaults assume:
- Frontend: SvelteKit + Svelte 5
- Backend: SvelteKit API routes
- Database: PostgreSQL + Drizzle ORM
- Auth: Better-Auth
- Testing: Vitest + Testing Library + Cypress
- Runtime: Bun

**Are you using different technologies for this product?**

Examples: Different frontend framework (React, Vue), different backend (Express, Fastify), different database (MySQL, MongoDB), different auth library, different testing tools"

Action: If different tech stack → Note differences. If same → Use framework defaults.

### Q2: Naming Conventions (1-2 min)

"Framework defaults:
- Components: PascalCase (Hero.svelte)
- Files: kebab-case (better-auth.ts)
- Variables: camelCase (userAuthToken)
- Constants: UPPER_SNAKE_CASE (MAX_RETRY_ATTEMPTS)
- Database: snake_case (email_verified)

**Do you want different naming conventions?**"

### Q3: Code Formatting (1 min)

"Framework defaults: Tabs, Single quotes, Semicolons required, 100 char line length

**Do you want different formatting?**"

### Q4: Architecture Patterns (2-3 min)

"Framework default: Feature-based layered (routes/, lib/server/, lib/shared/)

**Does this product need different organization?**

Examples: Domain-driven design (DDD), microservices, monorepo, different folder structure

**Any specific architecture constraints?** (Serverless-only, multi-region, offline-first)"

### Q5: Testing Requirements (2-3 min)

"Framework defaults:
- TDD workflow: RED → GREEN → REFACTOR (mandatory)
- Coverage: 80% unit tests, 100% API endpoints, critical flows E2E
- Tools: Vitest (unit/component), Cypress (E2E)

**Different testing requirements?**

Examples: Higher/lower coverage, different E2E tool (Playwright), additional test types (performance, load, security, visual regression)"

### Q6: Security Requirements (2-3 min)

"Framework defaults:
- Auth: Better-Auth with bcrypt (12 rounds)
- Password: 8+ chars, 1 number, 1 special char
- OWASP Top 10 protection
- Rate limiting on auth endpoints
- Security headers via SvelteKit hooks

**Stricter or different security requirements?**

Examples: Compliance needs (HIPAA, SOC 2, GDPR), stricter password requirements (14+ chars), MFA required, additional auth methods (OAuth, SSO, SAML), industry-specific security standards"

### Q7: Review Checklist Additions (1-2 min)

"Framework defaults cover: Functionality, Testing (TDD), Code Quality, Architecture, Security, Performance, Documentation, Dependencies, Alignment (Epic/PRD/Mission)

**Additional review criteria?**

Examples: Accessibility requirements (WCAG 2.1 AA), mobile responsiveness, browser compatibility, localization/i18n, API contract versioning, performance budgets"

### Summary & Creation (2 min)

"**Summary of Custom Standards**

Based on your answers, here's what will be customized for {product-name}:

[List all customizations vs framework defaults]

**Creating product-specific standards...**"

Action:
1. Create `.aknakos/products/{product-name}/standards/` directory
2. For each of 5 standards files:
   - If customization needed → Create custom YAML with overrides
   - If using defaults → Skip file (framework defaults will be used)
3. Save files
4. Update `workflow.yaml`

---

## Output Format (YAML)

Only create files that differ from framework defaults.

Example (if only security needs customization):

```yaml
# products/my-product/standards/security-guidelines.yaml
version: "1.0"
updated: "2025-11-08"
note: "Custom security requirements for HIPAA compliance"

authentication:
  library: "better-auth with drizzleAdapter"
  password_hashing:
    algorithm: "bcrypt"
    salt_rounds: 14  # CUSTOM: Stricter than framework default (12)
  password_requirements:
    min_length: 14  # CUSTOM: Stricter than framework default (8)
    required: "1 uppercase, 1 lowercase, 1 number, 2 special characters"
    check_common: "zxcvbn library (required, not optional)"
  mfa:
    required: true  # CUSTOM: MFA mandatory for HIPAA
    methods: ["totp", "sms"]

compliance:  # CUSTOM: Added compliance section
  hipaa:
    audit_logging: "Required for all PHI access"
    encryption_at_rest: "AES-256"
    encryption_in_transit: "TLS 1.3"
    access_controls: "Role-based with audit trail"
    data_retention: "7 years minimum"
    breach_notification: "60 days"

# All other sections inherit from framework defaults
```

---

## Guidelines

**Conversational**: One question at a time, wait for user response, explain why each question matters, provide examples

**Concise**: Only create files that differ from defaults, use YAML (not markdown), focus on rules not examples

**Pragmatic**: If user says "use defaults", skip that section. Don't force customization. Allow "I'll decide later" → Use defaults for now

---

## After Completion

Update workflow state:
```yaml
products:
  {product-name}:
    standards_customized: true
    standards_files:
      - security-guidelines.yaml  # Only list files actually created
    standards_date: "2025-11-08"
```

Tell user:
"✅ Product-specific standards created in `.aknakos/products/{product-name}/standards/`

**Precedence**: Your custom standards will be used for this product. Framework defaults in `.aknakos/standards/` apply for everything else.

**Files created**: {list of customized files}

**Next step**: Ready to create PRD with `create-prd` skill!"

---

## Error Handling

**If mission.md doesn't exist**: "❌ Error: mission.md not found. Please run `create-mission` skill first."

**If standards directory already exists**: "⚠️ Standards directory already exists for {product-name}. Overwrite? [Yes/No]"

---

## Related Skills

- `create-mission`: Creates mission.md (prerequisite)
- `create-prd`: Next step after standards (references standards)
- `context-scope`: Explains when to load standards (Tier 3)
