---
description: Create atomic commits with conventional commits syntax
agent: general
---

Analyze the current changes and create atomic commits using conventional commits syntax.

Steps:
1. Run `git status` and `git diff` to see all changes
2. Run `git log --oneline -5` to understand existing commit style
3. Break down changes into logical atomic units (one concern per commit)
4. For each unit, stage relevant files and commit with conventional syntax:
   - `feat:` new feature
   - `fix:` bug fix
   - `docs:` documentation
   - `refactor:` code restructuring
   - `chore:` maintenance tasks
   - `style:` formatting
   - `test:` tests
5. Keep commit messages concise (imperative mood, <72 chars)
6. Report all commits created

If $ARGUMENTS is provided, use it as context for the commit scope.
