-- local autocmd = vim.api.nvim_create_autocmd
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--
-- my settings
-- editor settings
vim.opt.rnu = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = false
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.lazyredraw = true

-- centering
vim.keymap.set('n', '<C-d>', ':normal! <C-d>zz<CR>', { noremap = true })
vim.keymap.set('n', 'n', 'nzz', { noremap = true })
vim.keymap.set('n', 'N', 'Nzz', { noremap = true })
vim.keymap.set('n', 'j', 'jzz', { noremap = true })
vim.keymap.set('n', 'k', 'kzz', { noremap = true })
vim.keymap.set('n', '*', '*zz', { noremap = true })
vim.keymap.set('n', '#', '#zz', { noremap = true })
vim.keymap.set('n', 'G', 'Gzz', { noremap = true })
vim.keymap.set('n', ';', ';', { noremap = true })

-- mappings
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })

-- telescope settings
-- local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', {})
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', {})
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', {})
vim.keymap.set('n', '<leader>fr', ':Far ', {})

-- auto correct
-- doesn't work
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"*.txt"},
  callback = function()
		vim.api.nvim_set_keymap('i', 'OT', 'Old Testament', { noremap = true })
		vim.api.nvim_set_keymap('i', 'NT', 'New Testament', { noremap = true })
		vim.api.nvim_set_keymap('i', 'HS', 'Holy Spirit', { noremap = true })
		vim.api.nvim_set_keymap('i', 'JC', 'Jesus Christ', { noremap = true })
  end
})

-- source custom commands

-- vim.cmd([[source ~/.config/nvim/lua/custom/my_commands.vim]])
-- vim.cmd([[source ~/.config/nvim/lua/custom/text_object_macros.vim]])

-- fold settings
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false

-- Netrw settings
vim.g.netrw_winsize = 50
vim.g.netrw_altv = 1

--#region
-- nnoremap <silent> <Find-Shortcut>  :Farf<cr>
-- vnoremap <silent> <Find-Shortcut>  :Farf<cr>
--
-- --# shortcut for far.vim replace
-- nnoremap <silent> <Replace-Shortcut>  :Farr<cr>
-- vnoremap <silent> <Replace-Shortcut>  :Farr<cr>

-- idk why nvchad disables semi-colon
vim.cmd([[
	nnoremap ; ;
]])

-- custom keybinding
vim.keymap.set({"n"}, "<leader>o", ":Telescope buffers<CR>", {desc = "Find Buffers"})
vim.keymap.set({"n"}, "<leader>o", ":Telescope buffers<CR>", {desc = "Find Buffers"})

vim.keymap.set({"n"}, "<C-h>", ":TmuxNavigateLeft<CR>", {desc = "window left"})
vim.keymap.set({"n"}, "<C-l>", ":TmuxNavigateRight<CR>", {desc = "window right"})
vim.keymap.set({"n"}, "<C-j>", ":TmuxNavigateDown<CR>", {desc = "window down"})
vim.keymap.set({"n"}, "<C-k>", ":TmuxNavigateUp<CR>", {desc = "window up"})

-- Map Alt+number to switch tmux windows
vim.keymap.set({"n"}, "<M-1>", ":1wincmd w<CR>", {desc = "Go to window 1"})
vim.keymap.set({"n"}, "<M-2>", ":2wincmd w<CR>", {desc = "Go to window 2"})
vim.keymap.set({"n"}, "<M-3>", ":3wincmd w<CR>", {desc = "Go to window 3"})
vim.keymap.set({"n"}, "<M-4>", ":4wincmd w<CR>", {desc = "Go to window 4"})
vim.keymap.set({"n"}, "<M-5>", ":5wincmd w<CR>", {desc = "Go to window 5"})
vim.keymap.set({"n"}, "<M-6>", ":6wincmd w<CR>", {desc = "Go to window 6"}) 
vim.keymap.set({"n"}, "<M-7>", ":7wincmd w<CR>", {desc = "Go to window 7"})
vim.keymap.set({"n"}, "<M-8>", ":8wincmd w<CR>", {desc = "Go to window 8"})
vim.keymap.set({"n"}, "<M-9>", ":9wincmd w<CR>", {desc = "Go to window 9"})
vim.keymap.set({"n"}, "<M-0>", ":10wincmd w<CR>", {desc = "Go to window 10"})


-- custom text object manipulation
dofile("/home/dgmastertemple/.config/nvim/lua/custom/custom_text_objects.lua")


-- vim.cmd [[ syntax include /home/dglinuxtemple/nvim/lua/custom/syntax/mt.vim ]]
-- vim.cmd [[ autocmd BufNewFile,BufRead *.mt set filetype=mt ]]

-- Initialize Lua in .vimrc
-- underline_preview.lua
local underline = vim.api.nvim_create_namespace("underline")

vim.cmd([[highlight Underlined term=underline cterm=underline]])

-- Lua function to underline selected text in Vim using an external command
function underlineSelected()
	vim.cmd([[
		if mode() ==# 'n'
			echo "Visual mode is not active."
		endif

		let save_reg = @"
		normal! gv"zy

		" Wrap the selected text with underline characters
		let underline_text = substitute(@z, '\%V', '_', 'g')
		call setreg('@', underline_text)

		" Paste the modified text back
		normal! gv"zp

		let @" = save_reg
	]])
end

 -- underline
vim.keymap.set("v", "<Leader>u", function()
  underlineSelected()
end, {silent = true, desc = "Underline text" })

function OpenPreview()
  local line = vim.api.nvim_get_current_line()
  local match = string.match(line, '<u>(.-)</u>')

  if match ~= nil then
    local win = vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
      relative = "botright",
      row = 1,
      col = 0,
      width = 30,
      height = 3,
      style = "minimal",
    })

    vim.api.nvim_buf_set_lines(0, 0, -1, false, {match})
  end
end

vim.keymap.set("n", "<C-k>", function()
  OpenPreview()
end, {silent = true})

-- require("oil").setup({})

vim.g.vimwiki_list = {
  { 
    syntax = 'markdown',
    ext = '.md'
  }
}

vim.api.nvim_create_user_command('ESV', function()
  local current_line = vim.fn.line('.')
  local line_text = vim.fn.getline('.')
  
  local shell_output = vim.fn.system({'/home/dglinuxtemple/Development/python/esv_cli/esv_master', line_text})
	local lines = vim.fn.split(shell_output, '\n')
	vim.api.nvim_put(lines, 'l', true, true)

  vim.fn.cursor(current_line, 0)
end, {nargs=0})

-- vim.cmd([[highlight Visual ctermbg=orange ctermfg=black guibg=orange guifg=black]])

-- table mode movement
vim.g.is_table_mode = true
vim.api.nvim_set_keymap('n', 'l', [[
  if vim.g.is_table_mode then
    vim.cmd('normal! f|l')
  else 
    vim.cmd('normal! l') 
  end
]], {noremap = true})
