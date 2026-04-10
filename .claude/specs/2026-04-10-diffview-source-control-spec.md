# Diffview & Source Control Panel Specification

## Summary

Add `diffview.nvim` to provide a VSCode-like source control experience: a side panel listing all changed files (staged/unstaged/untracked) with side-by-side diffs, and the ability to click gitsigns gutter icons to open the diff for that file. This replaces the basic `Gitsigns diffthis` with a richer diff viewer.

## Approach

Use **sindrets/diffview.nvim** — the most mature Neovim plugin for this purpose. It provides:
- A file panel showing staged/unstaged/untracked files (like VSCode source control sidebar)
- Side-by-side diff views when selecting a file
- File history view (git log per file or repo-wide)
- Merge conflict resolution view

For the "click gutter sign to see diff" behavior: configure gitsigns' `on_click` handler on the sign column to open `diffview` for the current file. This uses Neovim's `statuscolumn` click support (requires Neovim >= 0.9).

**Why diffview.nvim over alternatives:**
- More complete than fugitive's `:Gdiffsplit` (which only diffs one file at a time, no file panel)
- More integrated than lazygit (which is a full TUI, not a Neovim-native panel)
- Widely adopted, actively maintained, works well with gitsigns

## Changes Required

### Files to Modify

| File | What Changes |
| ---- | ------------ |
| `lua/plugins/git.lua` | Add diffview.nvim plugin spec; add click handler to gitsigns config |
| `lua/config/keymaps.lua` | Replace `<leader>gd` (gitsigns diffthis → diffview); add `<leader>gs` (source control panel); add `<leader>gh` (file history) |

### New Files

None.

## Functional Requirements

- [ ] `diffview.nvim` installed and lazy-loaded (on command trigger)
- [ ] Clicking a gitsigns gutter icon opens diffview for the current file
- [ ] `<leader>gd` opens diffview for the current file (replaces gitsigns diffthis)
- [ ] `<leader>gs` opens the diffview source control panel (all changed files)
- [ ] `<leader>gh` opens file history for the current file
- [ ] `q` closes diffview panels (consistent with other panel close patterns)
- [ ] Diffview file panel shows staged/unstaged/untracked sections
- [ ] Side-by-side diff rendering with syntax highlighting via treesitter

## Keymap Changes

| Key | Mode | Action | Conflict Check |
| --- | ---- | ------ | -------------- |
| `<leader>gd` | n | Open diffview for current file | Replaces existing gitsigns diffthis (intentional) |
| `<leader>gs` | n | Open source control panel (DiffviewOpen) | No conflict — `<leader>gs` is free |
| `<leader>gh` | n | Open file history for current file | No conflict — `<leader>gh` is free |

## Plugin Configuration Details

**diffview.nvim:**
- Lazy-load on commands: `DiffviewOpen`, `DiffviewFileHistory`, `DiffviewClose`
- Dependencies: `nvim-lua/plenary.nvim` (already present), `nvim-tree/nvim-web-devicons` (already present)
- Use single-tabpage layout to avoid disrupting workspace
- Default keymaps within diffview panels (navigation, staging) — use plugin defaults

**gitsigns click handler:**
- Use `on_click` callback on gitsigns signs to trigger `:DiffviewOpen -- %` for the current file
- Fallback: if `statuscolumn` click is not reliable, the keyboard shortcuts (`<leader>gd`) remain the primary workflow

## Consistency Rules Checklist

- [x] If adding LSP server: N/A
- [x] If adding formatter: N/A
- [x] If changing colorscheme: N/A
- [x] If adding keymap: no conflict with existing keymaps in `keymaps.lua` — verified above

## Edge Cases & Failure Modes

- **Neovim < 0.9:** Sign click handlers require `statuscolumn` support. If the user's Neovim is older, the click-to-diff feature won't work, but keyboard shortcuts will still function.
- **No git repo:** Diffview gracefully shows "not a git repository" error — no crash.
- **Large repos:** Diffview can be slow on repos with thousands of changed files. Not a concern for a Neovim config repo.
- **Merge conflicts:** Diffview has a merge tool view — not configuring it now, but it's available for future use.

## Out of Scope

- Inline commit from diffview (use LazyGit for full commit workflow)
- Merge conflict resolution UI (available in diffview but not configured in this spec)
- Git stash management
- Branch comparison views
