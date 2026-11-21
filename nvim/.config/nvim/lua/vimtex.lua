vim.g.vimtex_view_method = "zathura"

vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_quickfix_open_on_error = 0

vim.keymap.set("n", "<leader>lt", function()
  local qf_exists = false

  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_exists = true
      break
    end
  end

  if qf_exists then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end, { desc = "Toggle LaTeX quickfix" })

