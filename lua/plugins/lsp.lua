return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    -- Go
    lspconfig.gopls.setup({
      settings = {
        gopls = {
          gofumpt = true,
          staticcheck = true,
          usePlaceholders = true, -- fill function signatures on completion
          completeUnimported = true, -- offer symbols from packages not yet imported
          semanticTokens = true,
          analyses = {
            unusedparams = true,
            unusedwrite = true,
            nilness = true,
            shadow = true,
            useany = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          codelenses = {
            gc_details = true,
            generate = true,
            regenerate_cgo = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
        },
      },
    })

    -- TypeScript / JavaScript / TSX / JSX
    lspconfig.ts_ls.setup({
      filetypes = {
        "javascript", "javascriptreact",
        "typescript", "typescriptreact", -- <- this covers .tsx
        "json"
      },
    })

    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = true },
      virtual_text = { spacing = 2, prefix = "●" },
    })

    -- jump helpers that work on both the 0.10 and 0.11+ diagnostic APIs
    local function diagnostic_goto(next, severity)
      severity = severity and vim.diagnostic.severity[severity] or nil
      return function()
        if vim.diagnostic.jump then
          vim.diagnostic.jump({ count = next and 1 or -1, severity = severity, float = true })
        else
          local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
          go({ severity = severity, float = true })
        end
      end
    end

    -- keymaps shared by every language server, set per buffer once it attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local buf = event.buf
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = "LSP: " .. desc })
        end
        local builtin = require("telescope.builtin")

        map("n", "gd", builtin.lsp_definitions, "[G]oto [D]efinition")
        map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("n", "gi", builtin.lsp_implementations, "[G]oto [I]mplementation")
        map("n", "gy", builtin.lsp_type_definitions, "[G]oto t[y]pe definition")
        map("n", "gr", builtin.lsp_references, "[G]oto [R]eferences")
        map("n", "gh", vim.lsp.buf.hover, "[H]over docs")
        map("n", "K", vim.lsp.buf.hover, "Hover docs")
        map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature help")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("n", "<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
        map({ "n", "x" }, "<leader>cl", vim.lsp.codelens.run, "Run [C]ode[L]ens")
        map("n", "<leader>cs", builtin.lsp_document_symbols, "[C]ode [S]ymbols (buffer)")
        map("n", "<leader>cS", builtin.lsp_dynamic_workspace_symbols, "[C]ode [S]ymbols (workspace)")

        map("n", "<leader>cd", vim.diagnostic.open_float, "Line [D]iagnostics")
        map("n", "<leader>cq", vim.diagnostic.setqflist, "Diagnostics to [Q]uickfix")
        map("n", "]d", diagnostic_goto(true), "Next diagnostic")
        map("n", "[d", diagnostic_goto(false), "Prev diagnostic")
        map("n", "]e", diagnostic_goto(true, "ERROR"), "Next error")
        map("n", "[e", diagnostic_goto(false, "ERROR"), "Prev error")
        map("n", "]w", diagnostic_goto(true, "WARN"), "Next warning")
        map("n", "[w", diagnostic_goto(false, "WARN"), "Prev warning")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map("n", "<leader>ch", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
          end, "Toggle inlay [H]ints")
        end
      end,
    })

    -- Go specific keymaps, only in Go buffers
    local function go_cmd(cmd)
      return function()
        vim.cmd("write")
        vim.cmd("botright 15split | terminal " .. cmd)
        vim.cmd("startinsert")
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go", "gomod", "gowork" },
      callback = function(event)
        -- Go is formatted with real tabs, so the global expandtab is wrong here
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.shiftwidth = 4

        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = "Go: " .. desc })
        end

        map("<leader>gr", go_cmd("go run ."), "[R]un package")
        map("<leader>gb", go_cmd("go build ./..."), "[B]uild all")
        map("<leader>gt", go_cmd("go test ./..."), "[T]est all")
        map("<leader>gp", function()
          go_cmd("go test " .. vim.fn.fnameescape(vim.fn.expand("%:p:h")))()
        end, "Test current [P]ackage")
        map("<leader>gv", go_cmd("go vet ./..."), "Go [V]et")
        map("<leader>gm", go_cmd("go mod tidy"), "Go [M]od tidy")

        map("<leader>gi", function()
          vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports" }, diagnostics = {} },
            apply = true,
          })
        end, "Organize [I]mports")

        -- jump between foo.go and foo_test.go
        map("<leader>ga", function()
          local file = vim.fn.expand("%:p")
          local other = file:match("_test%.go$") and file:gsub("_test%.go$", ".go") or file:gsub("%.go$", "_test.go")
          vim.cmd.edit(vim.fn.fnameescape(other))
        end, "[A]lternate test/impl file")
      end,
    })
  end,
}
