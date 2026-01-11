# Remove Git Worktree

Remove a worktree from the repository.

## Usage

```
/worktree-remove <branch-name>
```

## Arguments

- `branch-name`: The branch name to remove (e.g., `feature/auth`)

## Instructions

1. Parse the argument: `$ARGUMENTS`
2. Get the repo name from current directory (e.g., `abc` from `/path/to/abc`)
3. Sanitize branch name for folder (replace `/` with `_`, e.g., `feature/auth` -> `feature_auth`)
4. Determine the worktree path: `../<repo-name>_worktree/<sanitized-branch-name>`
5. Run `git worktree remove <path>`
6. If worktree has uncommitted changes, warn user and ask for confirmation to use `--force`
7. Run `git worktree prune` to clean up stale entries
8. If worktree folder is empty after removal, optionally remove it

## Example

```bash
# Remove worktree by branch name
/worktree-remove feature/auth
```
