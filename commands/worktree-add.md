# Add Git Worktree

Create a new worktree for parallel development.

## Usage

```
/worktree-add <branch-name> [base-branch]
```

## Arguments

- `branch-name`: The branch to checkout (or create if it doesn't exist)
- `base-branch`: (Optional) Base branch for new branch creation. Defaults to current branch.

## Instructions

1. Parse the arguments: `$ARGUMENTS`
2. Get the repo name from current directory (e.g., `abc` from `/path/to/abc`)
3. Sanitize branch name for folder (replace `/` with `_`, e.g., `feature/auth` -> `feature_auth`)
4. Determine the worktree path: `../<repo-name>_worktree/<sanitized-branch-name>`
5. Create the worktree folder if it doesn't exist: `mkdir -p ../<repo-name>_worktree`
6. Check if branch exists:
   - If exists: `git worktree add ../<repo-name>_worktree/<sanitized-branch> <branch-name>`
   - If not exists: `git worktree add -b <branch-name> ../<repo-name>_worktree/<sanitized-branch> <base-branch>`
7. Report success with the worktree path

## Folder Structure

```
/path/to/
├── abc/                    # main repo
└── abc_worktree/           # worktrees folder (auto-created)
    ├── feature_auth/
    ├── fix_login_bug/
    └── develop/
```

## Example

```bash
# Add worktree for existing branch
/worktree-add feature/auth

# Add worktree with new branch from main
/worktree-add feature/new-api main
```
