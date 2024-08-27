return {
	--TODO: don't do this in /plugins ? 
  {
    'rebelot/kanagawa.nvim',
    priority = 1000, -- Ensure the colorscheme loads early
    config = function()
      vim.cmd([[colorscheme kanagawa]]) -- Set Kanagawa as the active colorscheme
    end,
  },
}

