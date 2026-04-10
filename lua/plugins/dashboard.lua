-- Dashboard (like VSCode Welcome tab)
return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    theme = "doom",
    config = {
      header = {
        "",
        "",
        " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
        " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
        " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
        " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
        " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
        " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
        "",
        "",
      },
      center = {
        { action = "Telescope find_files", desc = " Find File", icon = " ", key = "f" },
        { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
        { action = "Telescope oldfiles", desc = " Recent Files", icon = " ", key = "r" },
        { action = "Telescope live_grep", desc = " Find Word", icon = " ", key = "w" },
        { action = "e $MYVIMRC", desc = " Config", icon = " ", key = "c" },
        { action = "Lazy", desc = " Plugins", icon = " ", key = "p" },
        { action = "qa", desc = " Quit", icon = " ", key = "q" },
      },
      footer = function()
        local stats = require("lazy").stats()
        return { "Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins" }
      end,
    },
  },
}
