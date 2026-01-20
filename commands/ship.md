# Ship Changes

Create a new branch, commit all changes, push to remote, and create a pull request.

## Steps

1. **Check status**: Run `git status` and `git diff --stat` to see all changes
2. **Create branch**: Create a new branch with a descriptive name based on the changes (e.g., `feat/feature-name`, `fix/bug-name`, `refactor/description`)
3. **Stage changes**: Stage all relevant files with `git add`
4. **Commit**: Create a commit with a conventional commit message summarizing the changes
5. **Push**: Push the branch to remote with `-u` flag
6. **Create PR**: Use `gh pr create` with:
   - Title: Same as commit message
   - Body: Include Summary (bullet points), Changes (list of modified areas), and Test plan sections
   - Base branch:
     - **If argument provided**: Use the specified branch (e.g., `/ship staging` → PR to `staging`)
     - **If no argument**: Auto-detect by checking which branch the current branch was created from:
       - Run `git log --oneline --decorate | grep -E 'origin/(main|staging|develop)' | head -1` to find the parent branch
       - Or use `git merge-base --fork-point` to find the fork point
       - If created from `main` → PR to `main`
       - If created from `staging` → PR to `staging`
       - If created from `develop` → PR to `develop`
       - Fallback: Use `main` if origin cannot be determined

## Arguments

$ARGUMENTS

## Usage

```
/ship              # Auto-detect base branch from origin
/ship main         # Force PR to main
/ship staging      # Force PR to staging
/ship develop      # Force PR to develop
```

This command will analyze your staged/unstaged changes and handle the entire git workflow automatically.
