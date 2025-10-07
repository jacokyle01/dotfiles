return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    -- Go
    lspconfig.gopls.setup({})

    -- TypeScript / JavaScript / TSX / JSX
    lspconfig.tsserver.setup({
      filetypes = {
        "javascript", "javascriptreact",
        "typescript", "typescriptreact", -- <- this covers .tsx
        "json"
      },
    })
  end,
}
