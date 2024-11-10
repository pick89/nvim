vim.cmd("let g:netrw_liststyle =3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 --2 spaces for tabs (prettier by default)
opt.shiftwidth = 2 --2 spaces for indent width
opt.expandtab = true --expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one 

opt.wrap = false 

-- search settings
vim.opt.ignorecase = true --ignore case when searching
vim.opt.smartcase = true --if include mixed case in your search, assumes you want case-sensitive:

opt.cursorline = true

--backspace 
opt.backspace = "indent,eol,start" --allow backspace on indent , end of line or insert mode in start position 

--clipboard 
opt.clipboard:append("unnamedplus")--use system clipboard as default register

--split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom 

-- color terminal 
opt.termguicolors = true 
opt.background = "dark" -- colorschemes that can be light or dark 
opt.signcolumn = "yes" --show sign columns so that text doesn't shift  
