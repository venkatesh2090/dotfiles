local remap = require("theprimeagen.keymap")
local nnoremap = remap.nnoremap
local inoremap = remap.inoremap
local vnoremap = remap.vnoremap

nnoremap('<A-j>', ':m .+1<CR>==')
nnoremap('<A-k>', ':m .-2<CR>==')
inoremap('<A-j>', '<Esc>:m .+1<CR>==gi')
inoremap('<A-k>', '<Esc>:m .-2<CR>==gi')
vnoremap('<A-j>', ":m '>+1<CR>gv=gv")
vnoremap('<A-k>', ":m '<-2<CR>gv=gv")
nnoremap('<C-l>', 'gt')
nnoremap('<C-j>', 'gT')
vnoremap('<C-l>', ':tabnext<CR>')
vnoremap('<C-j>', ':tabprevious<CR>')
nnoremap('<C-n>', ':tabnew ')
inoremap('<C-n>', ':tabnew ')
vnoremap('<C-n>', ':tabnew ')

