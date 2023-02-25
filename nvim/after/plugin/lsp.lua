local lsp = require'lspconfig'
local coq = require'coq'
local lsp_util = require'lspconfig.util'
local virtualtypes = require'virtualtypes'

require('coq_3p') {
  { src = 'bc', short_name = 'MATHS', precision = 6 },
  { src = 'figlet', short_name = 'BIG', trigger = '!big' }
}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local on_attach = function(client, bufnr)
  if client.config.root_dir == nil then
    print('no workspace found')
  end
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local sig_cfg = {
    bind = true,
    handler_opts = {
      border = 'rounded'
    },
    toggle_key = '<C-h>'
  }


  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

  virtualtypes.on_attach(client, bufnr)
end

lsp.pyright.setup(coq.lsp_ensure_capabilities {
  on_attach = on_attach
})

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

lsp.jdtls.setup(coq.lsp_ensure_capabilities {
  on_attach = on_attach,
  cmd = {
    'java', -- or '/path/to/java17_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:/home/venkatesh/.local/share/nvim/lsp/jdt-language-server/lombok.jar',

    -- 💀
    '-jar', '/home/venkatesh/.local/share/nvim/lsp/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
         -- Must point to the                                                     Change this to
         -- eclipse.jdt.ls installation                                           the actual version


    -- 💀
    '-configuration', '/home/venkatesh/.local/share/nvim/lsp/jdt-language-server/config_linux',
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data', '/home/venkatesh/.jdtls-workspace/' .. project_name
  },
  root_dir = require('lspconfig.util').root_pattern('settings.gradle.kts', 'settings.gradle', 'pom.xml', '.git')
})

lsp.ocamllsp.setup(coq.lsp_ensure_capabilities {
  on_attach = on_attach
})

lsp.clangd.setup(coq.lsp_ensure_capabilities{
  on_attach = on_attach
})

lsp.rescriptls.setup(coq.lsp_ensure_capabilities {
  cmd = {
    'node',
    '/home/venkatesh/.local/share/nvim/site/pack/packer/start/vim-rescript/server/out/server.js',
    '--stdio'
  },
  root_dir = lsp_util.root_pattern( 'bsconfig.json' )
})

