---
name: compare-standards
description: Show product-specific vs framework default standards differences and visualize inheritance hierarchy. Understand which standards are customized and how they differ from defaults. Use after create-standards (review customizations), before customization (see defaults), troubleshooting (understand review criteria), or for documentation.
---

## Instructions

Compare standards files between framework defaults and product-specific overrides to understand customization strategy.

### When to Use

**Use**: After create-standards (review customizations), before customization (see what framework defaults exist), troubleshooting failed reviews (custom vs default standards), documentation (show stakeholders standards)

**Don't Use**: No product defined, framework defaults don't exist

**Time**: 1-2 min per product

### Process

**Step 1: Load Framework Defaults**

Read framework standards:
```
.aknakos/standards/coding-conventions.yaml
.aknakos/standards/architecture-patterns.yaml
.aknakos/standards/testing-standards.yaml
.aknakos/standards/security-guidelines.yaml
.aknakos/standards/review-checklist.yaml
```

Parse: Extract keys, rules, patterns

**Step 2: Load Product-Specific Standards**

Check `.aknakos/products/{name}/standards/` directory.

**For each standard file**:
- If exists: Read and parse YAML
- If not exists: Product uses framework default

**Possible files**:
```
.aknakos/products/{name}/standards/
├── coding-conventions.yaml
├── architecture-patterns.yaml
├── testing-standards.yaml
├── security-guidelines.yaml
└── review-checklist.yaml
```

**Step 3: Compare Standards**

**For each standard type**:

**If product-specific exists**:
- Diff against framework default
- Identify added rules (NEW)
- Identify modified rules (CHANGED)
- Identify removed rules (REMOVED)
- Highlight significant differences

**If product-specific doesn't exist**:
- Note: "Uses framework default"
- Show framework default content

**Step 4: Analyze Inheritance**

**Precedence**:
```
.aknakos/products/{name}/standards/{file}.yaml  [HIGHEST PRECEDENCE]
  ↓ (if not found)
.aknakos/standards/{file}.yaml  [FRAMEWORK DEFAULT]
```

**For each product**:
- Count customized standards (0-5)
- List inherited standards
- Show inheritance ratio

**Customization Balance**:
- Too few (0-1): May not fit product needs
- Balanced (2-3): Good, selective customization ✅
- Too many (4-5): May indicate framework mismatch

**Step 5: Generate Comparison Report**

Use template: `.aknakos/templates/reports/standards-comparison-report.md`

**Sections**:
- Summary (customized/inherited counts, customization strategy)
- Standards Inheritance Overview (table showing source and status)
- Customized Standards (per standard: source, differences from default, rationale)
- Inherited Standards (per standard: framework default content, why inherited, consider customizing if...)
- Customization Recommendations (recommended/optional/rarely need to customize)
- Diff Visualization (unified diff format)
- Standards Health Check (customization balance assessment)

**Save to**: `.aknakos/products/{product-name}/reviews/standards/YYYY-MM-DD-standards-comparison.md`

### How to Customize Standards

**Step 1: Copy Framework Default**
```bash
cp .aknakos/standards/security-guidelines.yaml products/my-product/standards/
```

**Step 2: Modify Product-Specific File**
```yaml
# products/my-product/standards/security-guidelines.yaml

# Add rationale comments
# CUSTOMIZATION RATIONALE: PCI-DSS compliance requires MFA

authentication:
  mfa_required: true  # Changed from false (PCI-DSS requirement)
  session_timeout: 900  # Changed from 3600 (15 min for PCI-DSS)
```

**Step 3: Update Workflow State**
```yaml
# .aknakos/state/workflow.yaml
products:
  my-product:
    standards_customized: true
    standards_files:
      - "security-guidelines.yaml"
    standards_date: "2025-11-08"
```

**Step 4: Validate**

Run `compare-standards` skill to verify changes.

### Common Scenarios

**Scenario 1: Different tech stack**

Customize `architecture-patterns.yaml`:
```yaml
# Override framework default
tech_stack:
  framework: "Next.js"  # Instead of SvelteKit
  ui: "React"  # Instead of Svelte 5
  database: "MongoDB + Mongoose"  # Instead of PostgreSQL + Drizzle
```

**Scenario 2: Stricter security requirements**

Customize `security-guidelines.yaml`:
```yaml
# Add regulatory requirements
compliance:
  - "HIPAA"
  - "SOC 2 Type II"

authentication:
  mfa_required: true
  password_min_length: 16
```

**Scenario 3: Team coding style**

Customize `coding-conventions.yaml`:
```yaml
# Match existing team conventions
indentation:
  type: "tabs"  # Team preference

naming:
  components: "kebab-case.svelte"  # Different from framework
```

### Customization Guidelines

**Customize Selectively**:
- Only override what's needed
- Document rationale in YAML comments
- Start minimal (begin with framework defaults, customize when needed)

**Recommended to Customize**:
- `security-guidelines.yaml`: Financial/healthcare products with stricter security
- `testing-standards.yaml`: Regulated products with higher coverage requirements

**Optional to Customize**:
- `coding-conventions.yaml`: Team has strong existing conventions

**Rarely Need to Customize**:
- `architecture-patterns.yaml`: Using completely different tech stack
- `review-checklist.yaml`: Industry-specific compliance requirements

### Integration

**Use this skill**:
- **After create-standards**: Verify customizations
- **Before Epic implementation**: Understand which standards apply
- **During review**: Explain why review used specific criteria
- **Documentation**: Show stakeholders standards in use

**Related Skills**:
- `create-standards`: Creates product-specific standards
- `validate-state`: Checks standards files referenced in workflow.yaml exist

### Diff Format

**Unified diff visualization**:
```diff
# Framework Default
  naming:
    variables: "camelCase"
    constants: "UPPER_SNAKE_CASE"

  indentation:
-   type: "spaces"
-   size: 2
+   type: "tabs"  # Product override
+   size: 4

+ documentation:  # Product addition
+   require_jsdoc: true
```

### Output

**Console summary**:
```
You've customized 2/5 standards:
✏️ coding-conventions.yaml - Changed indentation to tabs, added JSDoc requirement
✏️ testing-standards.yaml - Increased coverage to 90%, added performance tests

📦 Inherited 3 framework defaults:
- architecture-patterns.yaml
- security-guidelines.yaml
- review-checklist.yaml

Customization balance: Good (40% customized)
```

**Report file**: `.aknakos/products/{product-name}/reviews/standards/YYYY-MM-DD-standards-comparison.md`

**Related Skills**: create-standards (create customizations), validate-state (verify files exist)
