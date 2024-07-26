require "frectonz.lsp"
require "frectonz.cmp"
require "frectonz.options"
require "frectonz.keymaps"
require "frectonz.treesitter"

require("fidget").setup()
require("lualine").setup()
require("autoclose").setup()
require("bufferline").setup()
require('gitsigns').setup {
  signs = {
    add          = { text = '│+' },
    change       = { text = '│-' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  attach_to_untracked = true,
  current_line_blame = true,
}
