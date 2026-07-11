---
name: ask-me-questions
description: Clarify the minimum blocking requirements before implementing an underspecified request. Use only when explicitly invoked, especially when the objective, done criteria, scope, constraints, environment, or safety requirements are unclear.
---

# Ask Me Questions

## Goal

Ask the smallest set of clarifying questions needed to avoid doing the wrong work. Do not begin implementation until the must-have answers arrive, unless the user explicitly authorizes proceeding with stated assumptions.

## Workflow

### 1. Decide whether clarification is required

After enough low-risk discovery to understand the task, check whether any of these remain materially ambiguous:

- Objective: what should change and what should stay unchanged.
- Done criteria: acceptance criteria, examples, edge cases, or expected output.
- Scope: files, components, users, or systems included and excluded.
- Constraints: compatibility, performance, style, dependencies, or deadline.
- Environment: language, runtime, operating system, tools, or test runner.
- Safety and reversibility: migrations, rollout, data loss, or rollback expectations.

Treat the request as underspecified when an unresolved item could lead to multiple plausible implementations or a materially different outcome.

### 2. Ask only must-have questions

Ask 1–5 concise questions in the first pass. Prefer questions that eliminate whole branches of work. Make them easy to answer:

- Use numbered questions.
- Offer mutually exclusive options when useful.
- Mark reasonable defaults clearly and provide a fast path such as `defaults`.
- Include a “not sure” option when it lowers friction.
- Separate must-have questions from nice-to-have context when needed.

Do not ask for information that can be safely discovered from the repository, current artifact, or existing project conventions. Perform that low-risk discovery first when it does not commit the work to a direction.

### 3. Pause before acting

After asking must-have questions, stop. Do not run implementation commands, edit files, or produce a detailed implementation plan that depends on unanswered choices.

If the user explicitly says to proceed without answers:

1. State the assumptions in a short numbered list.
2. Ask the user to confirm or correct them.
3. Proceed only after confirmation.

### 4. Confirm and continue

When answers arrive, restate the interpreted requirements in 1–3 sentences, including key constraints and what success looks like. Then continue with the implementation workflow.

## Question template

Use this shape when it fits:

Before I start, I need:

1. Objective and scope: what should change, and which files or components are in scope?
2. Done criteria: what result or examples should I satisfy?
3. Constraints: which compatibility, style, performance, dependency, or safety requirements matter?

If you don't care about a question, say so and use the project defaults. Reply `defaults` to accept all stated defaults.
