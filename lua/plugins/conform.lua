return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      typescript = { "prettierd" },  -- runs prettierd for TS
      typescriptreact = { "prettierd" }, -- also for TSX
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      markdown = { "prettierd" },
      ["markdown.mdx"] = { "prettierd" },
    },
    format_on_save = {
      lsp_fallback = true,  -- fallback to LSP if no formatter found
      timeout_ms = 500,     -- adjust if formatting is slow
    },
  },
}
