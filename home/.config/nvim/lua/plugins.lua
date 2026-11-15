return {
  {
    "junegunn/seoul256.vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.seoul256_background = 233
      vim.cmd.colorscheme("seoul256")
      vim.api.nvim_set_hl(0, "CursorLine", { fg = "#E19972" })
    end,
  },

  { "tpope/vim-fugitive", lazy = false },
  { "tpope/vim-surround", event = "VeryLazy" },
  -- コメントアウトは Neovim 標準の gc / gcc を使う

  -- ファイル・バッファ・grep 検索（旧 ctrlp の置き換え。キーはそのまま）
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<C-u><C-p>", "<Cmd>FzfLua files<CR>", desc = "files" },
      { "<C-u><C-u>", "<Cmd>FzfLua oldfiles<CR>", desc = "recent files" },
      { "<C-u><C-b>", "<Cmd>FzfLua buffers<CR>", desc = "buffers" },
      { "<C-u><C-l>", "<Cmd>FzfLua blines<CR>", desc = "lines" },
      { "<C-u><C-g>", "<Cmd>FzfLua live_grep<CR>", desc = "grep" },
    },
    opts = {},
  },

  -- 補完（旧 deoplete / ultisnips の置き換え）
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = { preset = "default" },
      completion = { documentation = { auto_show = true } },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
  },

  -- LSP の各サーバー設定（vim.lsp.config 用の lsp/*.lua を提供）
  { "neovim/nvim-lspconfig", lazy = false },

  {
    "mattn/emmet-vim",
    ft = { "eruby", "html", "gohtmltmpl", "vue" },
    init = function()
      vim.g.use_emmet_complete_tag = 1
      vim.g.user_emmet_settings = { lang = "ja", html = { indentation = "  " } }
    end,
  },

  {
    "junegunn/vim-easy-align",
    cmd = "EasyAlign",
    keys = {
      { "<Enter>", "<Plug>(EasyAlign)", mode = "x" },
      { "<Leader>a", "<Plug>(EasyAlign)", mode = "n" },
    },
  },

  {
    "previm/previm",
    ft = "markdown",
    init = function()
      vim.g.previm_show_header = 0
      vim.g.previm_open_cmd = "open"
    end,
  },
}
