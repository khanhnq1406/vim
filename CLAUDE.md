# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Neovim configuration designed to replicate the VSCode experience. Uses Lazy.nvim as the plugin manager with a modular Lua-based config structure. Intended to be symlinked to `~/.config/nvim`.

## Setup

```bash
./setup.sh   # Installs neovim, deps (ripgrep, fd, lazygit, nerd font), symlinks to ~/.config/nvim
```

## Architecture

- `init.lua` — Entry point, loads config modules then bootstraps plugins
- `lua/config/` — Core configuration (non-plugin):
  - `options.lua` — Neovim settings (tabs, clipboard, mouse, folds, etc.)
  - `keymaps.lua` — All VSCode-like keybindings (Ctrl+P, Ctrl+B, Ctrl+S, etc.)
  - `autocmds.lua` — Auto-commands (format on save, yank highlight, restore cursor)
  - `lazy.lua` — Lazy.nvim bootstrap and plugin loader
- `lua/plugins/` — Each file returns a Lazy.nvim plugin spec table (auto-discovered by lazy.nvim):
  - `lsp.lua` — Mason + LSP servers config (the most complex file; servers table defines per-language setup)
  - `cmp.lua` — Autocompletion engine with snippet/LSP/buffer/path sources
  - `formatting.lua` — conform.nvim formatters (Prettier, Stylua, Black) + mason-tool-installer
  - `git.lua` — gitsigns (inline blame), lazygit, fugitive
  - `ui.lua` — lualine, bufferline, indent-blankline, noice, notify, which-key, navic breadcrumbs, dressing
  - `editor.lua` — autopairs, autotag, Comment.nvim, surround, colorizer, todo-comments, vim-visual-multi, neoscroll
  - `nvim-tree.lua`, `telescope.lua`, `terminal.lua`, `dashboard.lua`, `colorscheme.lua` — self-explanatory

## Key Design Decisions

- Keymaps are centralized in `keymaps.lua` except for buffer-local LSP/gitsigns keymaps which are set in their respective plugin `on_attach` callbacks.
- Format-on-save is controlled by `vim.g.format_on_save` (toggle with `:ToggleFormatOnSave`). It runs via conform.nvim in `autocmds.lua`, not in the conform plugin config.
- LSP servers are added by editing the `servers` table in `lsp.lua` and the `ensure_installed` list in mason-lspconfig. Both must be updated together.
- Formatters are added by editing `formatters_by_ft` in `formatting.lua` and `ensure_installed` in mason-tool-installer. Both must be updated together.
- The colorscheme is Catppuccin Mocha. Changing it requires updating both `colorscheme.lua` and the lualine theme in `ui.lua`.
