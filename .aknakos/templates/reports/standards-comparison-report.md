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
