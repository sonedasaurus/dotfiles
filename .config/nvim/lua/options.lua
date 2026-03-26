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

-- Decrease update time
vim.o.updatetime = 300

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 500

-- Show which line your cursor is on
vim.o.cursorline = true

-- Show tab characters so indentation is easier to spot.
vim.o.list = true
vim.opt.listchars = { tab = '» ' }

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'gy', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x'}, 'gp', '"+p', {desc = 'Paste clipboard content'})
