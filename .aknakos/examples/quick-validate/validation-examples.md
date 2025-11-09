# Quick Validation Examples

## Check 1: Mission Alignment Examples

### Example - PASS

```
Mission: "Simplify project management for small teams"
Epic: "Add task kanban board"
✓ Aligns: Core project management feature, simplifies workflow
```

### Example - FAIL

```
Mission: "Simplify project management for small teams"
Epic: "Add enterprise SSO with SAML integration"
✗ Misaligned: Enterprise feature, mission targets small teams
```

---

## Check 2: Tech Stack Compatibility Examples

### Example - PASS

```
Tech stack: SvelteKit + PostgreSQL + Better-Auth
Epic: "Add password reset via email"
✓ Compatible: Better-Auth supports password reset, have email service
```

### Example - CONCERNS

```
Tech stack: SvelteKit + PostgreSQL
Epic: "Real-time collaborative editing"
⚠ Concerns: Need WebSocket support; SvelteKit has it but untested
Recommendation: Verify WebSocket setup during planning
```

### Example - FAIL

```
Tech stack: SvelteKit + Better-Auth + Drizzle
Epic: "Add Firebase Authentication"
✗ Incompatible: Conflicts with Better-Auth; would need to replace
Recommendation: Use escalate-conflict to update tech-stack.md
```

---

## Check 3: Rough Complexity Examples

### Example - PASS

```
Epic: "Add password reset"
Acceptance criteria: 4 items
Complexity: 4
✓ Reasonable: Moderate complexity matches scope
```

### Example - CONCERNS

```
Epic: "Build analytics dashboard"
Acceptance criteria: 12 items
Complexity: 5
⚠ Concerns: Seems underestimated; 12 criteria suggests complexity 7-8
Recommendation: Increase complexity estimate or split Epic
```

### Example - FAIL

```
Epic: "Complete user management system"
Acceptance criteria: 25 items
Complexity: 6
✗ Too large: This is 3-4 Epics worth of work
Recommendation: Break into smaller Epics (auth, profiles, permissions, etc.)
```

---

## Full Scenario Examples

### Scenario 1: P0 Critical Bug (PASS)

```
User: "Production auth broken, users can't login"

Claude: [Using add-work skill]
Created Epic: fix-auth-login-bug
Priority: P0
Running quick-validate...

Quick Validation: PASS

✓ Mission alignment: User authentication is core product functionality
✓ Tech stack compatibility: Using Better-Auth, have tools to debug
✓ Rough complexity: 7 (reasonable for critical auth bug)

Epic ready for immediate work.
Entering planning mode...
```

---

### Scenario 2: P1 Feature Request (CONCERNS)

```
User: "Customer wants real-time notifications"

Claude: [Using add-work skill]
Created Epic: real-time-notifications
Priority: P1
Running quick-validate...

Quick Validation: PASS (with concerns)

✓ Mission alignment: Enhances user experience (mission goal)
⚠ Tech stack compatibility: Need WebSocket support
  Concern: SvelteKit supports WebSockets but we haven't used them yet
  Recommendation: Verify WebSocket setup during planning, may need server config
✓ Rough complexity: 6 (reasonable for real-time features)

Epic viable with noted concerns.

Proceed to planning mode? [y/n]
```

---

### Scenario 3: Misaligned Work (FAIL)

```
User: "Add enterprise SSO with SAML"

Claude: [Using add-work skill]
Created Epic: enterprise-sso-saml
Priority: P1
Running quick-validate...

Quick Validation: FAIL

✗ Mission alignment: Mission targets small teams, SAML is enterprise feature
  Mission states: "Simplify for small teams" (3-10 people)
  SAML/SSO: Enterprise feature (100+ users, IT requirements)
  Conflict: Out of scope for target market

✓ Tech stack compatibility: Better-Auth supports OAuth, but SAML would need plugin
✓ Rough complexity: 8 (realistic for SSO complexity)

Critical Issue: Epic contradicts mission scope

Recommendations:
A. Reject Epic: Not aligned with product vision
B. Pivot to simple OAuth: Google/GitHub login for small teams
C. Use escalate-conflict: Update mission if pivoting to enterprise market

Cannot proceed until mission alignment resolved.
```
