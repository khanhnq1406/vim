-- Keymaps - VSCode-like bindings
-- ================================

local map = vim.keymap.set

-- Leader key = Space (like VSCode command palette trigger concept)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =====================
-- General / Editing
-- =====================

-- Save (Ctrl+S)
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Undo/Redo (Ctrl+Z / Ctrl+Shift+Z)
map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo" })
map("n", "<C-S-z>", "<C-r>", { desc = "Redo" })
map("i", "<C-S-z>", "<C-o><C-r>", { desc = "Redo" })
map("n", "<C-y>", "<C-r>", { desc = "Redo" })

-- Select All (Ctrl+A)
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Copy/Cut/Paste (work with system clipboard)
map("v", "<C-c>", '"+y', { desc = "Copy" })
map("v", "<C-x>", '"+d', { desc = "Cut" })
map({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste" })
map("i", "<C-v>", '<C-r>+', { desc = "Paste" })

-- Duplicate line (Ctrl+Shift+D like VSCode / Alt+Shift+Down)
map("n", "<A-S-Down>", "<cmd>t.<cr>", { desc = "Duplicate line down" })
map("n", "<A-S-Up>", "<cmd>t -1<cr>", { desc = "Duplicate line up" })
map("i", "<A-S-Down>", "<esc><cmd>t.<cr>gi", { desc = "Duplicate line down" })

-- Move lines (Alt+Up/Down like VSCode)
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Delete line (Ctrl+Shift+K like VSCode)
map("n", "<C-S-k>", "dd", { desc = "Delete line" })
map("i", "<C-S-k>", "<esc>ddi", { desc = "Delete line" })

-- Comment toggle (Ctrl+/ like VSCode) - handled by Comment.nvim plugin
map("n", "<C-/>", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
map("v", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", { desc = "Toggle comment" })

-- Indent/Outdent (Tab/Shift+Tab in visual mode like VSCode)
map("v", "<Tab>", ">gv", { desc = "Indent" })
map("v", "<S-Tab>", "<gv", { desc = "Outdent" })

-- =====================
-- Navigation
-- =====================

-- Find file (Ctrl+P like VSCode)
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find file" })

-- Command palette (Ctrl+Shift+P like VSCode)
map("n", "<C-S-p>", "<cmd>Telescope commands<cr>", { desc = "Command palette" })

-- Search in files (Ctrl+Shift+F like VSCode)
map("n", "<C-S-f>", "<cmd>Telescope live_grep<cr>", { desc = "Search in files" })

-- Go to symbol (Ctrl+Shift+O like VSCode)
map("n", "<C-S-o>", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Go to symbol" })

-- Go to line (Ctrl+G like VSCode)
map("n", "<C-g>", ":", { desc = "Go to line" })

-- Quick open recent (Ctrl+E)
map("n", "<C-e>", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- =====================
-- Sidebar & Panels
-- =====================

-- Toggle sidebar / file explorer
map("n", "<C-b>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
map("n", "<leader>b", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })

-- Focus file explorer (Ctrl+Shift+E like VSCode)
map("n", "<C-S-e>", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer" })

-- Toggle terminal (Ctrl+` like VSCode)
map({ "n", "t" }, "<C-`>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

-- =====================
-- Tabs / Buffers (like VSCode tabs)
-- =====================

-- Switch tabs (Ctrl+Tab / Ctrl+Shift+Tab)
map("n", "<C-Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next tab" })
map("n", "<C-S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous tab" })

-- Close tab (Ctrl+W like VSCode)
map("n", "<C-w>", "<cmd>bdelete<cr>", { desc = "Close tab" })

-- Go to specific tab (Alt+1..9 like VSCode)
for i = 1, 9 do
  map("n", "<A-" .. i .. ">", "<cmd>BufferLineGoToBuffer " .. i .. "<cr>", { desc = "Go to tab " .. i })
end

-- =====================
-- Multi-cursor / Find & Replace
-- =====================

-- Find (Ctrl+F)
map("n", "<C-f>", "/", { desc = "Find" })

-- Find and replace (Ctrl+H like VSCode)
map("n", "<C-h>", ":%s/", { desc = "Find and replace" })

-- =====================
-- Window Management
-- =====================

-- Split (like VSCode split editor)
map("n", "<leader>\\", "<cmd>vsplit<cr>", { desc = "Split right" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Split down" })

-- Navigate between splits (Ctrl+Arrow or Alt+Arrow)
map("n", "<C-Left>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-Right>", "<C-w>l", { desc = "Move to right split" })
map("n", "<C-Up>", "<C-w>k", { desc = "Move to upper split" })
map("n", "<C-Down>", "<C-w>j", { desc = "Move to lower split" })

-- =====================
-- LSP Keymaps (set in LSP on_attach, but some global)
-- =====================

-- These are set in the LSP config, but here are leader-based ones:
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover info" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- Diagnostics (like VSCode problems panel)
map("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { desc = "List diagnostics" })

-- Format (Shift+Alt+F like VSCode)
map({ "n", "v" }, "<A-S-f>", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format document" })

-- =====================
-- Git (like VSCode Source Control)
-- =====================
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Git blame line" })
map("n", "<leader>gd", function()
  vim.cmd("DiffviewOpen -- " .. vim.fn.expand("%"))
end, { desc = "Git diff file" })
map("n", "<leader>gs", "<cmd>DiffviewOpen<cr>", { desc = "Source control" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })

-- =====================
-- Misc
-- =====================

-- Clear search highlights (Esc)
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })

-- Better escape from terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Which-key hint (leader alone shows available keys)
-- Handled by which-key plugin
