-- 標準 LSP の設定。コマンドが入っているサーバーだけ有効にする
local servers = {
  gopls = "gopls",
  rust_analyzer = "rust-analyzer",
  ts_ls = "typescript-language-server",
  intelephense = "intelephense",
  pyright = "pyright-langserver",
}

vim.lsp.config("gopls", {
  settings = { gopls = { gofumpt = false, staticcheck = true } },
})

for name, cmd in pairs(servers) do
  if vim.fn.executable(cmd) == 1 then
    vim.lsp.enable(name)
  end
end

vim.diagnostic.config({ virtual_text = true, severity_sort = true })

-- 保存時の整形（旧 vim-go の goimports / rust.vim の rustfmt の置き換え）
local format_on_save = { go = true, rust = true }

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    local buf = args.buf
    local m = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
    end
    -- grn / gra / grr / gri / K は Neovim 0.11 の標準マッピングを使う
    m("gd", vim.lsp.buf.definition, "definition")

    if format_on_save[vim.bo[buf].filetype] and client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = buf,
        callback = function()
          if vim.bo[buf].filetype == "go" then
            -- goimports 相当: import の整理をしてから整形する
            local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
            params.context = { only = { "source.organizeImports" } }
            local res = client:request_sync("textDocument/codeAction", params, 1000, buf)
            for _, action in pairs(res and res.result or {}) do
              if action.edit then
                vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
              end
            end
          end
          vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 2000 })
        end,
      })
    end
  end,
})
