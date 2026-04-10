-- Neovim Configuration - VSCode-like experience
-- ================================================

-- Load core settings first
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Bootstrap and load plugins via lazy.nvim
require("config.lazy")
