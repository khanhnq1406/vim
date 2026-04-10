# Diffview & Source Control Panel Implementation Plan

**Goal:** Add diffview.nvim for VSCode-like source control panel and inline diffs, with clickable gitsigns gutter icons.
**Spec:** `.claude/specs/2026-04-10-diffview-source-control-spec.md`

---

### Task 1: Add diffview.nvim plugin spec

**Files:**

- Modify: `lua/plugins/git.lua` (add new plugin spec after the existing entries)

**Steps:**

1. Add `sindrets/diffview.nvim` plugin spec to the return table in `git.lua`
2. Lazy-load on commands: `DiffviewOpen`, `DiffviewFileHistory`, `DiffviewClose`
3. Dependencies: `nvim-lua/plenary.nvim` (already in repo)
4. Configure with sensible defaults:
   - `enhanced_diff_hl = true` (better diff highlighting with treesitter)
   - `use_icons = true` (file icons in the panel)
   - File panel position on the left (consistent with nvim-tree sidebar)
   - `q` keybinding to close diffview (via `view.keymaps`)

```lua
{
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    enhanced_diff_hl = true,
    use_icons = true,
    view = {
      default = { layout = "diff2_horizontal" },
      file_history = { layout = "diff2_horizontal" },
    },
    file_panel = {
      listing_style = "tree",
      win_config = {
        position = "left",
        width = 35,
      },
    },
  },
},
```

---

### Task 2: Add gitsigns click handler for gutter signs

**Files:**

- Modify: `lua/plugins/git.lua` (gitsigns `on_attach` section, lines ~31-48)

**Steps:**

1. Inside the gitsigns `on_attach` function, add a mouse click mapping on `<LeftMouse>` that checks if the click was on a sign column and opens diffview for the current file
2. The approach: use `vim.fn.getmousepos()` to detect click position. If clicking on the sign column (column <= 2 in the sign area), open diffview for the current file.
3. Add this as a buffer-local keymap in the `on_attach`:

```lua
-- Click on gitsigns gutter to open diff
map("n", "<LeftRelease>", function()
  local mousepos = vim.fn.getmousepos()
  -- screencol 1-4 covers the sign/number column area
  if mousepos.screencol <= 4 then
    -- Check if there's a gitsigns sign on this line
    local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
      group = "gitsigns_vimfn_signs_",
      lnum = mousepos.line,
    })
    if signs and signs[1] and #signs[1].signs > 0 then
      vim.cmd("DiffviewOpen -- " .. vim.fn.expand("%"))
    end
  end
end, "Open diff on gutter click")
```

> **Note:** This is a best-effort approach. Neovim's sign click detection is not pixel-perfect. If `getmousepos().screencol` doesn't reliably detect the sign area, we may need to adjust the threshold or use the `statuscolumn` click handler approach. The keyboard shortcuts remain the primary reliable workflow.

---

### Task 3: Update keymaps for diffview

**Files:**

- Modify: `lua/config/keymaps.lua` (Git section, lines ~162-167)

**Steps:**

1. Replace `<leader>gd` mapping — change from `Gitsigns diffthis` to `DiffviewOpen -- %` (diff current file):

```lua
-- Before:
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Git diff" })

-- After:
map("n", "<leader>gd", function()
  vim.cmd("DiffviewOpen -- " .. vim.fn.expand("%"))
end, { desc = "Git diff file" })
```

2. Add `<leader>gs` for source control panel (all changes):

```lua
map("n", "<leader>gs", "<cmd>DiffviewOpen<cr>", { desc = "Source control" })
```

3. Add `<leader>gh` for file history:

```lua
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history" })
```

4. Conflict check: `<leader>gs` and `<leader>gh` are free. `<leader>gd` is an intentional replacement. Verified against keymaps.lua.

---

### Execution Order

1. **Task 1** first — plugin must be available before keymaps or click handlers reference its commands
2. **Task 2** second — gitsigns click handler depends on diffview commands existing
3. **Task 3** last — keymaps reference diffview commands
