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
					vim.fn.feedkeys('f|2l', 'n')
				else
					vim.fn.feedkeys('l', 'n')
				end
			end,
			"Table move right"
	 	},
		['h'] = {
			function()
				if vim.b.table_mode_active == 1 then 
					vim.fn.feedkeys('2F|2l', 'n')
				else
					vim.fn.feedkeys('h', 'n')
				end
			end,
			"Table move right"
	 	},
		['o'] = {
			function()
				if vim.b.table_mode_active == 1 then 
					vim.fn.feedkeys('o| ', 'n')
				else
					vim.fn.feedkeys('o', 'n')
				end
			end,
			"Table new row below"
	 	},
		['O'] = {
			function()
				if vim.b.table_mode_active == 1 then 
					vim.fn.feedkeys('O| ', 'n')
				else
					vim.fn.feedkeys('O', 'n')
				end
			end,
			"Table new row above"
	 	},
  },
	i = {
		-- table movement
		['<tab>'] = {
			function()
				if vim.b.table_mode_active == 1 then 
					vim.fn.feedkeys(' | ', 'n')
				else
					vim.fn.feedkeys('	', 'n')
				end
			end,
			"Next cell"
	 	},
		-- ['<CR>'] = {
		-- 	function()
		-- 		if vim.b.table_mode_active == 1 then 
		-- 			vim.fn.feedkeys(' | <CR>| ', 'n')
		-- 		else
		-- 			vim.fn.feedkeys('<CR>', 'n')
		-- 		end
		-- 	end,
		-- 	"Next cell on new line"
	 -- 	},
	}
}


-- more keybinds!

return M
