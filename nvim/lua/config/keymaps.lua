local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Telescope
local telescope = require("telescope.builtin")
keymap("n", "<leader>ff", telescope.find_files, { desc = "Telescope find files" })
keymap("n", "<leader>fs", telescope.live_grep, { desc = "Telescope live grep" })
keymap("n", "<leader>fb", telescope.buffers, { desc = "Telescope buffers" })
keymap("n", "<leader>fh", telescope.help_tags, { desc = "Telescope help tags" })

keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- paste over currently selected text without yanking it
keymap("v", "p", '"_dp')
keymap("v", "P", '"_dP')

keymap("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlights" })
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- copy everything between { and } including the brackets
-- p puts text after the cursor,
-- P puts text before the cursor.
vim.keymap.set("n", "YY", "va{Vy", opts)
vim.keymap.set("n", "gK", function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "Toggle diagnostic virtual_lines" })

--
-- TypeScript console.log
vim.keymap.set("n", "<leader>cl", function()
  local word = vim.fn.expand("<cword>")
  local line_num = vim.fn.line(".")
  local new_line = string.format('console.log("%s:", %s)', word, word)

  -- Add console.log on line below
  vim.fn.append(line_num, new_line)
end, { desc = "Add console.log for word under cursor" })

-- For visual selection
vim.keymap.set("v", "<leader>cl", function()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Only handle single line selections
  if start_pos[2] == end_pos[2] then
    local line = vim.fn.getline(start_pos[2])
    if line and line ~= "" then
      local selected = line:sub(start_pos[3], end_pos[3])
      local new_line = string.format('console.log("%s:", %s)', selected, selected)
      vim.fn.append(start_pos[2], new_line)
    end
  end
end, { desc = "Add console.log for selection" })
