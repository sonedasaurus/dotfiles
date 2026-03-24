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
  { src = 'https://github.com/neovim/nvim-lspconfig' },
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
  { src = 'https://github.com/nvim-mini/mini.nvim', version = 'main' },
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

-- ----------------------------------- --
-- Colorscheme
-- ----------------------------------- --

vim.cmd.colorscheme('tokyonight-night')

-- ----------------------------------- --
-- File Explorer
-- ----------------------------------- --

local mini_files = require('mini.files')
mini_files.setup({
  mappings = {
    go_in_plus = '',
  },
})

vim.keymap.set('n', '<leader>e', function()
  if mini_files.close() then
    return
  end

  mini_files.open()
end, { desc = 'File explorer' })

-- Split windows from the file explorer
local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    local cur_target = MiniFiles.get_explorer_state().target_window
    local new_target

    vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. ' split')
      new_target = vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target)
    MiniFiles.go_in()
  end

  vim.keymap.set('n', lhs, rhs, {
    buffer = buf_id,
    desc = 'Split ' .. direction,
  })
end

-- Only open files with Enter in the file explorer
local map_go_in = function(buf_id, lhs, fs_type, desc)
  vim.keymap.set('n', lhs, function()
    local fs_entry = mini_files.get_fs_entry()
    if fs_entry == nil or fs_entry.fs_type ~= fs_type then
      return
    end

    mini_files.go_in()
  end, {
    buffer = buf_id,
    desc = desc,
  })
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    map_go_in(buf_id, 'l', 'directory', 'Open directory')
    map_go_in(buf_id, '<CR>', 'file', 'Open file')
    map_split(buf_id, 'gs', 'belowright horizontal')
    map_split(buf_id, 'gv', 'belowright vertical')
  end,
})

-- ----------------------------------- --
-- Status Line
-- ----------------------------------- --

require('mini.statusline').setup({})

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
