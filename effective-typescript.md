# Effective TypeScript

TypeScript-**specific** reference. For general principles (all languages), read
**[general-conventions.md](./general-conventions.md)**. For lint-enforceable
anti-patterns, read **[typescript-javascript-conventions.md](./typescript-javascript-conventions.md)**.

## Canonical reference

**[Effective TypeScript, 2nd Edition](https://www.oreilly.com/library/view/effective-typescript-2nd/9781098155056/)**
(Dan Vanderkam, 83 items) is authoritative. Read items online via the author's
**[sample repo table of contents](https://github.com/danvk/effective-typescript/blob/main/README.md)** —
each item links to its **"Things to Remember"** summary and TypeScript playground
samples. Author site: <https://effectivetypescript.com/>.

**For reviews:** use the checklist below; open the linked repo page for any item
you need to apply or verify.

## The 83 items (checklist)

### Ch 1 — Getting to Know TypeScript

1. Understand the Relationship Between TypeScript and JavaScript
2. Know Which TypeScript Options You're Using
3. Understand That Code Generation Is Independent of Types
4. Get Comfortable with Structural Typing
5. Limit Use of the `any` Type

### Ch 2 — TypeScript's Type System

6. Use Your Editor to Interrogate and Explore the Type System
7. Think of Types as Sets of Values
8. Know How to Tell Whether a Symbol Is in the Type Space or Value Space
9. Prefer Type Annotations to Type Assertions
10. Avoid Object Wrapper Types (String, Number, Boolean, Symbol, BigInt)
11. Distinguish Excess Property Checking from Type Checking
12. Apply Types to Entire Function Expressions When Possible
13. Know the Differences Between `type` and `interface`
14. Use `readonly` to Avoid Errors Associated with Mutation
15. Use Type Operations and Generic Types to Avoid Repeating Yourself
16. Prefer More Precise Alternatives to Index Signatures
17. Avoid Numeric Index Signatures

### Ch 3 — Type Inference and Control Flow Analysis

18. Avoid Cluttering Your Code with Inferable Types
19. Use Different Variables for Different Types
20. Understand How a Variable Gets Its Type
21. Create Objects All at Once
22. Understand Type Narrowing
23. Be Consistent in Your Use of Aliases
24. Understand How Context Is Used in Type Inference
25. Understand Evolving Types
26. Use Functional Constructs and Libraries to Help Types Flow
27. Use async Functions Instead of Callbacks to Improve Type Flow
28. Use Classes and Currying to Create New Inference Sites

### Ch 4 — Type Design

29. Prefer Types That Always Represent Valid States
30. Be Liberal in What You Accept and Strict in What You Produce
31. Don't Repeat Type Information in Documentation
32. Avoid Including `null` or `undefined` in Type Aliases
33. Push Null Values to the Perimeter of Your Types
34. Prefer Unions of Interfaces to Interfaces with Unions
35. Prefer More Precise Alternatives to String Types
36. Use a Distinct Type for Special Values
37. Limit the Use of Optional Properties
38. Avoid Repeated Parameters of the Same Type
39. Prefer Unifying Types to Modeling Differences
40. Prefer Imprecise Types to Inaccurate Types
41. Name Types Using the Language of Your Problem Domain
42. Avoid Types Based on Anecdotal Data

### Ch 5 — Unsoundness and the `any` Type

43. Use the Narrowest Possible Scope for `any` Types
44. Prefer More Precise Variants of `any` to Plain `any`
45. Hide Unsafe Type Assertions in Well-Typed Functions
46. Use `unknown` Instead of `any` for Values with an Unknown Type
47. Prefer Type-Safe Approaches to Monkey Patching
48. Avoid Soundness Traps
49. Track Your Type Coverage to Prevent Regressions in Type Safety

### Ch 6 — Generics and Type-Level Programming

50. Think of Generics as Functions Between Types
51. Avoid Unnecessary Type Parameters
52. Prefer Conditional Types to Overload Signatures
53. Know How to Control the Distribution of Unions over Conditional Types
54. Use Template Literal Types to Model DSLs and Relationships Between Strings
55. Write Tests for Your Types
56. Pay Attention to How Types Display
57. Prefer Tail-Recursive Generic Types
58. Consider Codegen as an Alternative to Complex Types

### Ch 7 — TypeScript Recipes

59. Use `never` Types to Perform Exhaustiveness Checking
60. Know How to Iterate Over Objects
61. Use `Record` Types to Keep Values in Sync
62. Use Rest Parameters and Tuple Types to Model Variadic Functions
63. Use Optional `never` Properties to Model Exclusive Or
64. Consider Brands for Nominal Typing

### Ch 8 — Type Declarations and @types

65. Put TypeScript and `@types` in `devDependencies`
66. Understand the Three Versions Involved in Type Declarations
67. Export All Types That Appear in Public APIs
68. Use TSDoc for API Comments
69. Provide a Type for `this` in Callbacks if It's Part of Their API
70. Mirror Types to Sever Dependencies
71. Use Module Augmentation to Improve Types

### Ch 9 — Writing and Running Your Code

72. Prefer ECMAScript Features to TypeScript Features
73. Use Source Maps to Debug TypeScript
74. Know How to Reconstruct Types at Runtime
75. Understand the DOM Hierarchy
76. Create an Accurate Model of Your Environment
77. Understand the Relationship Between Type Checking and Unit Testing
78. Pay Attention to Compiler Performance

### Ch 10 — Modernization and Migration

79. Write Modern JavaScript
80. Use `@ts-check` and JSDoc to Experiment with TypeScript
81. Use `allowJs` to Mix TypeScript and JavaScript
82. Convert Module by Module Up Your Dependency Graph
83. Don't Consider Migration Complete Until You Enable `noImplicitAny`

## How to read it alongside the general conventions

| general-conventions.md principle | Items to consult |
|---|---|
| Prefer stronger type safety (sealed/union types, exhaustive matching) | 22, 29, 34, 59 |
| Encode invariants in the type system | 9, 32–33, 46, 64 |
| Structural fixes over patches | 72 (prefer ECMA over TS-only runtime features) |

When in doubt, defer to the book and its online samples. Do not invent patterns
weaker than what general-conventions.md and these items describe.
