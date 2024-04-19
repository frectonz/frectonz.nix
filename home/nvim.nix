{ pkgs, config, ... }:
let
  vim-rescript = pkgs.vimUtils.buildVimPlugin {
    name = "vim-rescript";
    src = pkgs.fetchFromGitHub {
      owner = "rescript-lang";
      repo = "vim-rescript";
      rev = "master";
      hash = "sha256-JpEO1Zb+mm9dJISriticFmtPeVwZGpUAFv18wV6/dIg=";
    };
  };
in
{
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

      # vimPlugins.conjure
      # vimPlugins.vim-parinfer

      vimPlugins.tokyonight-nvim
      config.nur.repos.m15a.vimExtraPlugins.vim-moonfly-colors

      vimPlugins.gitsigns-nvim
      vimPlugins.autoclose-nvim

      vim-rescript

      (vimPlugins.nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-lua
        p.tree-sitter-rust
        p.tree-sitter-commonlisp
        p.tree-sitter-astro
        p.tree-sitter-tsx
        p.tree-sitter-typescript
        p.tree-sitter-javascript
        p.tree-sitter-vimdoc
        p.tree-sitter-css
        p.tree-sitter-svelte
        p.tree-sitter-html
        p.tree-sitter-ocaml
        p.tree-sitter-elm
      ]))
    ];
  };
}
