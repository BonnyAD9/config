-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<C-J>", "81|F<space>r<enter>")

map("n", "+", "1")
map("n", "ě", "2")
map("n", "š", "3")
map("n", "č", "4")
map("n", "ř", "5")
map("n", "ž", "6")
map("n", "ý", "7")
map("n", "á", "8")
map("n", "í", "9")
map("n", "é", "0")

map("n", "<enter>", "o<esc>")
map("n", "<S-enter>", "O<esc>")
