-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

-- Space as leader key
vim.g.mapleader = vim.keycode('<Space>')

-- Set to true if your terminal is using a Nerd Font.
vim.g.have_nerd_font = false

-- Make line numbers default
vim.o.number = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Force use spaces instead of tabs
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Show tab characters so indentation is easier to spot.
vim.o.list = true
vim.opt.listchars = { tab = '» ' }

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'gy', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x'}, 'gp', '"+p', {desc = 'Paste clipboard content'})
