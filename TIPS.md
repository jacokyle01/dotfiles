# TIPS

Hotkey reference for this config. Leader is `<Space>`, local leader is `\`.

## Go

Requires `gopls`, `gofumpt` and `goimports`, all installed automatically by
mason-tool-installer (`:MasonToolsUpdate` to refresh them by hand).

These maps only exist in `go` / `go.mod` / `go.work` buffers. Each `go ...`
command writes the buffer, then opens a terminal in a split at the bottom;
`i` to scroll/interact, `q` or `:bd!` to close it.

| Key          | Action                                       |
| ------------ | -------------------------------------------- |
| `<leader>gr` | `go run .`                                   |
| `<leader>gb` | `go build ./...`                             |
| `<leader>gt` | `go test ./...`                              |
| `<leader>gp` | `go test` on the current file's package      |
| `<leader>gv` | `go vet ./...`                               |
| `<leader>gm` | `go mod tidy`                                |
| `<leader>gi` | organize imports (gopls code action)         |
| `<leader>ga` | alternate between `foo.go` and `foo_test.go` |

Go buffers use real tabs (`noexpandtab`, width 4) instead of the global
3-space indent, since gofumpt writes tabs. Saving runs `goimports` then
`gofumpt`, so unused imports are dropped and missing ones added on write.

## TypeScript / web

Servers, all installed by mason-tool-installer:

| Server                  | Attaches to                                       |
| ----------------------- | ------------------------------------------------- |
| `ts_ls`                 | `.ts` `.tsx` `.js` `.jsx`                         |
| `eslint`                | same, but only in a project with an eslint config |
| `html`, `cssls`         | `.html`, `.css` / `.scss` / `.less`               |
| `emmet_language_server` | html, css family, and jsx/tsx                     |
| `tailwindcss`           | only when a `tailwind.config.*` is found          |
| `jsonls`, `yamlls`      | `.json` / `.yaml`, with SchemaStore schemas       |

These maps only exist in ts/tsx/js/jsx buffers:

| Key          | Action                                   |
| ------------ | ---------------------------------------- |
| `<leader>ti` | organize imports                         |
| `<leader>tm` | add missing imports                      |
| `<leader>tu` | remove unused                            |
| `<leader>tf` | fix all fixable ts problems              |
| `<leader>te` | `:EslintFixAll` — apply eslint autofixes |

Emmet expansions (`div.card>ul>li*3`, `a:link`) come through as a normal
completion item: type the abbreviation and accept the completion.

SchemaStore means `package.json`, `tsconfig.json`, GitHub workflow files and
similar get key completion and validation for free.

Prettierd formats ts/tsx/js/jsx, html, css/scss/less, json/jsonc, yaml and
markdown on save; it picks up the project's own prettier config. Eslint
autofixes are _not_ applied on save — use `<leader>te` for those.

## LSP

Set on any buffer with a language server attached (Go, TS/JS/TSX, HTML/CSS,
JSON/YAML). Pickers open in Telescope.

| Key          | Action                             |
| ------------ | ---------------------------------- |
| `gd`         | goto definition                    |
| `gD`         | goto declaration                   |
| `gi`         | goto implementation                |
| `gy`         | goto type definition               |
| `gr`         | references                         |
| `K` / `gh`   | hover docs                         |
| `<C-k>`      | signature help (normal and insert) |
| `<leader>ca` | code action                        |
| `<leader>cr` | rename symbol                      |
| `<leader>cl` | run code lens                      |
| `<leader>cs` | document symbols                   |
| `<leader>cS` | workspace symbols                  |
| `<leader>ch` | toggle inlay hints                 |

### Diagnostics

| Key          | Action                       |
| ------------ | ---------------------------- |
| `<leader>cd` | line diagnostics in a float  |
| `<leader>cq` | send diagnostics to quickfix |
| `]d` / `[d`  | next / prev diagnostic       |
| `]e` / `[e`  | next / prev error            |
| `]w` / `[w`  | next / prev warning          |

## Find (Telescope)

| Key          | Action                                |
| ------------ | ------------------------------------- |
| `<leader>ff` | find files                            |
| `<leader>fg` | live grep                             |
| `<leader>fb` | buffers                               |
| `<leader>fh` | help tags                             |
| `<leader>fa` | find files, including gitignored ones |

Inside a picker: `<C-j>` / `<C-k>` move the selection, `<esc>` closes it.

### Why a file might not show up

Telescope shells out to `fd` and `rg`, and both skip two categories by
default:

1. **Dotfiles** — `.env.example`, `.github/`, `.gitignore`. Fixed here:
   `find_files` runs with `hidden = true` and `rg` with `--hidden`, so these
   now appear in both file search and grep.
2. **Anything in `.gitignore`** — `.env`, `dist/`, `.next/`. Still skipped on
   purpose, because otherwise every build artifact floods the results. Use
   `<leader>fa` to search those too.

So `.env` needs `<leader>fa`, while `.env.example` shows up in plain
`<leader>ff`. `node_modules` and `.git/` are filtered out of every picker
regardless.

## Files and buffers

| Key                         | Action                           |
| --------------------------- | -------------------------------- |
| `<leader>e`                 | toggle focus: file tree / editor |
| `<leader>E`                 | file tree at cwd                 |
| `<S-h>` / `[b`              | previous buffer                  |
| `<S-l>` / `]b`              | next buffer                      |
| `<leader>bd`                | delete buffer                    |
| `<leader>bo`                | delete other buffers             |
| `<leader>bh` / `<leader>bl` | delete buffers left / right      |
| `<leader>bH` / `<leader>bL` | move buffer left / right         |
| `<leader>bp`                | pin buffer                       |

## File explorer (neo-tree)

`<leader>e` toggles focus between the tree and the editor, so it is a jump
key, not just an open key. `<leader>E` opens the tree rooted at the cwd.

This config sets `use_default_mappings = false`, so the only keys that exist
inside the tree are the ones below — plus ordinary Vim motions, which still
work because the tree is a normal buffer. `j`/`k`, `/` search, `gg`/`G` and
`<C-u>`/`<C-d>` all behave as usual.

| Key         | Action                                           |
| ----------- | ------------------------------------------------ |
| `<cr>`, `t` | open file / expand directory                     |
| `C`         | collapse the node under the cursor               |
| `z`         | collapse everything                              |
| `P`         | toggle a floating preview of the file            |
| `l`         | jump into that preview window                    |
| `<esc>`     | dismiss the preview                              |
| `a`         | add a file (end the name with `/` to make a dir) |
| `A`         | add a directory                                  |
| `r`         | rename                                           |
| `d`         | delete                                           |
| `c` / `m`   | copy / move (prompts for the destination)        |
| `y` / `x`   | copy / cut to the tree's clipboard               |
| `p`         | paste whatever was yanked or cut                 |
| `H`         | toggle gitignored files (dotfiles always show)   |
| `R`         | refresh the tree                                 |
| `q`         | close the tree                                   |
| `?`         | show all mappings                                |
| `<` / `>`   | previous / next source (files, buffers, git)     |

`<` and `>` cycle the three sources: the filesystem tree, the open buffers,
and git status — the last is a quick way to see everything you have changed.

Empty nested directories are collapsed into a single row (`a/b/c`), and
sorting is case-insensitive.

## Editing

| Key               | Action                                                    |
| ----------------- | --------------------------------------------------------- |
| `<A-j>` / `<A-k>` | move line or selection down / up (normal, insert, visual) |

## Plugin and tool management

| Command             | Action                             |
| ------------------- | ---------------------------------- |
| `:Lazy`             | plugin manager                     |
| `:Mason`            | LSP / formatter installer          |
| `:MasonToolsUpdate` | install or update the pinned tools |
| `:LspInfo`          | which servers are attached here    |
| `:ConformInfo`      | which formatters ran, and why      |
| `:TSUpdate`         | update treesitter parsers          |
