-- require "nvchad.mappings"
local utils = require("utils")
local map = vim.keymap.set


-- NOTE: v8 code location
-- Copy link to clipboard
map("n", ".", function() utils.get_v8_url(true) end , { noremap = true, silent = true })
-- Open in browser
map("n", ",", function() utils.open_v8_url() end , { noremap = true, silent = true })
-- Copy to clipboard something like: b ../../src/wasm/wasm-js.cc:222
map('n', '<leader>.', [[:let @+ = "b ../../" . substitute(expand('%:p'), '.*src/', 'src/', '') . ":" . line('.')<CR>]], { noremap = true, silent = true, desc = "Copy gdb command for v8 code location." })

