# UX Flow: {Product Name}

**Date**: {YYYY-MM-DD}
**Created By**: {User/Agent}
**Product**: {product-name}
**Complexity**: {1-9}

---

## Overview

**Purpose**: {1-2 sentence description of what this UX flow covers}

**Scope**: {What user-facing features this covers}

**Target Users**: {Primary user personas/roles}

---

## User Flows

### Flow 1: {Primary User Journey}

**Goal**: {What user wants to accomplish}

**Steps**:
1. {Entry point} → {Action} → {Result}
2. {Next action} → {Result}
3. {Final state/outcome}

**Edge Cases**:
- {Error scenario}: {How handled}
- {Alternative path}: {How handled}

**Success Criteria**:
- ✅ {Measurable outcome 1}
- ✅ {Measurable outcome 2}

### Flow 2: {Secondary User Journey}

{Repeat structure above}

---

## Interface Structure

### Page Hierarchy

```
/ (Home)
├── /auth/
│   ├── /login
│   ├── /register
│   └── /verify-email
├── /dashboard
│   ├── /settings
│   └── /profile
└── /feature-name/
    ├── /feature-detail
    └── /feature-action
```

### Navigation Patterns

**Primary Navigation**: {Top nav, sidebar, tabs}
- {Nav item 1}: Links to {destination}
- {Nav item 2}: Links to {destination}

**Secondary Navigation**: {Breadcrumbs, in-page nav}
- {Pattern description}

**Mobile Navigation**: {Hamburger menu, bottom nav}
- {Mobile-specific patterns}

---

## Interaction Patterns

### Forms

**Pattern**: {Multi-step wizard, single page, inline editing}

**Validation**: {Real-time, on-submit, inline}

**Error Handling**:
- Field errors: {Inline below field}
- Form errors: {Summary at top}
- Recovery: {Auto-save, clear guidance}

### Data Display

**Lists**: {Table, cards, infinite scroll, pagination}

**Filtering**: {Sidebar filters, top bar, inline}

**Sorting**: {Column headers, dropdown, default sort}

**Empty States**: {Helpful message + CTA}

### Feedback

**Loading States**: {Skeleton, spinner, progress bar}

**Success Messages**: {Toast, banner, inline}

**Error Messages**: {Toast, modal, inline}

**Confirmations**: {Modal, inline, none (if undo available)}

---

## UX Principles

### Core Principles

1. **{Principle 1}**: {Description}
   - Example: {How applied}

2. **{Principle 2}**: {Description}
   - Example: {How applied}

3. **{Principle 3}**: {Description}
   - Example: {How applied}

### Design Philosophy

**{Philosophy aspect}**: {Description}

**Performance**: {Target load times, perceived performance strategies}

**Responsiveness**: {Mobile-first, desktop-first, breakpoints}

---

## Component Library

### Core Components

**Buttons**:
- Primary: {Style, usage}
- Secondary: {Style, usage}
- Destructive: {Style, usage}

**Forms**:
- Input: {Style, validation}
- Select: {Style, options}
- Checkbox/Radio: {Style, usage}

**Feedback**:
- Toast: {Position, duration}
- Modal: {Size variants, dismissal}
- Banner: {Types, placement}

**Navigation**:
- Navbar: {Structure, responsive behavior}
- Tabs: {Style, active state}
- Breadcrumbs: {Format, behavior}

### Reusable Patterns

**{Pattern Name}**: {Description, when to use}

**{Pattern Name}**: {Description, when to use}

---

## Accessibility Considerations

### WCAG Compliance

**Target Level**: {A, AA, AAA}

**Key Requirements**:
- ✅ Keyboard navigation: {Tab order, shortcuts}
- ✅ Screen reader support: {ARIA labels, semantic HTML}
- ✅ Color contrast: {Minimum ratios, tools used}
- ✅ Focus indicators: {Visible, clear}

### Inclusive Design

**Forms**: {Label association, error announcements}

**Interactive Elements**: {Touch targets 44px min, click targets 24px min}

**Media**: {Alt text, captions, transcripts}

**Motion**: {Respect prefers-reduced-motion}

---

## Design System References

**Framework**: {Tailwind CSS, custom, component library}

**Color Palette**: {Link or inline definition}

**Typography**: {Font families, scale, weights}

**Spacing**: {Grid system, spacing scale}

**Icons**: {Icon library used}

**External References**:
- {Design system URL if applicable}
- {Style guide URL if applicable}
- {Figma/Sketch files if applicable}

---

## Traceability

**Mission Reference**: {How UX supports mission goals}

**Architecture Reference**: {How UX aligns with architecture decisions}

**PRD Requirements**: {Which PRD requirements this UX addresses}

---

## Notes

{Any additional context, decisions, trade-offs, or future considerations}

---

## Appendix: Wireframes/Mockups

{Links to design files, or ASCII/text-based wireframes for key screens}

**Example Wireframe**:
```
+------------------------------------------+
| Logo   [Nav Item 1] [Nav Item 2] [User] |
+------------------------------------------+
| Sidebar      | Main Content             |
|              |                          |
| - Item 1     | [Page Title]             |
| - Item 2     |                          |
| - Item 3     | [Content here]           |
|              |                          |
|              | [CTA Button]             |
+------------------------------------------+
```
