{ pkgs, lib, config , ...}: {

  options = {
    neovim.enable = lib.mkEnableOption "Enable Neovim";
  };

  config = 
  let
    toLua = str: "lua <<EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua <<EOF\n${builtins.readFile file}\nEOF\n";
  in
  lib.mkIf config.neovim.enable {
    
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
      '';
  
      plugins = with pkgs.vimPlugins; [
	{
	  plugin = lualine-nvim;
	  dependencies = [ nvim-web-devicons ];
	}
	{
	  plugin = noice-nvim;
	  dependencies = [nui-nvim];
	}
        nvim-notify
        fidget-nvim
        which-key-nvim
	{
	  plugin = nvim-dap-ui;
	  dependencies = [ nvim-dap ];
	  #nvim-nio
	}
        toggleterm-nvim
        telescope-nvim
	{
	  plugin = neo-tree-nvim;
	  dependencies = [ 
	    penary-nvin
	    nvim-web-devicons
	    nui-nvim
	  ];
	}
        #nvim-window
        gitsigns-nvim
        nvim-lightbulb
        hover-nvim
        nvim-code-action-menu
        (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-rust
          p.tree-sitter-java
          p.tree-sitter-bash
          p.tree-sitter-html
          p.tree-sitter-json
          p.tree-sitter-latex
          p.tree-sitter-lua
          p.tree-sitter-make
          p.tree-sitter-markdown
          p.tree-sitter-markdown_inline
          p.tree-sitter-python
          p.tree-sitter-regex
          p.tree-sitter-toml
          p.tree-sitter-vim
          p.tree-sitter-vimdoc
        ]))
	rainbow-delimiters-nvim
        nvim-comment
        knap
        neodev-nvim
	{
	  plugin = nvim-cmp;
	  dependencies = [
	    cmp-buffer
	    cmp-path
	    cmp-cmdline
	    cmp_luasinp
	    cmp-nvim-lua
	    cmp-nvim-lsp
	    cmp-nvim-lsp-signature-help
	  ];
	}
	nvim-lspconfig
	
        
      ];
    };

    
  };

}
