-- Neovim 0.11+ 用の設定（lazy.nvim + 標準 LSP）

-- options {{{
local opt = vim.opt
opt.fileencodings = { "utf-8", "iso-2022-jp", "euc-jp", "sjis", "cp932" }
opt.fileformats = { "unix", "dos", "mac" }
opt.termguicolors = true
opt.backup = false
opt.swapfile = false
opt.matchpairs:append("<:>")
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true
opt.wrap = false
opt.clipboard:append("unnamedplus")
opt.shiftround = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.expandtab = true
opt.foldmethod = "syntax"
opt.foldlevelstart = 99
opt.spelllang = { "en", "cjk" }
opt.timeoutlen = 500
opt.ttimeoutlen = 50
opt.wildignore:append({ "*/tmp/*", "*.so", "*.swp", "*.zip" })
opt.nrformats = "hex"
opt.mouse = "a"
opt.signcolumn = "yes"
opt.statusline = "%<%t %y%h%w%m%r%{exists('*FugitiveStatusline')?FugitiveStatusline():''}%=%-14.(%l,%c%V%) [%{&fileencoding!=''?&fileencoding:&encoding}] %P"
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case --hidden"
  opt.grepformat = "%f:%l:%c:%m"
end
-- }}}

-- key mappings {{{
local map = vim.keymap.set
map("n", "<Esc><Esc>", "<Cmd>nohlsearch<CR><Esc>")
map({ "n", "v" }, "<Tab>", "%", { remap = true })
map("n", "c]", "<Cmd>cnext<CR>", { silent = true })
map("n", "c[", "<Cmd>cprevious<CR>", { silent = true })
map("t", "<Esc>", [[<C-\><C-n>]])
-- }}}

-- lazy.nvim {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "lazy.nvim の取得に失敗しました:\n" .. out, "ErrorMsg" } }, true, {})
    return
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  install = { colorscheme = { "seoul256" } },
  change_detection = { notify = false },
  rocks = { enabled = false },
})
-- }}}

require("lsp")
