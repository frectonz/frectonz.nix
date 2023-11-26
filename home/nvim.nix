{ config, pkgs, ... }: {
  home.packages = with pkgs; [ neovide ];
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs; [
      vimPlugins.cmp-git
      vimPlugins.nvim-cmp
      vimPlugins.cmp-path
      vimPlugins.cmp-buffer
      vimPlugins.cmp-cmdline
      vimPlugins.cmp-nvim-lsp

      vimPlugins.cmp-vsnip
      vimPlugins.vim-vsnip

      vimPlugins.nvim-lspconfig
      vimPlugins.telescope-nvim

      vimPlugins.fidget-nvim
      vimPlugins.lualine-nvim

      vimPlugins.conjure
      vimPlugins.vim-parinfer

      (vimPlugins.nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-lua
        p.tree-sitter-commonlisp
      ]))
    ];
  };
}
