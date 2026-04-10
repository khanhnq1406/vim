# Neovim Configuration

A Neovim configuration designed to replicate the VSCode experience. Built with Lua and [Lazy.nvim](https://github.com/folke/lazy.nvim) for fast, modular plugin management.

```
 ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
 ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
 ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
 ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
 ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
 ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
```

## Features

- **VSCode-like keybindings** — Ctrl+P, Ctrl+B, Ctrl+S, Ctrl+/, Alt+Up/Down, and more
- **Full LSP support** — IntelliSense-style autocomplete, go-to-definition, hover, rename, code actions
- **Built-in language support** — Lua, TypeScript, Python, Go, Rust, HTML/CSS, Tailwind, JSON, Emmet
- **Format on save** — Powered by conform.nvim with Prettier, Stylua, Black
- **Git integration** — Inline blame, diff, hunk preview via gitsigns + LazyGit TUI
- **Fuzzy finder** — Telescope for files, grep, symbols, commands, recent files
- **File explorer** — nvim-tree with file icons (Ctrl+B to toggle)
- **Integrated terminal** — ToggleTerm with Ctrl+` (just like VSCode)
- **Modern UI** — Catppuccin Mocha theme, bufferline tabs, lualine statusbar, indent guides, breadcrumbs, smooth scrolling
- **Multi-cursor** — vim-visual-multi (Ctrl+D for next occurrence)
- **Auto-install** — Mason auto-installs LSP servers and formatters on first launch

## Requirements

- macOS (setup script uses Homebrew)
- [Neovim](https://neovim.io/) >= 0.9
- A terminal with [Nerd Font](https://www.nerdfonts.com/) support (JetBrains Mono Nerd Font installed by setup)

## Installation

```bash
git clone https://github.com/<your-username>/vim.git ~/vim
cd ~/vim
./setup.sh
```

The setup script will:

1. Install Neovim via Homebrew (if not installed)
2. Install dependencies: ripgrep, fd, lazygit
3. Install JetBrains Mono Nerd Font
4. Symlink this directory to `~/.config/nvim`

Then launch `nvim` — Lazy.nvim will auto-install all plugins on first run.

## Keyboard Shortcuts

### General

| Shortcut | Action |
|---|---|
| `Ctrl+S` | Save |
| `Ctrl+Z` / `Ctrl+Shift+Z` | Undo / Redo |
| `Ctrl+A` | Select all |
| `Ctrl+C` / `Ctrl+X` / `Ctrl+V` | Copy / Cut / Paste (system clipboard) |
| `Ctrl+/` | Toggle comment |
| `Ctrl+Shift+K` | Delete line |
| `Alt+Up/Down` | Move line up/down |
| `Alt+Shift+Down` | Duplicate line |
| `Tab` / `Shift+Tab` (visual) | Indent / Outdent |

### Navigation

| Shortcut | Action |
|---|---|
| `Ctrl+P` | Find file |
| `Ctrl+Shift+F` | Search in files |
| `Ctrl+Shift+P` | Command palette |
| `Ctrl+Shift+O` | Go to symbol |
| `Ctrl+E` | Recent files |
| `Ctrl+G` | Go to line |
| `Ctrl+F` | Find in file |
| `Ctrl+H` | Find and replace |

### Panels & Tabs

| Shortcut | Action |
|---|---|
| `Ctrl+B` | Toggle file explorer |
| `Ctrl+Shift+E` | Focus file explorer |
| `` Ctrl+` `` | Toggle terminal |
| `Ctrl+Tab` / `Ctrl+Shift+Tab` | Next / Previous tab |
| `Ctrl+W` | Close tab |
| `Alt+1..9` | Go to tab 1–9 |

### LSP

| Shortcut | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover info |
| `Ctrl+K` | Signature help |
| `Space+ca` | Code action |
| `Space+rn` | Rename symbol |
| `Shift+Alt+F` | Format document |

### Git

| Shortcut | Action |
|---|---|
| `Space+gg` | Open LazyGit |
| `Space+gb` | Git blame line |
| `Space+gd` | Git diff |
| `Space+gp` | Preview hunk |
| `Space+gr` | Reset hunk |

### Window Management

| Shortcut | Action |
|---|---|
| `Space+\` | Split right |
| `Space+-` | Split down |
| `Ctrl+Arrow` | Navigate between splits |

## Project Structure

```
.
├── init.lua                  # Entry point
├── setup.sh                  # One-command setup script
├── lua/
│   ├── config/
│   │   ├── options.lua       # Neovim settings
│   │   ├── keymaps.lua       # All keybindings
│   │   ├── autocmds.lua      # Auto-commands
│   │   └── lazy.lua          # Plugin manager bootstrap
│   └── plugins/
│       ├── lsp.lua           # LSP + Mason
│       ├── cmp.lua           # Autocompletion
│       ├── formatting.lua    # Formatters (conform.nvim)
│       ├── git.lua           # Git integration
│       ├── ui.lua            # Statusline, bufferline, UI components
│       ├── editor.lua        # Editing enhancements
│       ├── telescope.lua     # Fuzzy finder
│       ├── nvim-tree.lua     # File explorer
│       ├── terminal.lua      # Integrated terminal
│       ├── treesitter.lua    # Syntax highlighting
│       ├── colorscheme.lua   # Catppuccin Mocha theme
│       └── dashboard.lua     # Welcome screen
└── lazy-lock.json            # Plugin version lockfile
```

## Customization

**Add an LSP server:** Edit the `servers` table and `ensure_installed` list in `lua/plugins/lsp.lua`.

**Add a formatter:** Edit `formatters_by_ft` in `lua/plugins/formatting.lua` and the `ensure_installed` list in mason-tool-installer.

**Change the colorscheme:** Update `lua/plugins/colorscheme.lua` and the lualine theme in `lua/plugins/ui.lua`.

**Toggle format on save:** Run `:ToggleFormatOnSave` in Neovim.

## License

MIT
