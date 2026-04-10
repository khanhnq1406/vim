-- Formatting (Prettier, Black, etc. - like VSCode format extensions)
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          javascriptreact = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          css = { "prettierd", "prettier", stop_after_first = true },
          scss = { "prettierd", "prettier", stop_after_first = true },
          html = { "prettierd", "prettier", stop_after_first = true },
          json = { "prettierd", "prettier", stop_after_first = true },
          jsonc = { "prettierd", "prettier", stop_after_first = true },
          yaml = { "prettierd", "prettier", stop_after_first = true },
          markdown = { "prettierd", "prettier", stop_after_first = true },
          graphql = { "prettierd", "prettier", stop_after_first = true },
          lua = { "stylua" },
          python = { "black" },
          go = { "goimports", "gofmt" },
          rust = { "rustfmt" },
          sh = { "shfmt" },
          ["_"] = { "trim_whitespace" },
        },
        format_on_save = function()
          if vim.g.format_on_save then
            return { timeout_ms = 500, lsp_fallback = true }
          end
        end,
      })
    end,
  },

  -- Mason tool installer (auto-install formatters & linters)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "prettier",
        "prettierd",
        "stylua",
        "black",
        "shfmt",
        "eslint_d",
      },
      auto_update = true,
      run_on_start = true,
    },
  },
}
