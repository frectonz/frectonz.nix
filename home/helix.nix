{ pkgs
, lib
, config
, ...
}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "ayu_evolve";
      editor = {
        mouse = false;
        line-number = "relative";
        bufferline = "multiple";
        cursor-shape.insert = "bar";

        whitespace.render = {
          space = "all";
          tab = "all";
          newline = "none";
        };

        indent-guides.render = true;
      };
    };
    # languages = {
    #   language = [{
    #     name = "typescript";
    #     shebangs = [ "deno" ];
    #     roots = [ "deno.json" "deno.jsonc" ];
    #     file-types = [ "js" "ts" "jsx" "tsx" ];
    #     language-servers = [ "deno-lsp" ];
    #     auto-format = true;
    #   }];

    #   language-server.deno-lsp = {
    #     command = "deno";
    #     args = [ "lsp" ];
    #     environment = { NO_COLOR = "1"; };
    #     config.deno = {
    #       enable = true;
    #     };
    #   };

    #   # Uncomment to enable completion of unstable features of Deno
    #   # unstable = true
    #   # Uncomment to cache dependencies on save
    #   # cacheOnSave = true
    #   # Enable completion of importing from registries
    #   # Enable completion of function calls
    #   # suggest = { imports = { hosts = { "https://deno.land" = true, "https://crux.land" = true, "https://x.nest.land" = true } } }
    #   # Uncomment to enable inlay hints
    #   # inlayHints.parameterNames.enabled = "all"
    #   # inlayHints.parameterTypes.enabled = true
    #   # inlayHints.variableTypes.enabled = true
    #   # inlayHints.propertyDeclarationTypes.enabled  = true
    #   # inlayHints.functionLikeReturnTypes.enabled = true
    #   # inlayHints.enumMemberValues.enabled = true
    # };
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };
}
