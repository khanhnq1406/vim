#!/bin/bash
# Neovim VSCode-like Configuration Setup
# ========================================

set -e

echo "Setting up Neovim with VSCode-like configuration..."
echo ""

# Install Neovim
if ! command -v nvim &>/dev/null; then
  echo "[1/5] Installing Neovim..."
  brew install neovim
else
  echo "[1/5] Neovim already installed ($(nvim --version | head -1))"
fi

# Install dependencies
echo "[2/5] Installing dependencies..."
brew install ripgrep fd lazygit 2>/dev/null || true

# Install Nerd Font (required for icons)
echo "[3/5] Installing Nerd Font..."
brew tap homebrew/cask-fonts 2>/dev/null || true
brew install --cask font-jetbrains-mono-nerd-font 2>/dev/null || true

# Backup existing config
echo "[4/5] Setting up config..."
if [ -d "$HOME/.config/nvim" ] || [ -L "$HOME/.config/nvim" ]; then
  echo "  Backing up existing config to ~/.config/nvim.bak"
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak.$(date +%s)"
fi

# Create symlink
mkdir -p "$HOME/.config"
ln -sf "$(pwd)" "$HOME/.config/nvim"
echo "  Linked $(pwd) -> ~/.config/nvim"

# First launch message
echo "[5/5] Done!"
echo ""
echo "================================================"
echo " Setup complete! Next steps:"
echo "================================================"
echo ""
echo " 1. Set your terminal font to 'JetBrainsMono Nerd Font'"
echo "    (required for icons to display correctly)"
echo ""
echo " 2. Launch Neovim:"
echo "    $ nvim"
echo ""
echo " 3. On first launch, Lazy.nvim will auto-install all plugins."
echo "    Wait for it to finish, then restart Neovim."
echo ""
echo " 4. Mason will auto-install LSP servers and formatters."
echo "    Run :Mason to see progress."
echo ""
echo "================================================"
echo " Key VSCode-like shortcuts:"
echo "================================================"
echo " Ctrl+P         Find file"
echo " Ctrl+Shift+F   Search in files"
echo " Ctrl+Shift+P   Command palette"
echo " Ctrl+B         Toggle file explorer"
echo " Ctrl+\`         Toggle terminal"
echo " Ctrl+S         Save"
echo " Ctrl+/         Toggle comment"
echo " Ctrl+D         Multi-cursor (select next occurrence)"
echo " Alt+Up/Down    Move line up/down"
echo " Shift+Alt+F    Format document"
echo " Space+gg       Open LazyGit"
echo " gd             Go to definition"
echo " K              Hover info"
echo "================================================"
