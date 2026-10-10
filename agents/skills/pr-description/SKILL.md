---
name: pr-description
description: Write or revise GitHub PR titles and descriptions.
---

# Write good PR descriptions

Describe the final change so a reviewer can understand it without the conversation history.
Always follow the repository's PR template and conventions. Those superseed the instructions given here.

## Summary

Use a specific title that names the problem or resulting behavior. Open the description
with the problem, the change, and who or what it affects. Add a before-and-after example
when it makes the behavior clearer, and link related issues.

Explain the approach only where it helps assess a tradeoff. Skip investigation history,
commit logs, and file-by-file summaries. When scope changes, update the title and
description to match the final implementation.

## Interface changes

Always include an "Interface changes" section. Document every added, changed, or removed
contract that callers or users depend on. If there are none, state "None."

For API endpoints, include:

- HTTP method and path, including the previous contract for changes or removals.
- Request and response DTO schemas, including field names, types, required or optional
  fields, defaults, and constraints. Show nested structures and enum values where relevant.
- Changes to authentication, status codes, or error responses.

For CLI commands, exported functions or types, events, and configuration, show the affected
signature, syntax, or schema and an example of use. State breaking changes early and explain
how callers must adapt. Derive these details from the implementation; flag any uncertainty.

## Review focus and evidence

Point reviewers to specific risks, uncertain behavior, and code that needs a close look.
Mention mechanical changes that are safe to skim when they would otherwise obscure the
important parts.

Report checks actually run and their results, plus relevant gaps in verification.
For visual changes, include screenshots or a short recording, with before-and-after views
when useful. Include deploy order, migrations, flags, backfills, rollback limitations, and
deliberate follow-ups when applicable.

## Suggested structure

Adapt this to the repository template. Keep "Interface changes" and verification details;
omit other sections when they add nothing.

```markdown
## Summary
The problem, resulting behavior, and affected users or systems. Link related issues.

## Interface changes
Changed contracts, example commands, and schemas. State "None." if unchanged.

## Review focus
Specific risks or uncertainty, with code references where useful.

## Verification
Checks run, results, and relevant gaps.

## Rollout and follow-ups
Deployment or migration requirements, rollback limitations, and linked follow-up issues.
```
