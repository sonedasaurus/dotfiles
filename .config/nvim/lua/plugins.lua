-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'execute plugin callbacks',
  callback = function(event)
    local data = event.data or {}
    local kind = data.kind or ''
    local callback = vim.tbl_get(data, 'spec', 'data', 'on_' .. kind)

    if type(callback) ~= 'function' then
      return
    end

    -- possible callbacks: on_install, on_update, on_delete
    local ok, err = pcall(callback, data)
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/nvim-mini/mini.nvim', version = 'main' },
  { src = 'https://github.com/VonHeikemen/ts-enable.nvim' },
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
    data = {
      on_update = function()
        vim.cmd('TSUpdate')
      end,
    },
  },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

-- ----------------------------------- --
-- Colorscheme
-- ----------------------------------- --

vim.cmd.colorscheme('tokyonight-night')

-- ----------------------------------- --
-- File Tree
-- ----------------------------------- --

require('neo-tree')

vim.keymap.set('n', '<C-n>', '<cmd>Neotree filesystem toggle left<CR>', { desc = 'Toggle file tree' })

-- ----------------------------------- --
-- Status Line
-- ----------------------------------- --

local statusline = require('mini.statusline')
statusline.setup({
  use_icons = vim.g.have_nerd_font,
})

statusline.section_location = function()
  return '%2l:%-2v'
end

-- ----------------------------------- --
-- Syntax Highlighting
-- ----------------------------------- --

local ts_parsers = {
  "bash",
  "dockerfile",
  "gitignore",
  "go",
  "html",
  "javascript",
  "json",
  "kotlin",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "sql",
  "swift",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

vim.g.ts_enable = {
  parsers = ts_parsers,
  auto_install = true,
  highlights = true,
}

-- ----------------------------------- --
-- LSP
-- ----------------------------------- --

vim.lsp.enable({
  'sourcekit',
  'kotlin_language_server',
  'gopls',
  'marksman',
  'pyright',
  'lua_ls',
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set({'n', 'x'}, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  end,
})
