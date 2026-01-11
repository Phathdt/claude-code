# Fix PR Review Comments

Pull review comments from a PR, analyze them, fix issues, and mark as resolved.

## Steps

1. **Get PR info**: Use `gh pr view` to get current PR number (or use provided PR number)
2. **Fetch review threads**: Use GraphQL to get unresolved review threads with their thread IDs:
   ```bash
   gh api graphql -f query='
   {
     repository(owner: "{owner}", name: "{repo}") {
       pullRequest(number: {pr}) {
         reviewThreads(first: 50) {
           nodes {
             id
             isResolved
             path
             line
             comments(first: 5) {
               nodes {
                 id
                 body
                 author { login }
               }
             }
           }
         }
       }
     }
   }'
   ```
3. **Filter unresolved**: Only process threads where `isResolved: false`
4. **Analyze comments**: For each unresolved thread:
   - Show the comment to the user (file, line, body)
   - Ask if we should fix it (Yes/No/Skip)
5. **Fix issues**: For approved fixes:
   - Read the relevant file
   - Apply the suggested fix or implement the requested change
   - Track what was fixed
6. **Commit and push**:
   - Stage all fixed files
   - Commit with message: `fix(pr): address review comments`
   - Push to the current branch
7. **Reply and resolve**: For each fixed comment:
   - Reply with what was done using `gh api repos/{owner}/{repo}/pulls/{pr}/comments/{comment_id}/replies`
   - **Resolve the thread** using GraphQL mutation:
     ```bash
     gh api graphql -f query='
     mutation {
       resolveReviewThread(input: {threadId: "{thread_id}"}) {
         thread { isResolved }
       }
     }'
     ```

## Usage

```
/fix-pr          # Fix comments on current branch's PR
/fix-pr 123      # Fix comments on PR #123
/fix-pr https://github.com/owner/repo/pull/123  # Fix comments using PR URL
```

## Arguments

- `$ARGUMENTS` - Optional PR number or URL. If not provided, uses the PR associated with current branch.
