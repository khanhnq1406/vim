-- Core Neovim Options (VSCode-like behavior)
-- ============================================

local opt = vim.opt

-- Line numbers (like VSCode)
opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- Tabs & Indentation (VSCode defaults)
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search (like VSCode Ctrl+F)
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.showmode = false -- lualine shows mode
opt.cmdheight = 1
opt.pumheight = 10 -- popup menu height

-- Mouse support (clickable like VSCode)
opt.mouse = "a"
opt.mousemodel = "extend"

-- Split behavior (like VSCode)
opt.splitbelow = true
opt.splitright = true

-- File handling
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- Clipboard (sync with system like VSCode)
opt.clipboard = "unnamedplus"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Fold (VSCode-like)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Misc
opt.confirm = true
opt.fillchars = { eob = " ", fold = " ", foldsep = " " }
opt.list = true
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
opt.shortmess:append("sI")

-- Disable netrw (using nvim-tree instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
