return {
  -- Your other plugins
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- This ensures that Tree-sitter parsers are installed/updated automatically
    event = { "BufReadPost", "BufNewFile" }, -- Lazy load on file open
    opts = {
      ensure_installed = { "lua", "javascript", "typescript", "html", "css" }, -- Add the languages you work with
      highlight = {
        enable = true, -- Enable Tree-sitter-based syntax highlighting
      },
      indent = {
        enable = true, -- Enable Tree-sitter-based indentation
      },
    },
  },
}
