return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    -- keeps the language servers and formatters below installed automatically
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "gopls",
        "gofumpt",
        "goimports",
        "typescript-language-server",
        "prettierd",
      },
      run_on_start = true,
    },
  },
}
