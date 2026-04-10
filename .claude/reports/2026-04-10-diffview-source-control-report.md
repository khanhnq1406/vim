# Diffview & Source Control Panel Implementation Report

## Summary

Added diffview.nvim plugin for VSCode-like source control panel and inline diff viewing. Includes clickable gitsigns gutter icons that open diffs, and three keymaps for diff file view, source control panel, and file history.

## Spec Reference

`.claude/specs/2026-04-10-diffview-source-control-spec.md`

## Plan Reference

`.claude/plans/2026-04-10-diffview-source-control-plan.md`

## Tasks Completed

| # | Task | Status | Files Changed |
| - | ---- | ------ | ------------- |
| 1 | Add diffview.nvim plugin spec | Done | `lua/plugins/git.lua` |
| 2 | Add gitsigns click handler | Done | `lua/plugins/git.lua` |
| 3 | Update keymaps for diffview | Done | `lua/config/keymaps.lua` |

## Review Results

### Spec Compliance

All three tasks passed spec compliance review. Task 2 required one fix iteration: the initial implementation used a legacy `sign_getplaced` API with an internal gitsigns sign group name. This was replaced with the public `gs.get_hunks()` API. A second review caught that delete hunks (`added.count = 0`) were not matched; fixed by using `math.max(count, 1)`.

### Code Quality

All tasks approved on code quality:
- Plugin spec uses `opts` pattern consistent with existing gitsigns config
- Click handler uses public gitsigns API with early return for non-sign-column clicks
- Keymaps follow existing style with `desc` fields on all entries

## Known Issues / Technical Debt

- The `<LeftRelease>` click handler is buffer-local and has an early return for non-sign-column clicks, but it still technically overrides the default `<LeftRelease>` for sign-column clicks. This is the intended behavior.
- The `screencol <= 4` threshold assumes standard sign column width. If the user has a very wide number column, the threshold may need adjusting.

## Files Changed

- `lua/plugins/git.lua` — added diffview.nvim plugin spec + gitsigns click handler
- `lua/config/keymaps.lua` — replaced `<leader>gd`, added `<leader>gs` and `<leader>gh`

## How to Verify

1. Open Neovim in a git repository with changes
2. Verify diffview loads: `:DiffviewOpen` should show a file panel + diff view
3. Test `<leader>gs` — opens source control panel with all changed files
4. Test `<leader>gd` — opens diff for the current file
5. Test `<leader>gh` — opens file history for the current file
6. Click on a gitsigns gutter icon (the `│` markers) — should open diffview for that file
7. Press `q` in diffview to close it
8. Verify `:checkhealth` has no new errors
