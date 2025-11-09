# Context Map: {Codebase Area}

**Mapped**: {Specific area/domain}
**Date**: {YYYY-MM-DD}
**Agent**: context-gatherer
**Files Analyzed**: {approximate count}

## Executive Summary

{2-3 paragraph high-level summary of what you found}

## Architecture Overview

### Technology Stack

**Frontend**:
- Framework: {e.g., React 18}
- State Management: {e.g., Redux Toolkit}
- Styling: {e.g., Tailwind CSS}
- Build Tool: {e.g., Vite}

**Backend**:
- Language/Runtime: {e.g., Node.js 20}
- Framework: {e.g., Express}
- Database: {e.g., PostgreSQL 15}
- ORM: {e.g., Prisma}

**Infrastructure**:
- Hosting: {e.g., AWS}
- CI/CD: {e.g., GitHub Actions}
- Monitoring: {e.g., Sentry}

### Directory Structure

```
src/
├── components/        # React components
├── pages/             # Next.js pages
├── api/               # API routes
├── lib/               # Shared utilities
├── types/             # TypeScript types
├── services/          # Business logic
└── db/                # Database client and schema
```

**Key Organizational Patterns**:
- {Pattern 1}: {Description}
- {Pattern 2}: {Description}

## Domain Analysis

### {Domain Name} (e.g., Authentication)

**Purpose**: {What this domain handles}

**Key Files**:
- `src/services/auth.ts`: {File purpose}
- `src/api/auth/login.ts`: {File purpose}
- `src/middleware/auth-middleware.ts`: {File purpose}
- `src/types/user.ts`: {File purpose}

**Patterns Used**:
- Authentication: {Pattern description}
- Session Management: {Pattern description}
- Password Handling: {Pattern description}

**Dependencies**:
- Internal: {List of internal modules this depends on}
- External: {Libraries used: bcrypt, jsonwebtoken, etc.}

**Integration Points**:
- {Domain X}: {How they integrate}
- {Domain Y}: {How they integrate}

**Data Flow**:
```
User Login Request
  → API Route (api/auth/login.ts)
  → Auth Service (services/auth.ts)
  → Database (users table)
  → JWT Generation
  → Set Cookie
  → Return User Data
```

### {Another Domain} (if mapping multiple)

[Same structure as above]

## Key Files Reference

| File Path | Purpose | Key Exports | Dependencies |
|-----------|---------|-------------|--------------|
| src/services/auth.ts | Auth business logic | login(), register() | bcrypt, db, jwt |
| src/api/auth/login.ts | Login endpoint | POST handler | auth service |
| src/middleware/auth.ts | Auth middleware | validateSession() | jwt, db |

## Patterns & Conventions

### Code Organization

**Pattern**: {e.g., Feature-based organization}
**Description**: {How code is organized}
**Example**: {File path example}

### Naming Conventions

- Files: {e.g., kebab-case for files}
- Components: {e.g., PascalCase for React components}
- Functions: {e.g., camelCase for functions}
- Constants: {e.g., SCREAMING_SNAKE_CASE}

### Architecture Patterns

**Pattern 1**: {e.g., Repository Pattern}
- **Where**: {Which layer/files}
- **Purpose**: {Why used}
- **Example**: {Code location}

**Pattern 2**: {e.g., Dependency Injection}
- **Where**: {Which layer/files}
- **Purpose**: {Why used}
- **Example**: {Code location}

### Testing Patterns

**Test Location**: {e.g., __tests__ folders or *.test.ts co-located}
**Test Framework**: {e.g., Jest + React Testing Library}
**Coverage**: {e.g., ~80% based on file analysis}
**Patterns**:
- Unit tests: {Pattern description}
- Integration tests: {Pattern description}

## Integration Analysis

### {System A} ↔ {System B}

**Integration Type**: {e.g., REST API, Event-driven, Shared database}

**Flow**:
1. {Step 1 of integration}
2. {Step 2 of integration}
3. {Step 3 of integration}

**Key Files**:
- System A: {file paths}
- System B: {file paths}
- Shared: {shared files or contracts}

**Data Contracts**:
- Types: {TypeScript interfaces or schemas}
- Validation: {How validated}

## Dependencies

### Internal Dependencies

```
auth → database
auth → email-service
dashboard → auth
payments → auth
```

**Coupling Analysis**:
- High coupling: {Where and why}
- Low coupling: {Where and why}

### External Dependencies

**Critical Dependencies** (would break if removed):
- {package name}: {Used for what}
- {package name}: {Used for what}

**Version Notes**:
- {Any outdated or deprecated dependencies}
- {Any version conflicts}

## Data Models

### Key Entities

**User**:
```typescript
interface User {
  id: string
  email: string
  passwordHash: string
  createdAt: Date
  // ... other fields
}
```
**Location**: {Where defined}
**Usage**: {Where used}

**{Other Entity}**:
[Same structure]

### Database Schema

**Tables**:
- `users`: {Purpose and key columns}
- `sessions`: {Purpose and key columns}
- `{other table}`: {Purpose and key columns}

**Relationships**:
- {Table A} → {Table B}: {Relationship type and foreign key}

## Entry Points

**Frontend**:
- Main: `src/pages/_app.tsx`
- Routes: `src/pages/**/*.tsx`

**Backend**:
- Main: `src/server.ts`
- Routes: `src/api/**/*.ts`

**Scripts**:
- Build: `npm run build`
- Test: `npm test`
- Dev: `npm run dev`

## Gotchas & Considerations

**Known Issues**:
- {Issue 1}: {Description and where it occurs}
- {Issue 2}: {Description and where it occurs}

**Tech Debt Observed**:
- {Debt item 1}: {Description and impact}
- {Debt item 2}: {Description and impact}

**Complexity Hotspots**:
- {File/area 1}: {Why complex}
- {File/area 2}: {Why complex}

## Recommendations

For working in this codebase:

**Before Adding Features**:
- {Recommendation 1}
- {Recommendation 2}

**Patterns to Follow**:
- {Pattern 1 to adopt}
- {Pattern 2 to adopt}

**Patterns to Avoid**:
- {Anti-pattern 1 to avoid}
- {Anti-pattern 2 to avoid}

**Key Files to Understand**:
1. {File 1}: {Why it's important}
2. {File 2}: {Why it's important}
3. {File 3}: {Why it's important}

## Quick Reference

**Need to modify authentication?**
→ Start with: src/services/auth.ts and src/api/auth/

**Need to add new API endpoint?**
→ Pattern: src/api/{domain}/{action}.ts

**Need to add database table?**
→ Schema: src/db/schema.prisma, then migration

**Need to add new component?**
→ Pattern: src/components/{domain}/{ComponentName}.tsx

## Context Limitations

**What was NOT explored**:
- {Area not covered}
- {Area not covered}

**Assumptions Made**:
- {Assumption 1}
- {Assumption 2}

**Confidence Level**: {High/Medium/Low and why}
