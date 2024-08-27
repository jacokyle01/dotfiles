return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope')

      telescope.setup{
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = " ",
          path_display = { "truncate" },
          file_ignore_patterns = { "node_modules", ".git/" },
          mappings = {
            i = {
              ["<C-j>"] = require('telescope.actions').move_selection_next,
              ["<C-k>"] = require('telescope.actions').move_selection_previous,
            },
          },
          layout_config = {
            horizontal = {
              preview_width = 0.6,  -- Width of the preview area (60% of total width)
              prompt_position = "top",  -- Position of the prompt at the top
              results_width = 0.8,  -- Width of the results area (80% of total width)
            },
            vertical = {
              mirror = false,  -- Set to true to mirror the vertical layout (optional)
            },
          },
        },
        pickers = {
          find_files = {
            layout_config = {
              horizontal = {
                preview_width = 0.5,  -- Adjust the preview width for find_files
                results_width = 0.9,  -- Adjust the results width for find_files
              },
            },
          },
          live_grep = {
            layout_config = {
              horizontal = {
                preview_width = 0.5,  -- Adjust the preview width for live_grep
                results_width = 0.9,  -- Adjust the results width for live_grep
              },
            },
          },
        },
      }

      -- Key bindings for Telescope commands
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind with [G]rep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp tags' })
    end
  }
}

