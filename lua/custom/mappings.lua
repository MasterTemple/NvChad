---@type MappingsTable
local M = {}

M.general = {
  n = {
		-- tmux navigation
		["<C-h>"] = { ":TmuxNavigateLeft<CR>", "window left"},
		["<C-l>"] = { ":TmuxNavigateRight<CR>", "window right"},
		["<C-j>"] = { ":TmuxNavigateDown<CR>", "window down"},
		["<C-k>"] = { ":TmuxNavigateUp<CR>", "window up"},
		["<S-h>"] = { ":bprev<CR>", "Previous tab"},
		["<S-l>"] = { ":bnext<CR>", "Next tab"},
		["<M-h>"] = { ":silent !tmux previous-window<CR>", "Previous window"},
		["<M-l>"] = { ":silent !tmux next-window<CR>", "Next window"},
		["<C-t>"] = { ":silent !tmux new-window<CR>", "New window"},
		-- verse insertion
		["@v"] = { ":ESV<CR>", "Get ESV Verse"},
		-- table movement
		['l'] = {
			function()
				if vim.b.table_mode_active == 1 then 
					vim.cmd('normal! f|2l')
				else
					vim.cmd('normal! l')  
				end
			end,
			"Table move right"
	 	},
		-- table movement
		['h'] = {
			function()
				if vim.b.table_mode_active == 1 then 
					vim.cmd('normal! 2F|2l')
				else
					vim.cmd('normal! h')  
				end
			end,
			"Table move right"
	 	},
		-- 
		-- ["<leader>tm"] = { ":lua require(\"table-mode\").toggle()<CR>", "New window"},
		-- ["<Tab>"] = { ":Telescope buffers<CR>", "Find Buffers", opts = { nowait = true } },
  },
}


-- more keybinds!

return M
