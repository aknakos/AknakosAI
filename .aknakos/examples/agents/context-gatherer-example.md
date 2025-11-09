# Context Gatherer - Example Usage

This example shows how the context-gatherer agent explores a codebase and returns a structured context map.

---

## Scenario: Mapping Authentication System

**Context**: User wants to understand the authentication system before adding OAuth social login feature.

---

### Conversation

**User**: Spawn context-gatherer agent to map the authentication system across frontend and backend

**Claude (main)**: Spawning context-gatherer agent to map authentication system...

[Agent explores codebase in separate context using Glob, Grep, Read tools]

### Agent Work (Behind the Scenes)

**Step 1: Find Auth-Related Files**
```bash
# Using Glob
**/*auth*.ts
**/*login*.tsx
**/*session*.ts
```

**Found**: 12 files across frontend/backend

**Step 2: Analyze Key Files**
- Read `src/services/auth.ts` (business logic)
- Read `src/api/auth/login.ts` (API endpoint)
- Read `src/middleware/auth-middleware.ts` (request validation)
- Read `src/components/LoginForm.tsx` (frontend UI)
- Read `src/types/user.ts` (data models)

**Step 3: Trace Data Flow**
- Login request → API route → Auth service → Database → JWT generation → Cookie storage → Frontend state

**Step 4: Identify Patterns**
- JWT tokens in httpOnly cookies
- Middleware-based auth checking
- Service layer pattern for business logic
- Shared TypeScript types between frontend/backend

**Step 5: Identify Gotchas**
- Token refresh not implemented (7-day expiration, no refresh mechanism)
- Session storage in-memory (resets on server restart)

**Step 6: Generate Context Map**

---

### Agent Returns

```markdown
# Context Map: Authentication System

**Mapped**: Authentication (login, registration, session management)
**Date**: 2025-11-09
**Agent**: context-gatherer
**Files Analyzed**: 12

## Executive Summary

The authentication system is a JWT-based implementation spanning frontend and backend. Users authenticate via email/password, receive JWT tokens stored in httpOnly cookies, and sessions are validated via middleware. The architecture follows a service layer pattern with clear separation of concerns.

Key components: Auth service (business logic), API routes (endpoints), middleware (request validation), and frontend login/register forms. Integration points include user management and payment systems which depend on authenticated user context.

Critical gap: No token refresh mechanism exists. Tokens expire after 7 days with no way to refresh without re-login.

## Architecture Overview

### Technology Stack

**Frontend**:
- Framework: React 18
- State Management: Redux Toolkit
- Styling: Tailwind CSS
- Build Tool: Vite

**Backend**:
- Language/Runtime: Node.js 20
- Framework: Express
- Database: PostgreSQL 15
- ORM: Prisma

**Auth Libraries**:
- jsonwebtoken (JWT generation/validation)
- bcrypt (password hashing, cost factor 12)
- cookie-parser (cookie handling)

### Directory Structure

```
src/
├── api/auth/
│   ├── login.ts          # POST /api/auth/login
│   ├── register.ts       # POST /api/auth/register
│   └── logout.ts         # POST /api/auth/logout
├── services/
│   └── auth.ts           # Auth business logic
├── middleware/
│   └── auth-middleware.ts # Session validation
├── components/
│   ├── LoginForm.tsx     # Login UI
│   └── RegisterForm.tsx  # Registration UI
├── types/
│   └── user.ts           # User type definitions
└── db/
    └── schema.prisma     # Database schema (users table)
```

## Domain Analysis

### Authentication

**Purpose**: Handle user identity verification, session management, and access control

**Key Files**:
- `src/services/auth.ts`: Core business logic (login, register, hashPassword, generateToken)
- `src/api/auth/login.ts`: Login endpoint handling
- `src/api/auth/register.ts`: Registration endpoint handling
- `src/middleware/auth-middleware.ts`: Request authentication validation
- `src/types/user.ts`: User interface and session types

**Patterns Used**:
- **Authentication**: JWT tokens with httpOnly cookies (XSS protection)
- **Session Management**: Stateless JWT validation (no session store)
- **Password Handling**: bcrypt hashing with cost factor 12

**Dependencies**:
- Internal: database client (Prisma), user types, email service (for verification)
- External: jsonwebtoken (JWT), bcrypt (hashing), cookie-parser (cookies)

**Integration Points**:
- **User Management**: Auth provides user context to profile/settings
- **Payments**: Auth validates user before payment operations
- **Admin Dashboard**: Auth checks for admin role in JWT claims

**Data Flow**:
```
User Login Request (email + password)
  → API Route (api/auth/login.ts)
  → Auth Service (services/auth.ts)
    → Validate credentials against database
    → Hash password and compare
  → Database Query (users table)
  → JWT Generation (userId + email + role)
  → Set httpOnly Cookie (7-day expiration)
  → Return User Data (id, email, role) to frontend
  → Frontend stores in Redux state
```

## Key Files Reference

| File Path | Purpose | Key Exports | Dependencies |
|-----------|---------|-------------|--------------|
| src/services/auth.ts | Auth business logic | login(), register(), hashPassword(), generateToken() | bcrypt, jsonwebtoken, prisma, email-service |
| src/api/auth/login.ts | Login endpoint | POST handler | auth.ts service |
| src/api/auth/register.ts | Registration endpoint | POST handler | auth.ts service |
| src/middleware/auth-middleware.ts | Auth middleware | validateSession(), requireAuth() | jsonwebtoken, prisma |
| src/types/user.ts | Type definitions | User, Session, AuthResponse | None (pure types) |

## Patterns & Conventions

### Code Organization

**Pattern**: Feature-based organization (auth files grouped together)
**Description**: All auth-related code in dedicated folders (api/auth/, services/auth.ts, etc.)
**Example**: src/api/auth/ contains all auth endpoints

### Naming Conventions

- Files: kebab-case (`auth-middleware.ts`)
- Components: PascalCase (`LoginForm.tsx`)
- Functions: camelCase (`generateToken()`)
- Constants: SCREAMING_SNAKE_CASE (`JWT_SECRET`)

### Architecture Patterns

**Pattern 1: Service Layer Pattern**
- **Where**: src/services/auth.ts
- **Purpose**: Separate business logic from API routes, enable reusability and testing
- **Example**: Login route calls `authService.login()` rather than inline logic

**Pattern 2: Middleware-based Auth**
- **Where**: src/middleware/auth-middleware.ts
- **Purpose**: Centralized auth checking for protected routes
- **Example**: Protected routes use `requireAuth()` middleware

### Testing Patterns

**Test Location**: `__tests__` folders co-located with source
**Test Framework**: Jest + Supertest (API testing)
**Coverage**: ~75% based on file analysis
**Patterns**:
- Unit tests: Mock database and external services
- Integration tests: Full request/response cycle testing with test database

## Integration Analysis

### Authentication ↔ User Management

**Integration Type**: Direct dependency (user management requires auth context)

**Flow**:
1. User authenticated via auth system
2. JWT contains userId
3. User management endpoints extract userId from JWT
4. Operations scoped to authenticated user

**Key Files**:
- Auth: src/middleware/auth-middleware.ts (provides user context)
- User Mgmt: src/api/users/*.ts (consumes user context)
- Shared: src/types/user.ts (User interface)

**Data Contracts**:
- Types: User interface (id, email, role)
- Validation: JWT signature verification

### Authentication ↔ Payments

**Integration Type**: Authorization checking (payments require authenticated user)

**Flow**:
1. Payment request includes auth cookie
2. Auth middleware validates JWT
3. Payment service receives userId from validated JWT
4. Payment associated with userId

**Key Files**:
- Auth: src/middleware/auth-middleware.ts
- Payments: src/api/payments/*.ts (protected by requireAuth middleware)

## Dependencies

### Internal Dependencies

```
auth → database (Prisma client)
auth → email-service (email verification)
user-management → auth (requires auth context)
payments → auth (requires auth context)
admin-dashboard → auth (requires admin role check)
```

**Coupling Analysis**:
- High coupling: auth ↔ database (tight dependency on Prisma schema)
- Low coupling: auth → email (interface-based, easily swappable)

### External Dependencies

**Critical Dependencies** (would break if removed):
- jsonwebtoken: JWT generation and validation (core auth mechanism)
- bcrypt: Password hashing (security requirement)
- cookie-parser: Cookie handling (session storage)

**Version Notes**:
- jsonwebtoken: v9.0.0 (latest stable)
- bcrypt: v5.1.0 (latest stable)
- All dependencies up-to-date, no known vulnerabilities

## Data Models

### Key Entities

**User**:
```typescript
interface User {
  id: string
  email: string
  passwordHash: string
  role: 'user' | 'admin'
  emailVerified: boolean
  createdAt: Date
  updatedAt: Date
}
```
**Location**: src/types/user.ts
**Usage**: Auth service, API routes, frontend Redux state

**Session** (JWT payload):
```typescript
interface Session {
  userId: string
  email: string
  role: 'user' | 'admin'
  iat: number  // issued at
  exp: number  // expiration
}
```
**Location**: src/types/user.ts
**Usage**: JWT generation, middleware validation

### Database Schema

**Tables**:
- `users`: User accounts (id, email, passwordHash, role, emailVerified, createdAt, updatedAt)
- `sessions`: NOT USED (stateless JWT, no session table)

**Relationships**:
- users → payments: one-to-many (userId foreign key in payments table)
- users → profiles: one-to-one (userId foreign key in profiles table)

## Entry Points

**Frontend**:
- Login: `src/components/LoginForm.tsx`
- Register: `src/components/RegisterForm.tsx`
- Routes: `src/pages/login.tsx`, `src/pages/register.tsx`

**Backend**:
- Login: `POST /api/auth/login`
- Register: `POST /api/auth/register`
- Logout: `POST /api/auth/logout`
- Middleware: Applied to all `/api/*` routes except auth endpoints

**Scripts**:
- Test: `bun run test` (runs Vitest via package.json)
- Dev: `bun run dev` (starts dev server)

## Gotchas & Considerations

**Known Issues**:
- **No Token Refresh**: Tokens expire after 7 days, user must re-login (no refresh token mechanism)
- **In-Memory Session Store**: If using session storage anywhere, resets on server restart (though current impl is stateless JWT)
- **Email Verification**: Required but no reminder system (users can register but not verify)

**Tech Debt Observed**:
- **Hard-coded JWT secret**: JWT_SECRET in env var but fallback to hard-coded value in code (security risk)
- **No rate limiting**: Login endpoint has no rate limiting (brute force vulnerability)
- **Password requirements**: No enforcement of strong passwords (UI shows hints but no backend validation)

**Complexity Hotspots**:
- `src/services/auth.ts`: 250 lines, handles multiple concerns (login, register, token generation, password validation)
- `src/middleware/auth-middleware.ts`: Complex error handling and token validation logic

## Recommendations

For working in this codebase:

**Before Adding Features**:
- Add token refresh mechanism (consider refresh tokens or sliding expiration)
- Implement rate limiting on auth endpoints (express-rate-limit)
- Enforce strong password requirements on backend (not just frontend)
- Move JWT secret to secure secret management (not env var fallback)

**Patterns to Follow**:
- Service layer pattern (keep business logic in services/)
- Middleware-based protection (use requireAuth() for protected routes)
- Shared types (define in types/ for frontend/backend consistency)

**Patterns to Avoid**:
- Don't add auth logic directly in API routes (use auth service)
- Don't store sensitive data in JWT payload (it's base64 encoded, not encrypted)
- Don't validate JWT on every request in route handlers (use middleware)

**Key Files to Understand**:
1. `src/services/auth.ts`: Core business logic (start here for auth changes)
2. `src/middleware/auth-middleware.ts`: Request validation (understand for protected routes)
3. `src/types/user.ts`: Data contracts (modify here for new user fields)

## Quick Reference

**Need to modify login flow?**
→ Start with: src/services/auth.ts (login function) and src/api/auth/login.ts

**Need to add new protected endpoint?**
→ Pattern: Import requireAuth middleware, apply to route

**Need to add fields to User model?**
→ Update: src/types/user.ts, src/db/schema.prisma, run migration

**Need to change token expiration?**
→ Update: JWT_EXPIRES_IN in src/services/auth.ts (generateToken function)

## Context Limitations

**What was NOT explored**:
- Email verification flow (referenced but not deeply analyzed)
- Password reset mechanism (files not found, may not exist)
- OAuth/social login (not implemented)

**Assumptions Made**:
- JWT secret is properly configured in production env
- Database migrations are run before app starts
- Frontend and backend are deployed together (shared types)

**Confidence Level**: High - comprehensive exploration of auth system, clear patterns identified, critical gaps documented
```

---

### Claude Returns to Main Conversation

**Claude (main)**: Context mapping complete!

**Key Findings**:
- Auth system spans 12 files across frontend/backend
- Uses JWT tokens stored in httpOnly cookies (7-day expiration)
- Password hashing with bcrypt (cost factor 12)
- Integration points: auth ↔ user-management, auth ↔ payments

**Patterns**:
- Middleware-based auth checking (src/middleware/auth-middleware.ts)
- Service layer pattern for business logic
- Shared TypeScript types between frontend/backend

**Gotchas**:
- **Token refresh not implemented** (tokens expire in 7 days, no refresh mechanism) ⚠️
- **No rate limiting** on login endpoint (brute force vulnerability) ⚠️
- **Session storage is in-memory** (resets on server restart - though current impl is stateless JWT)

**Recommendations for OAuth Addition**:
- Add OAuth providers in `src/services/auth.ts` (follow existing service pattern)
- Create new endpoints in `src/api/auth/oauth/` (keep auth routes grouped)
- Extend User model with `oauthProvider` and `oauthId` fields
- Reuse existing JWT generation (same token format for OAuth users)

Full context map saved. Ready for planning mode?

**User**: Yes, let's plan the OAuth feature

[Conversation continues with well-informed planning mode session...]

---

## Outcome

**Context gathered**: Comprehensive 12-file authentication system mapped
**Time**: ~5 min agent exploration
**Value**: User avoided common pitfalls (didn't duplicate JWT logic, understood integration points, identified missing token refresh as related issue)
**Next step**: Planning mode with full auth context available
