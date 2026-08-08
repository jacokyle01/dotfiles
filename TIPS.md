# TIPS

Hotkey reference for this config. Leader is `<Space>`, local leader is `\`.

## Go

Requires `gopls`, `gofumpt` and `goimports`, all installed automatically by
mason-tool-installer (`:MasonToolsUpdate` to refresh them by hand).

These maps only exist in `go` / `go.mod` / `go.work` buffers. Each `go ...`
command writes the buffer, then opens a terminal in a split at the bottom;
`i` to scroll/interact, `q` or `:bd!` to close it.

| Key          | Action                                     |
| ------------ | ------------------------------------------ |
| `<leader>gr` | `go run .`                                 |
| `<leader>gb` | `go build ./...`                           |
| `<leader>gt` | `go test ./...`                            |
| `<leader>gp` | `go test` on the current file's package    |
| `<leader>gv` | `go vet ./...`                             |
| `<leader>gm` | `go mod tidy`                              |
| `<leader>gi` | organize imports (gopls code action)       |
| `<leader>ga` | alternate between `foo.go` and `foo_test.go` |

Go buffers use real tabs (`noexpandtab`, width 4) instead of the global
3-space indent, since gofumpt writes tabs. Saving runs `goimports` then
`gofumpt`, so unused imports are dropped and missing ones added on write.

## LSP

Set on any buffer with a language server attached (Go, TS/JS/TSX, JSON).
Pickers open in Telescope.

| Key          | Action                              |
| ------------ | ----------------------------------- |
| `gd`         | goto definition                     |
| `gD`         | goto declaration                    |
| `gi`         | goto implementation                 |
| `gy`         | goto type definition                |
| `gr`         | references                          |
| `K` / `gh`   | hover docs                          |
| `<C-k>`      | signature help (normal and insert)  |
| `<leader>ca` | code action                         |
| `<leader>cr` | rename symbol                       |
| `<leader>cl` | run code lens                       |
| `<leader>cs` | document symbols                    |
| `<leader>cS` | workspace symbols                   |
| `<leader>ch` | toggle inlay hints                  |

### Diagnostics

| Key            | Action                     |
| -------------- | -------------------------- |
| `<leader>cd`   | line diagnostics in a float |
| `<leader>cq`   | send diagnostics to quickfix |
| `]d` / `[d`    | next / prev diagnostic     |
| `]e` / `[e`    | next / prev error          |
| `]w` / `[w`    | next / prev warning        |

## Find (Telescope)

| Key          | Action          |
| ------------ | --------------- |
| `<leader>ff` | find files      |
| `<leader>fg` | live grep       |
| `<leader>fb` | buffers         |
| `<leader>fh` | help tags       |

Inside a picker: `<C-j>` / `<C-k>` move the selection, `<esc>` closes it.

## Files and buffers

| Key           | Action                        |
| ------------- | ----------------------------- |
| `<leader>e`   | toggle focus: file tree / editor |
| `<leader>E`   | file tree at cwd              |
| `<S-h>` / `[b` | previous buffer              |
| `<S-l>` / `]b` | next buffer                  |
| `<leader>bd`  | delete buffer                 |
| `<leader>bo`  | delete other buffers          |
| `<leader>bh` / `<leader>bl` | delete buffers left / right |
| `<leader>bH` / `<leader>bL` | move buffer left / right |
| `<leader>bp`  | pin buffer                    |

In the file tree: `a` add file, `A` add directory, `d` delete, `r` rename,
`y`/`x`/`p` copy/cut/paste, `H` toggle hidden, `z` collapse all, `?` help.

## Editing

| Key                | Action                        |
| ------------------ | ----------------------------- |
| `<A-j>` / `<A-k>`  | move line or selection down / up (normal, insert, visual) |

## Plugin and tool management

| Command            | Action                          |
| ------------------ | ------------------------------- |
| `:Lazy`            | plugin manager                  |
| `:Mason`           | LSP / formatter installer       |
| `:MasonToolsUpdate`| install or update the pinned tools |
| `:LspInfo`         | which servers are attached here |
| `:ConformInfo`     | which formatters ran, and why   |
| `:TSUpdate`        | update treesitter parsers       |
