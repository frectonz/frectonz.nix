local configs = require("nvim-treesitter.configs")

configs.setup {
  sync_install = false,
  auto_install = false,
  ignore_install = "all",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
