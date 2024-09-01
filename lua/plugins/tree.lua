return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x", -- Use the latest version
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
      "MunifTanjim/nui.nvim",
    },
    keys = function()
      return {
        {
          "<space>e",
          function()
            -- Replacing lazyvim.util with vim.fn.getcwd() for the root directory
            require("neo-tree.command").execute({ dir = vim.fn.getcwd() })
          end,
          desc = "Explorer NeoTree (root dir)",
        },
        {
          "<space>E",
          function()
            require("neo-tree.command").execute({ dir = vim.loop.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
      }
    end,
    opts = function(_, opts)
      opts.use_default_mappings = false
      opts.window.mappings = {
        -- ["<space>"] = "toggle_node",
        ["<cr>"] = "open",
        ["<esc>"] = "revert_preview",
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["l"] = "focus_preview",
        -- ["S"] = "open_split",
        -- ["s"] = "open_vsplit",
        -- ["t"] = "open_tabnew",
        -- ["w"] = "open_with_window_picker",
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        ["a"] = {
          "add",
          config = {
            show_path = "none", -- "none", "relative", "absolute"
          },
        },
        ["A"] = "add_directory", 
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", 
        ["m"] = "move",
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
        ["H"] = "toggle_hidden",
      }
      opts.filesystem.filtered_items = { always_show = { "application.conf" } }
      opts.filesystem.group_empty_dirs = true 
      opts.sort_case_insensitive = true
    end,
  },
}
