-- underline_preview.lua
local underline = vim.api.nvim_create_namespace("underline")

vim.cmd([[highlight Underlined term=underline cterm=underline]])

vim.keymap.set("v", "<Leader>u", function()
  vim.fn.UnderlineV()
end, {silent = true})

function UnderlineV()
  local saved_reg = vim.fn.getreg('"')
  vim.fn.setreg('"', vim.fn.getregtype(""), vim.fn.getreg('"x'))
  local selected = vim.fn.getreg('"')
  local line_start = vim.fn.line("'<")
  local line_end = vim.fn.line("'>")
  
  vim.api.nvim_buf_set_text(0, line_start-1, line_end, vim.fn.escape(selected, '/\\') , {namespace = underline})
end

vim.keymap.set("n", "<C-k>", function()
  OpenPreview()
end, {silent = true})

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

