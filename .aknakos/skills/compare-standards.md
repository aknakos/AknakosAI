# Skill: Compare Standards

Show product-specific vs framework default standards differences and visualize inheritance hierarchy.

## Purpose

Understand which standards are customized for a product and how they differ from framework defaults. Help decide which standards to customize.

## When to Use

- **After create-standards**: Review customizations made
- **Before customization**: See what framework defaults exist
- **Troubleshooting**: Understand why review failed (custom vs default standards)
- **Documentation**: Show stakeholders what standards apply
- **Time**: 1-2 min per product

---

## What This Skill Does

Compares standards files between framework defaults and product-specific overrides:
- Shows which standards are customized vs inherited
- Diffs customized standards against framework defaults
- Recommends standards to customize based on product needs
- Validates standards file format

---

## Process

### 1. Load Framework Defaults

**Read framework standards**:
```
@.aknakos/standards/coding-conventions.yaml
@.aknakos/standards/architecture-patterns.yaml
@.aknakos/standards/testing-standards.yaml
@.aknakos/standards/security-guidelines.yaml
@.aknakos/standards/review-checklist.yaml
```

**Parse**: Extract keys, rules, patterns

### 2. Load Product-Specific Standards

**Check**: `products/{name}/standards/` directory

**For each standard file**:
- If exists: Read and parse YAML
- If not exists: Product uses framework default

**Possible files**:
```
products/{name}/standards/
├── coding-conventions.yaml
├── architecture-patterns.yaml
├── testing-standards.yaml
├── security-guidelines.yaml
└── review-checklist.yaml
```

### 3. Compare Standards

**For each standard type**:

**If product-specific exists**:
- Diff against framework default
- Identify added rules
- Identify modified rules
- Identify removed rules
- Highlight significant differences

**If product-specific doesn't exist**:
- Note: "Uses framework default"
- Show framework default content

### 4. Analyze Inheritance

**Precedence**:
```
products/{name}/standards/{file}.yaml  [HIGHEST PRECEDENCE]
  ↓ (if not found)
.aknakos/standards/{file}.yaml  [FRAMEWORK DEFAULT]
```

**For each product**:
- Count customized standards (0-5)
- List inherited standards
- Show inheritance ratio

### 5. Generate Comparison Report

**Output**: Comparison summary with recommendations

---

## Comparison Report Format

```markdown
# Standards Comparison Report

**Product**: {name}
**Generated**: {YYYY-MM-DD}
**Framework Version**: 1.0

---

## Summary

**Customized Standards**: 2/5 (40%)
**Inherited Standards**: 3/5 (60%)

**Customization Strategy**: Selective (recommended)

---

## Standards Inheritance Overview

| Standard | Source | Status |
|----------|--------|--------|
| coding-conventions.yaml | Product-specific | ✏️ Customized |
| architecture-patterns.yaml | Framework default | 📦 Inherited |
| testing-standards.yaml | Product-specific | ✏️ Customized |
| security-guidelines.yaml | Framework default | 📦 Inherited |
| review-checklist.yaml | Framework default | 📦 Inherited |

---

## Customized Standards

### 1. coding-conventions.yaml

**Source**: `products/my-product/standards/coding-conventions.yaml`
**Status**: ✏️ Customized
**Last Modified**: 2025-11-08

#### Differences from Framework Default

**Added Rules**:
```yaml
# Product-specific addition
file_naming:
  components: "PascalCase.svelte"  # NEW: Stricter than framework default
  utilities: "camelCase.ts"

# Product-specific requirement
documentation:
  require_jsdoc: true  # NEW: Framework default doesn't require JSDoc
  jsdoc_tags: ["param", "returns", "throws"]
```

**Modified Rules**:
```yaml
# Framework default:
indentation:
  type: "spaces"
  size: 2

# Product-specific override:
indentation:
  type: "tabs"  # CHANGED: Product uses tabs instead of spaces
  size: 4
```

**Removed Rules**:
```yaml
# Framework default has this rule, product removed it:
# max_line_length: 100  # REMOVED: Product has no line length limit
```

#### Rationale for Customization

From `products/my-product/standards/coding-conventions.yaml` comments:
- Tabs for accessibility (screen reader compatibility)
- JSDoc required for API surface (public libraries)
- Component naming matches Svelte best practices

---

### 2. testing-standards.yaml

**Source**: `products/my-product/standards/testing-standards.yaml`
**Status**: ✏️ Customized
**Last Modified**: 2025-11-08

#### Differences from Framework Default

**Added Rules**:
```yaml
# Product-specific requirement
coverage:
  minimum: 90%  # NEW: Framework default is 80%
  branches: 85%
  functions: 95%

# Product-specific test types
test_types:
  - unit
  - integration
  - e2e
  - performance  # NEW: Added performance testing requirement
```

**Modified Rules**:
```yaml
# Framework default:
test_naming: "should {behavior} when {condition}"

# Product-specific:
test_naming: "{feature}: {behavior} - {condition}"  # CHANGED: Different format
```

#### Rationale for Customization

- Higher coverage for financial product (90% required by regulation)
- Performance testing for SLA requirements
- Test naming matches team convention

---

## Inherited Standards

### 3. architecture-patterns.yaml

**Source**: `.aknakos/standards/architecture-patterns.yaml`
**Status**: 📦 Inherited (Framework Default)

**Framework Default Content**:
```yaml
patterns:
  preferred:
    - name: "Repository Pattern"
      when: "Database access"
      reason: "Separates data access logic"

    - name: "Service Layer"
      when: "Business logic"
      reason: "Keeps components thin"

  avoid:
    - name: "God Objects"
      reason: "Violates single responsibility"

    - name: "Circular Dependencies"
      reason: "Hard to test and maintain"

tech_stack:
  framework: "SvelteKit"
  ui: "Svelte 5"
  auth: "Better-Auth"
  database: "PostgreSQL + Drizzle ORM"
  testing: "Vitest + Cypress"
  runtime: "Bun"
```

**Why Inherited**: Framework defaults match product needs

**Consider Customizing If**:
- Using different database (not PostgreSQL)
- Using different auth provider (not Better-Auth)
- Have product-specific architectural patterns

---

### 4. security-guidelines.yaml

**Source**: `.aknakos/standards/security-guidelines.yaml`
**Status**: 📦 Inherited (Framework Default)

**Framework Default Content**:
```yaml
authentication:
  password_min_length: 12
  password_complexity: true
  mfa_required: false  # Optional by default
  session_timeout: 3600  # 1 hour

data_protection:
  encryption_at_rest: true
  encryption_in_transit: true
  pii_handling: "encrypt"

owasp_top_10:
  check_injection: true
  check_broken_auth: true
  check_sensitive_data: true
  check_xxe: true
  check_broken_access: true
  check_security_misconfig: true
  check_xss: true
  check_insecure_deserialization: true
  check_components: true
  check_logging: true
```

**Why Inherited**: Framework defaults are secure and comprehensive

**Consider Customizing If**:
- Regulatory requirements (HIPAA, PCI-DSS, SOC 2)
- Need MFA required (not optional)
- Shorter session timeout for high-security product

---

### 5. review-checklist.yaml

**Source**: `.aknakos/standards/review-checklist.yaml`
**Status**: 📦 Inherited (Framework Default)

**Framework Default Content**:
```yaml
test_review:
  - "Tests written before implementation"
  - "Tests fail initially (RED phase)"
  - "Tests match plan specifications"
  - "Coverage meets standards"
  - "Edge cases tested"

security_review:
  - "No hardcoded secrets"
  - "Input validation present"
  - "Authentication required"
  - "Authorization checked"
  - "OWASP Top 10 addressed"

architecture_review:
  - "Follows architecture.md patterns"
  - "Uses tech stack from tech-stack.md"
  - "No unapproved dependencies"
  - "Patterns consistent with codebase"

quality_review:
  - "Code follows conventions"
  - "Functions are single-purpose"
  - "No code duplication"
  - "Error handling present"
  - "Logging appropriate"

requirements_review:
  - "Implements Epic acceptance criteria"
  - "Traces to PRD requirements"
  - "Aligns with mission goals"
  - "Matches UX flows (if applicable)"
```

**Why Inherited**: Framework defaults cover all review aspects

**Consider Customizing If**:
- Industry-specific review requirements
- Additional review steps for compliance
- Product-specific quality criteria

---

## Customization Recommendations

### Recommended to Customize

Based on product characteristics:

#### 1. security-guidelines.yaml

**Why**: Financial/healthcare products need stricter security
**Suggested Changes**:
```yaml
# Customize for high-security product
authentication:
  password_min_length: 16  # Increase from 12
  mfa_required: true  # Change from optional
  session_timeout: 900  # 15 min instead of 1 hour
```

#### 2. testing-standards.yaml

**Why**: Regulated products need higher coverage
**Suggested Changes**:
```yaml
# Customize for regulated product
coverage:
  minimum: 90%  # Increase from 80%
  critical_paths: 100%  # New requirement
```

### Optional to Customize

#### 3. coding-conventions.yaml

**When**: Team has strong existing conventions
**Example**: Different formatting, naming, or documentation rules

### Rarely Need to Customize

#### 4. architecture-patterns.yaml

**When**: Using completely different tech stack
**Example**: Not using SvelteKit, different database

#### 5. review-checklist.yaml

**When**: Industry-specific compliance requirements
**Example**: FDA for medical, PCI-DSS for payments

---

## Diff Visualization

### coding-conventions.yaml Diff

```diff
# Framework Default (.aknakos/standards/coding-conventions.yaml)
  naming:
    variables: "camelCase"
    constants: "UPPER_SNAKE_CASE"
    components: "PascalCase"

  indentation:
-   type: "spaces"
-   size: 2
+   type: "tabs"  # Product override
+   size: 4

+ documentation:  # Product addition
+   require_jsdoc: true
+   jsdoc_tags: ["param", "returns", "throws"]
```

---

## Standards Health Check

**Customization Balance**: ✅ Good

- **Too few customizations** (0-1): May not fit product needs
- **Balanced** (2-3): Good, selective customization ✅
- **Too many customizations** (4-5): May indicate framework mismatch

**Current**: 2/5 customized (40%) - Optimal range

---

## How to Customize Standards

### Step 1: Copy Framework Default

```bash
# Copy framework default to product standards
cp .aknakos/standards/security-guidelines.yaml products/my-product/standards/
```

### Step 2: Modify Product-Specific File

```yaml
# products/my-product/standards/security-guidelines.yaml

# Add rationale comments
# CUSTOMIZATION RATIONALE: PCI-DSS compliance requires MFA

authentication:
  mfa_required: true  # Changed from false (PCI-DSS requirement)
  session_timeout: 900  # Changed from 3600 (15 min for PCI-DSS)
```

### Step 3: Update Workflow State

```yaml
# .aknakos/state/workflow.yaml
products:
  my-product:
    standards_customized: true
    standards_files:
      - "security-guidelines.yaml"
    standards_date: "2025-11-08"
```

### Step 4: Validate

```
Run compare-standards skill to verify changes
```

---

## Integration with Workflow

**Use this skill**:
- **After create-standards**: Verify customizations
- **Before Epic implementation**: Understand which standards apply
- **During review**: Explain why review used specific criteria
- **Documentation**: Show stakeholders standards in use

**Related Skills**:
- `create-standards`: Creates product-specific standards
- `validate-state`: Checks standards files referenced in workflow.yaml exist

---

## Tips for Success

- **Customize selectively**: Only override what's needed
- **Document rationale**: Add comments explaining why customized
- **Review regularly**: Standards may need updates as product evolves
- **Start minimal**: Begin with framework defaults, customize when needed
- **Keep consistent**: Don't create conflicting rules across standards

---

## Common Scenarios

### Scenario 1: Using different tech stack

**Action**: Customize `architecture-patterns.yaml`
```yaml
# Override framework default
tech_stack:
  framework: "Next.js"  # Instead of SvelteKit
  ui: "React"  # Instead of Svelte 5
  database: "MongoDB + Mongoose"  # Instead of PostgreSQL + Drizzle
```

### Scenario 2: Stricter security requirements

**Action**: Customize `security-guidelines.yaml`
```yaml
# Add regulatory requirements
compliance:
  - "HIPAA"
  - "SOC 2 Type II"

authentication:
  mfa_required: true
  password_min_length: 16
```

### Scenario 3: Team coding style

**Action**: Customize `coding-conventions.yaml`
```yaml
# Match existing team conventions
indentation:
  type: "tabs"  # Team preference

naming:
  components: "kebab-case.svelte"  # Different from framework
```

---

## Example Usage

```
User: I want to see what standards I've customized

Claude: I'll run the compare-standards skill to show you.

[Generates comparison report]

You've customized 2/5 standards:
✏️ coding-conventions.yaml - Changed indentation to tabs, added JSDoc requirement
✏️ testing-standards.yaml - Increased coverage to 90%, added performance tests

📦 Inherited 3 framework defaults:
- architecture-patterns.yaml
- security-guidelines.yaml
- review-checklist.yaml

Customization balance: Good (40% customized)

Would you like to customize any inherited standards?
```

---

## What's Next

After comparing standards:
- Customize additional standards if needed (use `create-standards`)
- Update documentation with standards rationale
- Ensure review agents use correct standards (automatic via precedence)
