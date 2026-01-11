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
   - Base branch: Use `develop` if it exists, otherwise `main`

## Usage

```
/ship
```

This command will analyze your staged/unstaged changes and handle the entire git workflow automatically.
