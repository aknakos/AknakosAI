# Context Fetcher - Example Usage

This example shows how the context-fetcher agent selectively extracts relevant sections from large strategic documents.

---

## Example 1: Auth Epic Context Extraction

**Context**: User needs to plan the "User Authentication System" Epic. PRD is 25 pages, architecture.md is 18 pages. Loading full documents would consume ~20,000 tokens.

---

### Request

```
Spawn context-fetcher agent:
Extract user authentication context for Epic "User Authentication System"

Documents to search:
- .aknakos/products/saas-platform/2025-11-01-prd.md
- .aknakos/products/saas-platform/2025-11-01-architecture.md
- .aknakos/products/saas-platform/2025-11-01-project-brief.md

Extract sections related to:
- User authentication and authorization
- Security requirements and patterns
- OAuth 2.0 implementation details
- Session management
```

---

### Agent Work (Behind the Scenes)

**Step 1: Load Documents**
```bash
# Agent loads specified files
@.aknakos/products/saas-platform/2025-11-01-prd.md
@.aknakos/products/saas-platform/2025-11-01-architecture.md
@.aknakos/products/saas-platform/2025-11-01-project-brief.md
```

**Step 2: Search for Keywords**
- "auth", "authentication", "OAuth", "session", "login", "password", "security"
- Found in prd.md: Lines 45-120 (Functional Requirements - User Authentication)
- Found in architecture.md: Lines 200-285 (Security Architecture)
- Found in project-brief.md: Lines 88-105 (User Personas - Security Needs)

**Step 3: Extract Relevant Content**
- Copy exact requirement text (REQ-AUTH-001, REQ-AUTH-002, REQ-SEC-001)
- Copy architecture decisions with rationale
- Copy user persona security needs
- Note source locations

**Step 4: Generate Focused Summary**

---

### Agent Returns

```markdown
# Context Summary: User Authentication System

**Generated**: 2025-11-09
**Documents Searched**: prd.md, architecture.md, project-brief.md
**Epic/Story**: User Authentication System (Epic planning)

---

## Requirements

### From PRD

**[prd.md: Functional Requirements - User Authentication, Lines 45-120]**

**REQ-AUTH-001**: The system SHALL provide OAuth 2.0 authentication.

**Scenarios**:
- Given a user visits the login page
- When they click "Login with Google"
- Then the system SHALL redirect to Google OAuth consent screen
- And SHALL receive authorization code upon user consent
- And SHALL exchange code for access token
- And SHALL create user session

**Priority**: MUST

---

**REQ-AUTH-002**: The system SHALL support email/password authentication.

**Scenarios**:
- Given a user provides valid email and password
- When they submit the login form
- Then the system SHALL verify credentials
- And SHALL create authenticated session

**Priority**: SHOULD

---

**REQ-AUTH-003**: The system MAY support GitHub and Facebook OAuth providers.

**Priority**: MAY (Post-MVP)

---

**Non-Functional Requirements**:

**REQ-SEC-001**: The system SHALL encrypt all passwords using bcrypt with minimum cost factor 12.

**REQ-PERF-002**: Authentication requests SHALL complete within 200ms (95th percentile).

---

## Architecture Decisions

### From architecture.md

**[architecture.md: Security Architecture, Lines 200-285]**

**Authentication Flow**:

1. User initiates login (OAuth or email/password)
2. System validates credentials or redirects to OAuth provider
3. Upon successful auth, generate JWT tokens (access + refresh)
4. Store tokens in HttpOnly cookies (XSS protection)
5. Middleware validates JWT on subsequent requests

**Technology Choice**: OAuth 2.0 via Passport.js + JWT

**Rationale**:
- Passport.js: Battle-tested, extensive provider support, middleware-based
- JWT: Stateless auth, horizontal scaling friendly, mobile app ready
- Refresh tokens: Balance security (short-lived access) with UX (long-lived refresh)

**Providers Supported**:
- Google OAuth 2.0 (required - REQ-AUTH-001)
- Email/password (required - REQ-AUTH-002)
- GitHub, Facebook (optional - REQ-AUTH-003)

**Session Management**:
- **Access Token**: 15 min expiration (JWT)
- **Refresh Token**: 7 day expiration (JWT, stored in DB for revocation)
- **Storage**: HttpOnly cookies (not localStorage - XSS protection)
- **Refresh Flow**: When access expires, use refresh token to obtain new access token

**Database Schema**:

```sql
users (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255),  -- NULL for OAuth-only users
  oauth_provider VARCHAR(50),  -- 'google', 'github', 'facebook'
  oauth_id VARCHAR(255),       -- Provider's user ID
  email_verified BOOLEAN DEFAULT false,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
)

refresh_tokens (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  token_hash VARCHAR(255),     -- Hashed refresh token
  expires_at TIMESTAMP,
  revoked BOOLEAN DEFAULT false,
  created_at TIMESTAMP
)
```

**Security Measures**:
- Passwords hashed with bcrypt (cost 12)
- Refresh tokens hashed before storage
- CSRF protection via SameSite cookies
- Rate limiting: 5 failed attempts → 15 min lockout
- CORS: Strict origin checking

**Alternatives Considered**:
- **Session-based auth**: Rejected (requires session store, not horizontally scalable without Redis)
- **Auth0 third-party**: Rejected (cost at scale, vendor lock-in)
- **Magic links only**: Rejected (users expect social login per personas)

---

## User Context

### From project-brief.md

**[project-brief.md: User Personas - Security & Auth Needs, Lines 88-105]**

**Primary User: Active Professionals (25-45)**
- **Authentication Preference**: Quick social login (Google) - don't want to remember another password
- **Security Concern**: Data privacy important, trust established platforms (Google)
- **Pain Point**: Tired of password fatigue (30+ accounts)

**Secondary User: Gen Z (18-30)**
- **Authentication Preference**: Expect social login as default (standard in modern apps)
- **Security Concern**: Less concerned about data privacy, prioritize convenience
- **Pain Point**: Email verification flows feel outdated

**Insight**: Both personas prefer OAuth social login over email/password. Email/password should be fallback option, not primary flow.

---

## Key Constraints

### From architecture.md

- **Integration**: Must integrate with existing Auth0 tenant for admin accounts (separate from user OAuth)
- **Session Storage**: Redis for distributed session invalidation (logout all devices)
- **CORS Policy**: Strict origin checking (only allow app domain)
- **Compliance**: OWASP Top 10 compliance required (security audit before launch)

### From PRD

- **Performance**: Auth requests SHALL complete within 200ms (REQ-PERF-002)
- **Security**: Passwords SHALL use bcrypt cost ≥12 (REQ-SEC-001)
- **Availability**: Auth service SHALL have 99.9% uptime (REQ-AVAIL-001)

---

## Dependencies

**External**:
- Auth0 tenant setup (for admin accounts - mentioned in architecture.md)
- Redis instance (for session invalidation and rate limiting)
- Email service (SendGrid or similar - for email verification and password reset)
- OAuth provider apps (Google OAuth client ID + secret, GitHub app, Facebook app)

**Internal**:
- User profile management (separate Epic - depends on auth context)
- Role-based access control (future Epic - requires user roles in JWT claims)
- Audit logging (separate Epic - logs all auth events)

**Order of Implementation**:
1. Auth system (this Epic) - foundational
2. User profile management - depends on auth
3. RBAC - depends on auth + profiles
4. Audit logging - parallel to auth

---

## References

**Full Documents** (if needed for deeper context):
- .aknakos/products/saas-platform/2025-11-01-prd.md
- .aknakos/products/saas-platform/2025-11-01-architecture.md
- .aknakos/products/saas-platform/2025-11-01-project-brief.md

**Specific Sections Extracted**:
- **prd.md**: Lines 45-120 (User Authentication Requirements)
- **architecture.md**: Lines 200-285 (Security Architecture)
- **project-brief.md**: Lines 88-105 (User Personas - Security Needs)

**Related Requirements** (not extracted but exist in PRD):
- REQ-AUDIT-001: Log all authentication events (in Audit Logging section)
- REQ-PRIVACY-001: GDPR compliance for user data (in Data Privacy section)
```

---

### Claude Returns to Main Conversation

**Claude (main)**: Context extraction complete!

**Summary**:
- **Requirements**: 3 functional (2 MUST, 1 SHOULD), 3 non-functional (performance, security, availability)
- **Architecture**: OAuth 2.0 via Passport.js + JWT tokens (15min access / 7day refresh) stored in HttpOnly cookies
- **Providers**: Google (required), Email/password (required), GitHub/Facebook (optional)
- **Schema**: Users table + Refresh tokens table
- **User Insight**: Both personas prefer social login (Google) - make it primary, email/password fallback

**Key Decisions**:
- Chose Passport.js + JWT over Auth0 (cost) or sessions (scalability)
- Short access token (15min) + refresh token (7day) balances security and UX
- HttpOnly cookies for XSS protection

**Dependencies**: Redis (session invalidation), email service (verification), OAuth apps (Google/GitHub/Facebook)

**Next Step**: Ready to create Stories and Tasks for auth Epic?

**Tokens Saved**: ~18,000 tokens (loaded full docs in agent context, returned 2,000 token summary)

---

## Example 2: Database Schema Context Extraction

**Context**: User needs to implement the "Data Layer" Epic. architecture.md has extensive database design (300 lines), but only need schema and patterns.

---

### Request

```
Spawn context-fetcher agent:
Extract database schema and data model context for Epic "Data Layer Implementation"

Documents:
- .aknakos/products/saas-platform/2025-11-01-architecture.md
- .aknakos/products/saas-platform/tech-stack.md
```

---

### Agent Returns

```markdown
# Context Summary: Data Layer Implementation

**Generated**: 2025-11-09
**Documents Searched**: architecture.md, tech-stack.md
**Epic/Story**: Data Layer Implementation

---

## Database Choice

### From tech-stack.md

**Database**: PostgreSQL 15

**Rationale**:
- ACID guarantees (critical for transactional integrity)
- Complex queries with JOIN support (relational data model)
- JSON support for flexible fields
- Mature ecosystem (Prisma ORM support)

**Alternatives Considered**:
- **MongoDB**: Rejected - need strong consistency and complex relational queries
- **MySQL**: Rejected - PostgreSQL has better JSON support and advanced features
- **CockroachDB**: Deferred - not needed at current scale, can migrate later if geo-distribution required

---

## Schema

### From architecture.md

**[architecture.md: Data Architecture - Database Schema, Lines 340-420]**

**Users Table**:
```sql
users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255),
  oauth_provider VARCHAR(50),
  oauth_id VARCHAR(255),
  email_verified BOOLEAN DEFAULT false,
  role VARCHAR(50) DEFAULT 'user',  -- 'user', 'admin'
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP  -- Soft delete
)
```

**Posts Table**:
```sql
posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(500) NOT NULL,
  content TEXT,
  status VARCHAR(50) DEFAULT 'draft',  -- 'draft', 'published', 'archived'
  published_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP  -- Soft delete
)
```

**Comments Table**:
```sql
comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP  -- Soft delete
)
```

**Indexes**:
```sql
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_status ON posts(status);
CREATE INDEX idx_posts_published_at ON posts(published_at DESC);
CREATE INDEX idx_comments_post_id ON comments(post_id);
CREATE INDEX idx_comments_user_id ON comments(user_id);
```

---

## Constraints

### From PRD (referenced in architecture.md)

- **Query Performance**: <50ms for 95th percentile reads (REQ-PERF-003)
- **Data Retention**: 2 year minimum for audit trail (REQ-DATA-002)
- **Backup**: Daily automated backups with 30-day retention (REQ-BACKUP-001)
- **Migration**: Zero-downtime migrations required (REQ-DEPLOY-002)

---

## Patterns

### From architecture.md

**[architecture.md: Data Patterns, Lines 450-490]**

**UUID for IDs**:
- Use UUID v4 for all primary keys (distributed system ready, no auto-increment conflicts)
- Generated via `gen_random_uuid()` (PostgreSQL built-in)

**Timestamps**:
- All tables have `created_at`, `updated_at` (trackable)
- Use `DEFAULT NOW()` for auto-population
- Update `updated_at` via trigger:
  ```sql
  CREATE TRIGGER update_updated_at
  BEFORE UPDATE ON {table}
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
  ```

**Soft Deletes**:
- `deleted_at TIMESTAMP` column on all entities (recover data if needed)
- Application layer filters `WHERE deleted_at IS NULL`
- Cleanup job runs monthly to purge old soft-deleted records

**Foreign Keys**:
- Always use explicit foreign key constraints
- `ON DELETE CASCADE` for ownership (user deletes → posts delete)
- `ON DELETE SET NULL` for references (user deletes → comments preserved but author nulled)

**Migrations**:
- Use Prisma Migrate (TypeScript-based, version controlled)
- Never modify existing migrations (create new migration instead)
- Test migrations on staging before production
- Backward compatible migrations only (add columns with defaults, don't drop)

---

## ORM Configuration

### From architecture.md

**ORM**: Prisma (TypeScript-first)

**Rationale**:
- Type-safe queries (compile-time checking)
- Auto-generated types from schema
- Migration management built-in
- Query performance (optimized SQL generation)

**Prisma Schema Location**: `src/db/schema.prisma`

**Connection Pooling**:
- Max connections: 10 (per instance)
- Connection timeout: 5s
- Pool timeout: 10s

---

## Data Access Patterns

### From architecture.md

**Repository Pattern**:
```
Controller → Service → Repository → Prisma → Database
```

**Example**:
```typescript
// Repository layer
class PostRepository {
  async findById(id: string): Promise<Post | null> {
    return prisma.post.findUnique({ where: { id, deleted_at: null } })
  }

  async create(data: CreatePostInput): Promise<Post> {
    return prisma.post.create({ data })
  }
}
```

**Query Optimization**:
- Use `select` to load only needed fields
- Use `include` for eager loading (avoid N+1 queries)
- Paginate all list queries (default page size: 20)

---

## References

**Full Documents**:
- .aknakos/products/saas-platform/2025-11-01-architecture.md (Lines 340-490 for database)
- .aknakos/products/saas-platform/tech-stack.md

**Next Steps**:
1. Create Prisma schema file (src/db/schema.prisma)
2. Run initial migration (creates tables)
3. Generate Prisma client (type-safe queries)
4. Implement repository layer (data access abstraction)
5. Add seed data for development
```

---

### Outcome

**Token Savings**:
- **Without agent**: Load full architecture.md (~12,000 tokens) + tech-stack.md (~800 tokens) = ~12,800 tokens
- **With agent**: Focused summary (~1,500 tokens)
- **Savings**: ~11,300 tokens (88% reduction)

**Value**:
- Exact schema extracted (copy-paste ready)
- Patterns identified (UUID, timestamps, soft deletes, repository)
- Constraints documented (performance, retention, backup)
- Clear next steps for implementation

**Time**: ~2 min agent execution
