local remap = require("theprimeagen.keymap")
local nnoremap = remap.nnoremap
local inoremap = remap.inoremap
local vnoremap = remap.vnoremap
-- vim.opt.guicursor = ""

vim.opt.wrap = false
vim.opt.runtimepath:prepend('/home/venkatesh/.opam/default/share/ocp-indent/vim')

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartindent = true

nnoremap('<A-j>', ':m .+1<CR>==')
nnoremap('<A-k>', ':m .-2<CR>==')
inoremap('<A-j>', '<Esc>:m .+1<CR>==gi')
inoremap('<A-k>', '<Esc>:m .-2<CR>==gi')
vnoremap('<A-j>', ":m '>+1<CR>gv=gv")
vnoremap('<A-k>', ":m '<-2<CR>gv=gv")

