require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--

-- neo-tree.nvim
map("n", "<leader>`", "<cmd> Neotree toggle <CR>", { desc = "Neotree toggle" })
map("n", "<leader>1", "<cmd> Neotree <CR>", { desc = "Neotree focus" })


map("n", "<leader>[", "<C-o>", { desc = "go back" })
map("n", "<leader>]", "<C-i>", { desc = "go forward" })
-- Command + ]: go forward (command key can not work in iTerm, it's the reserved key of iTerm)
map("n", "<D-]>", "<C-i>", { desc = "go forward" })
map("n", "<D-[>", "<C-o>", { desc = "go back" })
