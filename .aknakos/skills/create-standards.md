# Create Standards Skill

**Purpose**: Conversationally create product-specific coding standards

**Phase**: After mission creation (Phase 1a)

**When to Use**:
- User wants custom standards for this product
- Product has unique requirements (e.g., different tech stack, stricter security)
- Team has specific conventions different from framework defaults

**Duration**: 10-15 minutes

---

## What This Skill Does

Creates 5 custom standards files in `products/{product-name}/standards/` as YAML:
1. `coding-conventions.yaml`
2. `architecture-patterns.yaml`
3. `testing-standards.yaml`
4. `security-guidelines.yaml`
5. `review-checklist.yaml`

These override framework defaults in `.aknakos/standards/` for this product only.

---

## Prerequisites

**Must exist**:
- `products/{product-name}/mission.md`

**Load before starting**:
- `.aknakos/standards/coding-conventions.yaml` (framework defaults)
- `.aknakos/standards/architecture-patterns.yaml`
- `.aknakos/standards/testing-standards.yaml`
- `.aknakos/standards/security-guidelines.yaml`
- `.aknakos/standards/review-checklist.yaml`

---

## Conversation Flow

### Introduction (1 min)

"I'll help you create custom coding standards for {product-name}. We'll cover 5 areas:
1. Coding conventions (naming, formatting, patterns)
2. Architecture patterns (structure, database, API design)
3. Testing standards (TDD workflow, coverage, tools)
4. Security guidelines (auth, validation, OWASP)
5. Review checklist (what to check during code review)

**Framework defaults**: The framework has default standards based on SvelteKit + Svelte 5 + Better-Auth + Drizzle. We'll start with those and customize what's different for your product.

Let's begin!"

---

### Q1: Tech Stack Differences (2 min)

"**Q1: Tech Stack**

The framework defaults assume:
- Frontend: SvelteKit + Svelte 5
- Backend: SvelteKit API routes
- Database: PostgreSQL + Drizzle ORM
- Auth: Better-Auth
- Testing: Vitest + Testing Library + Cypress
- Runtime: Bun

**Are you using different technologies for this product?**

Examples:
- Different frontend framework (React, Vue, etc.)
- Different backend (Express, Fastify, etc.)
- Different database (MySQL, MongoDB, etc.)
- Different auth library
- Different testing tools (Jest, Playwright, etc.)

If yes, describe the tech stack. If no, we'll use framework defaults."

**Action**:
- If different tech stack → Note differences for customization
- If same → Note "using framework defaults for tech stack"

---

### Q2: Naming Conventions (1-2 min)

"**Q2: Naming Conventions**

Framework defaults:
- Components: PascalCase (Hero.svelte)
- Files: kebab-case (better-auth.ts)
- Variables: camelCase (userAuthToken)
- Constants: UPPER_SNAKE_CASE (MAX_RETRY_ATTEMPTS)
- Database: snake_case (email_verified)

**Do you want different naming conventions for this product?**

Examples:
- Use snake_case for everything (Python convention)
- Use PascalCase for files (C# convention)
- Different constant naming

If no, we'll use framework defaults."

**Action**:
- If different → Note custom naming conventions
- If same → Use framework defaults

---

### Q3: Code Formatting (1 min)

"**Q3: Code Formatting**

Framework defaults:
- Indentation: Tabs
- Quotes: Single
- Semicolons: Required
- Line length: 100 characters

**Do you want different formatting for this product?**

If no, we'll use framework defaults."

**Action**:
- If different → Note custom formatting rules
- If same → Use framework defaults

---

### Q4: Architecture Patterns (2-3 min)

"**Q4: Architecture Organization**

Framework default: Feature-based layered (routes/, lib/server/, lib/shared/)

**Does this product need a different organization pattern?**

Examples:
- Domain-driven design (DDD)
- Microservices architecture
- Monorepo with multiple apps
- Different folder structure

**Also, any specific architecture constraints?**
- Serverless-only (Vercel/Railway)
- Traditional server deployment
- Multi-region requirements
- Offline-first

If no special needs, we'll use framework defaults."

**Action**:
- Note any architecture differences
- Note deployment constraints

---

### Q5: Testing Requirements (2-3 min)

"**Q5: Testing Standards**

Framework defaults:
- TDD workflow: RED → GREEN → REFACTOR (mandatory)
- Coverage: 80% unit tests, 100% API endpoints, critical flows E2E
- Tools: Vitest (unit/component), Cypress (E2E)

**Does this product have different testing requirements?**

Examples:
- Higher/lower coverage requirements
- Different E2E tool (Playwright instead of Cypress)
- Additional test types (performance, load, security)
- Visual regression testing
- Different TDD rules

If no, we'll use framework defaults."

**Action**:
- Note any testing requirement differences
- Note any additional test types needed

---

### Q6: Security Requirements (2-3 min)

"**Q6: Security Standards**

Framework defaults:
- Auth: Better-Auth with bcrypt (12 rounds)
- Password: 8+ chars, 1 number, 1 special char
- OWASP Top 10 protection
- Rate limiting on auth endpoints
- Security headers via SvelteKit hooks

**Does this product have stricter or different security requirements?**

Examples:
- Compliance needs (HIPAA, SOC 2, GDPR)
- Stricter password requirements (14+ chars, multiple special chars)
- MFA required
- Additional auth methods (OAuth, SSO, SAML)
- Industry-specific security standards
- Penetration testing requirements

If no special security needs, we'll use framework defaults."

**Action**:
- Note any compliance requirements
- Note any stricter security rules
- Note additional auth methods

---

### Q7: Review Checklist Additions (1-2 min)

"**Q7: Code Review Checklist**

Framework defaults cover:
- Functionality, Testing (TDD), Code Quality
- Architecture, Security, Performance
- Documentation, Dependencies
- Alignment (Epic/PRD/Mission)

**Does this product need additional review criteria?**

Examples:
- Accessibility requirements (WCAG 2.1 AA)
- Mobile responsiveness checks
- Browser compatibility requirements
- Localization/i18n checks
- API contract versioning
- Specific performance budgets

If no, we'll use framework defaults."

**Action**:
- Note any additional review criteria
- Note any specific quality gates

---

### Summary & Creation (2 min)

"**Summary of Custom Standards**

Based on your answers, here's what will be customized for {product-name}:

[List all customizations vs framework defaults]

**Creating product-specific standards...**"

**Action**:
1. Create `products/{product-name}/standards/` directory
2. For each of 5 standards files:
   - If customization needed → Create custom YAML with overrides
   - If using defaults → Skip file (framework defaults will be used)
3. Save files
4. Update `workflow.yaml`:
   ```yaml
   products:
     {product-name}:
       standards_customized: true/false
       standards_files: [list of customized files]
   ```

---

## Output Format (YAML)

Only create files that differ from framework defaults.

**Example** (if only security needs customization):

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

**Conversational**:
- One question at a time
- Wait for user response before next question
- Explain why each question matters
- Provide examples

**Concise**:
- Only create files that differ from defaults
- Use YAML (not markdown)
- Focus on rules, not examples (Claude can search docs)

**Portable**:
- No references to specific projects
- No hardcoded paths
- Framework-agnostic where possible

**Pragmatic**:
- If user says "use defaults", skip that section
- Don't force customization if not needed
- Allow "I'll decide later" → Use defaults for now

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

**Tell user**:
"✅ Product-specific standards created in `products/{product-name}/standards/`

**Precedence**: Your custom standards will be used for this product. Framework defaults in `.aknakos/standards/` apply for everything else.

**Files created**: {list of customized files}

**Next step**: Ready to create PRD with `create-prd` skill!"

---

## Error Handling

**If mission.md doesn't exist**:
"❌ Error: mission.md not found. Please run `create-mission` skill first."

**If standards directory already exists**:
"⚠️ Standards directory already exists for {product-name}. Overwrite? [Yes/No]"

---

## Related Skills

- **create-mission**: Creates mission.md (prerequisite)
- **create-prd**: Next step after standards (references standards)
- **context-scope**: Explains when to load standards (Tier 3)
