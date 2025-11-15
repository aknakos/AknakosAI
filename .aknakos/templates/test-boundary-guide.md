# Test Boundary Decision Guide

**Quick Reference**: When planning tests, use this guide to determine which test type to write.

---

## The Testing Pyramid

```
        /\
       /  \  E2E (5-10%)
      /____\  Happy paths only, 5-10 tests max
     /      \
    / INTEG  \ Integration (15-20%)
   /__________\ APIs, components, error scenarios
  /            \
 /     UNIT     \ Unit (70-80%)
/________________\ Edge cases, pure logic, comprehensive
```

**Philosophy**: Write lots of small fast tests, fewer slow tests.

---

## Decision Tree: "Which Test Type Should I Write?"

### Is it pure logic without external dependencies?
**YES** → Write **UNIT TEST**
- Examples: validation functions, calculations, data transformations
- Mock all dependencies
- Test ALL edge cases here

**NO** → Continue...

### Does it involve user interaction, API calls, or database?
**YES** → Write **INTEGRATION TEST**
- Examples: component clicks, API endpoints, database operations
- Test error scenarios here
- Test with real/stubbed dependencies

**NO** → Continue...

### Is it a critical end-to-end user journey (happy path)?
**YES** → Consider **E2E TEST** (if you have <10 E2E tests already)
- Examples: registration → verification → login → dashboard
- ONLY happy paths
- ONLY critical flows
- Keep under 10 total E2E tests

**NO** → Probably doesn't need E2E test

---

## Quick Reference Table

| Scenario | Test Type | Why |
|----------|-----------|-----|
| Validate email format with edge cases | Unit | Pure logic, no dependencies |
| Empty email input | Unit | Edge case of validation logic |
| Login button click shows loading state | Integration | Component interaction |
| Login API with wrong password | Integration | API error scenario |
| Database unique constraint violation | Integration | Database operation error |
| User registers → verifies → logs in → dashboard | E2E | Critical happy path workflow |
| User registers with duplicate email | Integration | Error scenario, NOT E2E |
| Calculate discount with negative price | Unit | Edge case of business logic |
| Form submission with network timeout | Integration | Error scenario |
| Password strength validation | Unit | Pure validation logic |
| User completes checkout successfully | E2E | Critical happy path (if <10 E2E tests) |

---

## Common Scenarios by Feature

### Authentication Feature

**Unit Tests** (10-15 tests):
- ✅ Email validation (valid, invalid, empty, malformed)
- ✅ Password strength (too short, no special chars, too long)
- ✅ Token generation logic
- ✅ Token expiration calculation

**Integration Tests** (5-8 tests):
- ✅ Login with wrong password → error message
- ✅ Login with unverified email → error message
- ✅ Registration with duplicate email → error
- ✅ Password reset with invalid token → error
- ✅ Login rate limiting enforcement
- ✅ Session creation and storage

**E2E Tests** (1-2 tests):
- ✅ User registers → verifies email → logs in → sees dashboard
- ✅ (Optional) User resets password → receives email → sets new password → logs in

### E-Commerce Checkout Feature

**Unit Tests** (15+ tests):
- ✅ Price calculation (discount, tax, edge cases)
- ✅ Inventory validation (out of stock, negative quantity)
- ✅ Coupon code validation
- ✅ Address format validation

**Integration Tests** (8-12 tests):
- ✅ Add to cart button updates cart count
- ✅ Remove item from cart
- ✅ Apply invalid coupon → error message
- ✅ Payment API fails → show error
- ✅ Insufficient inventory → prevent checkout
- ✅ Database transaction rollback on payment failure

**E2E Tests** (1 test):
- ✅ User adds item → proceeds to checkout → enters shipping → completes payment → sees confirmation

### CRUD Feature (e.g., Blog Posts)

**Unit Tests** (8-12 tests):
- ✅ Title validation (empty, too long, special chars)
- ✅ Content sanitization
- ✅ Slug generation from title
- ✅ Date formatting

**Integration Tests** (6-10 tests):
- ✅ Create post API → saves to database
- ✅ Create post with duplicate title → error
- ✅ Update post with invalid ID → 404
- ✅ Delete post → removes from database
- ✅ List posts with pagination
- ✅ Unauthorized user tries to delete → 401

**E2E Tests** (0-1 tests):
- ✅ (Optional) User creates post → publishes → views on site (only if critical to business)
- OR skip E2E if not a critical flow (CRUD is well-covered by integration tests)

---

## Anti-Patterns (What NOT to Do)

### ❌ Testing Edge Cases in E2E
**Bad**:
```javascript
// E2E test
test('user registers with invalid email shows error', async () => {
  // Testing validation in E2E - TOO SLOW
})
```

**Good**:
```javascript
// Unit test
test('validateEmail rejects invalid format', () => {
  expect(validateEmail('notanemail')).toBe(false)
})

// Integration test (if needed for UI)
test('registration form shows error for invalid email', () => {
  render(RegistrationForm)
  fireEvent.input(emailField, 'notanemail')
  expect(screen.getByText('Invalid email')).toBeInTheDocument()
})
```

### ❌ Testing Error Scenarios in E2E
**Bad**:
```javascript
// E2E test
test('user login fails with wrong password', async () => {
  // Error scenario in E2E - WASTE OF TIME
})
```

**Good**:
```javascript
// Integration test
test('login API returns 401 for wrong password', async () => {
  const response = await login('user@test.com', 'wrongpass')
  expect(response.status).toBe(401)
  expect(response.body.error).toBe('Invalid credentials')
})
```

### ❌ Writing E2E for Every Feature
**Bad**:
- E2E for user profile update
- E2E for settings change
- E2E for logout
- E2E for search
- E2E for filters
- E2E for pagination
- **Total: 20+ E2E tests** (TOO MANY, TOO SLOW)

**Good**:
- E2E for registration → login → dashboard (critical)
- E2E for checkout → payment → confirmation (critical)
- E2E for core workflow (critical to business)
- **Total: 3-5 E2E tests** (fast, maintainable)
- Everything else: Integration tests

### ❌ Testing Implementation Details
**Bad**:
```javascript
// Unit test testing React/Svelte internals
test('component sets state correctly', () => {
  const component = new MyComponent()
  component.handleClick()
  expect(component.state.clicked).toBe(true)  // Testing internal state
})
```

**Good**:
```javascript
// Integration test testing behavior
test('clicking button shows success message', () => {
  render(MyComponent)
  fireEvent.click(screen.getByRole('button'))
  expect(screen.getByText('Success!')).toBeInTheDocument()
})
```

---

## E2E Test Budget: Maximum 10 Tests

**Use your E2E tests wisely!** You only get 5-10 per application.

### Priority Ranking for E2E Tests

**P0 - Must Have** (3-5 tests):
1. Authentication flow (register/login)
2. Core business transaction (purchase, booking, order)
3. Critical user journey (onboarding, main workflow)

**P1 - Nice to Have** (2-3 tests):
4. Secondary important flow (password reset)
5. High-value feature (search → results → detail)

**P2 - Skip** (cover with integration tests instead):
- Settings updates
- Profile edits
- Logout
- Admin panels
- Filters and sorting
- Pagination
- Non-critical features

---

## When You're Unsure

**Ask yourself**:

1. **"Is this testing pure logic?"**
   - YES → Unit test
   - NO → Continue...

2. **"Does this involve external dependencies (API, DB, component)?"**
   - YES → Integration test
   - NO → Continue...

3. **"Is this a complete user journey from start to finish?"**
   - YES → Continue...
   - NO → Integration test

4. **"Is this journey one of the top 3-5 most critical workflows in the entire application?"**
   - YES → E2E test (if under 10 total E2E tests)
   - NO → Integration test is enough

5. **"Am I testing the happy path or an error scenario?"**
   - Happy path → Could be E2E
   - Error scenario → Integration test, NOT E2E

---

## Summary: The Golden Rules

1. **70-80% Unit Tests**: Fast, comprehensive, all edge cases
2. **15-20% Integration Tests**: Component interactions, APIs, errors
3. **5-10% E2E Tests**: Critical happy paths only, 5-10 tests max
4. **Edge cases → Unit tests** (not E2E)
5. **Error scenarios → Integration tests** (not E2E)
6. **Happy paths → E2E tests** (only top 3-5 critical flows)
7. **When in doubt → Integration test** (safest middle ground)

**Remember**: E2E tests are expensive. Treat them like a limited resource.
