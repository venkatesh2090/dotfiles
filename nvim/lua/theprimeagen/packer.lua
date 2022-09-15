-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim'
  use 'neovim/nvim-lspconfig'
  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  use { 'ms-jpq/coq.thirdparty', branch = '3p' }
  use 'jubnzv/virtual-types.nvim'
  use 'ray-x/lsp_signature.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nkrkv/nvim-treesitter-rescript'
  use 'rescript-lang/vim-rescript'

end)
