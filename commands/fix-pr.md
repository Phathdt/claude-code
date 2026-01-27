# Fix PR Review Comments

Fetch review comments, fix issues, reply, and mark as resolved.

## Arguments

$ARGUMENTS

## Instructions

Use the `gh` skill (section "2. Fixing PR Review Comments") to:

1. Get current PR number (or use provided PR number/URL)
2. Fetch review comments via REST API: `gh api repos/:owner/:repo/pulls/{pr}/comments`
3. For each unresolved comment:
   - Display: file, line, comment body, author
   - Ask user: "Fix this? (Yes/No/Skip)"
   - If Yes: Read file, implement fix
4. Commit and push fixes: `fix(pr): address review comments`
5. **REQUIRED**: For each fixed comment:
   - Reply with fix description
   - Resolve the thread via GraphQL mutation
6. Never leave threads unresolved

## Usage

```
/fix-pr              # Fix comments on current branch's PR
/fix-pr 123          # Fix comments on PR #123
/fix-pr https://github.com/owner/repo/pull/123
```
