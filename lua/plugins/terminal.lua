-- Terminal (like VSCode integrated terminal)
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<C-`>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = "horizontal", -- like VSCode bottom panel
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "rounded",
      winblend = 0,
    },
  },
}
