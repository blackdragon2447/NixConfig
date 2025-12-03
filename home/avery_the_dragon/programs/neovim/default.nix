{
  pkgs,
  pkgs-stable,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    ./lsp
  ];

  options = {
    neovim.enable = lib.mkEnableOption "Enable Neovim";
    neovim.pdfview.wayland = lib.mkEnableOption "Enable wayland for nvim pdf viewer";
    neovim.sessions = lib.mkOption {
      default = {};
      defaultText = "{}";
      description = "Packages containing one or more session files for neovim";
      type = with lib.types; attrs;
    };
    #   {
    #   neorg-session = pkgs.writeText "neorg-session.vim" (builtins.readFile ./neorg-session.vim);
    # };
  };

  config = let
    helpers = inputs.nixvim.lib.nixvim;
    keymap = import ./keymap.nix helpers;
  in
    lib.mkIf config.neovim.enable {
      # Allow copying to the system clipboard
      home.packages = with pkgs; [
        wl-clipboard
        xclip
        mupdf
        zathura
      ];

      neovim.sessions = {
        neorg-session = pkgs.writeText "neorg-session.vim" (builtins.readFile ./neorg-session.vim);
      };

      programs.nixvim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        package = pkgs.neovim-unwrapped;

        globals.mapleader = " ";
        globals.maplocalleader = " ";
        globals.foldmethod = "syntax";

        luaLoader.enable = false;

        # Functions and such wich are needed elsewhere
        extraConfigLuaPre = ''
          local check_backspace = function()
          	local col = vim.fn.col(".") - 1
           return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
          end

          local kind_icons = {
            Text = "󰉿",
            Method = "m",
            Function = "󰊕",
            Constructor = "",
            Field = "",
            Variable = "󰆧",
            Class = "",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰊄",
          }

           vim.g.mapleader = " "
           vim.g.maplocalleader = " "
        '';

        extraConfigLuaPost = ''
          require("hover").setup {
            init = function()
              -- Require providers
              require("hover.providers.lsp")
              -- require('hover.providers.gh')
              -- require('hover.providers.gh_user')
              -- require('hover.providers.jira')
              -- require('hover.providers.man')
              -- require('hover.providers.dictionary')
            end,
            preview_opts = {
                border = 'single'
            },
            -- Whether the contents of a currently open hover window should be moved
            -- to a :h preview-window when pressing the hover keymap.
            preview_window = false,
            title = true,
            mouse_providers = {
                'LSP'
            },
            mouse_delay = 1000
          }

          require("actions-preview").setup {
            telescope = require("telescope.themes").get_cursor({
              layout_config = {
                width = 160,
                height = 18,
              },
            })
          }
        '';

        keymaps = keymap.global;

        autoCmd = [
          {
            event = ["BufWritePre"];
            command = "lua vim.lsp.buf.format()";
          }
        ];

        opts = {
          number = true;
          signcolumn = "auto:3";

          tabstop = 4;
          softtabstop = 4;
          shiftwidth = 4;
          smartindent = true;

          incsearch = true;

          updatetime = 300;

          termguicolors = true;

          mouse = "a";

          wrap = false;

          winwidth = 10;
          winminwidth = 10;
        };

        clipboard.register = "unnamedplus";

        # colorschemes.base16 = {
        #   enable = true;
        #   # colorscheme = "darkviolet";
        #   colorscheme = "equilibrium-dark";
        # };

        plugins = {
          neorg = {
            enable = true;

            settings = {
              load = {
                "core.defaults" = {
                  __empty = null;
                };
                "core.concealer" = {
                  config.icon_preset = "basic";
                };
                "core.dirman" = {
                  config = {
                    workspaces = {
                      notes = "~/Notes";
                    };
                    default_workspace = "notes";
                  };
                };
              };
            };
          };

          lualine = {
            settings = {
              component_separators = {
                left = "";
                right = "";
              };

              section_separators = {
                left = "";
                right = "";
              };

              disabled_filetypes = {
                statusline = [
                  "NeoTree"
                  "TelescopePrompt"
                  "toggleterm"
                ];
              };

              ignore_focus = [
                "NeoTree"
              ];

              always_divideMiddle = true;
              globalstatus = false;

              sections = {
                lualine_a = ["mode"];
                lualine_b = [
                  "branch"
                  "diff"
                ];
                lualine_c = [
                  "diagnostics"
                  "filename"
                ];

                lualine_x = [
                  "encoding"
                  "fileformat"
                ];
                lualine_y = ["filetype"];
                lualine_z = ["location"];
              };

              inactive_sections = {
                lualine_a = [];
                lualine_b = [
                  "branch"
                  "diff"
                ];
                lualine_c = [
                  "diagnostics"
                  "filename"
                ];

                lualine_x = [
                  "encoding"
                  "fileformat"
                ];
                lualine_y = ["filetype"];
                lualine_z = [];
              };

              icons_enabled = true;
            };
            enable = true;
          };

          noice = {
            enable = true;

            settings = {
              lsp = {
                override = {
                  "vim.lsp.util.convert_input_to_markdown_lines" = true;
                  "vim.lsp.util.stylize_markdown" = true;
                  "cmp.entry.ger_documentation" = true;
                };
              };

              presets = {
                bottom_search = false;
                command_palette = true;
                long_message_to_split = true;
                inc_rename = false;
                lsp_doc_border = true;
              };
            };
          };

          notify.enable = true;
          fidget.enable = true;

          which-key = {
            enable = true;

            settings = {
              key_labels = {
                "<Down>" = "<U+F063>";
                "<Up>" = "<U+F062>";
                "<Left>" = "<U+F060>";
                "<Right>" = "<U+F061>";
              };

              win = {
                border = "single";
                padding = [
                  2
                  2
                ];
              };
              layout.align = "center";

              disable.ft = ["TelescopePrompt"];
            };
          };

          /*
             dap = {
            enable = true;
            extensions.dap-ui = {
              enable = true;
            };
          };
          */

          toggleterm = {
            enable = true;
            settings = {
              open_mapping = ''"<C-\\>"'';
              size = 20;
              shadeTerminals = true;
              direction = "float";
              floatOpts = {
                border = "curved";
                winblend = 0;
              };
            };
          };

          telescope = {
            enable = true;

            settings = {
              defaults = helpers.mkRaw ''
                {
                  mappings = {
                    i = {
                      ["<ESC>"] = require('telescope.actions').close,
                    },
                  },
                }
              '';
              extensions = {
                file-browser = {
                  enable = true;
                };
              };
            };
          };

          neo-tree = {
            enable = true;
            settings = let
              fcf = {
                enabled = true;
                leave_dirs_open = true;
              };
            in {
              filesystem.follow_current_file = fcf;
              buffers.follow_current_file = fcf;
            };
          };

          gitsigns = {
            enable = true;
            settings = {
              numhl = true;
              current_line_blame_opts.virt_text_pos = "right_align";
            };
          };

          web-devicons.enable = true;

          nvim-lightbulb.enable = true;

          # TODO nvim-code-action-menu

          treesitter = {
            enable = true;

            grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
              haskell
              html
              java
              json
              latex
              lua
              make
              markdown
              markdown_inline
              nix
              python
              query
              regex
              rust
              toml
              vim
              vimdoc
            ];

            settings = {
              ensure_installed = [
                "haskell"
                "html"
                "java"
                "json"
                "latex"
                "lua"
                "make"
                "markdown"
                "markdown_inline"
                "nix"
                "python"
                "query"
                "regex"
                "rust"
                "toml"
                "vim"
                "vimdoc"
              ];
              indent.enable = true;
              highlight.enable = true;
            };
          };
          rainbow-delimiters.enable = true;
          ts-context-commentstring.enable = true;

          indent-blankline.enable = true;

          nvim-autopairs = {
            enable = true;
            settings = {
              check_ts = true;
              disabled_filetype = [
                "TelescopePrompt"
                "NeoTree"
              ];
            };
          };

          comment.enable = true;

          markdown-preview.enable = true;

          # TODO Knap

          # TODO Neodev

          luasnip = {
            enable = true;
            fromVscode = [{}];
          };
          friendly-snippets.enable = true;

          cmp-buffer.enable = true;
          cmp-path.enable = true;
          cmp-cmdline.enable = true;
          cmp_luasnip.enable = true;
          cmp-nvim-lsp.enable = true;
          cmp-nvim-lua.enable = true;

          cmp = {
            enable = true;
            package = pkgs-stable.vimPlugins.nvim-cmp;
            autoEnableSources = true;

            settings = {
              mapping = {
                "<C-b>" = "cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' })";
                "<C-f>" = "cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' })";
                "<C-Space>" = "cmp.mapping(cmp.mapping.complete(), { 'i', 'c' })";
                "<C-y>" = "cmp.config.disable";
                "<C-e>" = ''
                     cmp.mapping({
                  	i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                  })
                '';
                "<CR>" = "cmp.mapping.confirm({ select = true })";
                "<Tab>" = ''
                     cmp.mapping(function(fallback)
                   	  local luasnip = require("luasnip")
                   if cmp.visible() then
                    cmp.select_next_item()
                   elseif luasnip.expandable() then
                    luasnip.expand()
                   elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                   elseif check_backspace() then
                    fallback()
                   else
                     fallback()
                   end
                  end, { "i", "s" })
                '';
                "<S-Tab>" = ''
                     cmp.mapping(function(fallback)
                   	  local luasnip = require("luasnip")
                   if cmp.visible() then
                    cmp.select_prev_item()
                   elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                   else
                    fallback()
                   end
                  end, { "i", "s" })
                '';
              };

              snippet.expand = ''
                function(args)
                  require('luasnip').lsp_expand(args.body)
                end
              '';

              formatting = {
                fields = [
                  "kind"
                  "abbr"
                  "menu"
                ];
                format = ''
                    function(entry, vim_item)
                  vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    	vim_item.menu = ({
                      	nvim_lsp = "[LSP]",
                      	nvim_lua = "[NVIM_LUA]",
                      	luasnip = "[Snippet]",
                      	buffer = "[Buffer]",
                      	path = "[Path]",
                      })[entry.source.name]
                      return vim_item
                    end
                '';
              };

              sources = [
                {name = "nvim_lsp";}
                {name = "nvim_lua";}
                {name = "luasnip";}
                {name = "buffer";}
                {name = "path";}
              ];

              window.documentation.border = "rounded";
            };
          };

          lsp = {
            enable = true;

            keymaps.extra = keymap.lsp;
          };

          lsp-format.enable = true;

          none-ls = {
            enable = true;
            enableLspFormat = true;

            settings = {
              diagnostics_format = "[#{c}] #{m} (#{s})";
            };

            # TODO Sources
          };

          trouble = {
            enable = true;
            # TODO Config
          };
        };

        diagnostic.settings = {
          virtual_lines = {
            enable = true;
            only_current_line = true;
          };
        };

        extraPlugins = with pkgs.vimPlugins; [
          hover-nvim
          # nvim-code-action-menu
          actions-preview-nvim
          {
            plugin = knap;
            config =
              if config.neovim.pdfview.wayland
              then ''
                 let g:knap_settings = {
                    \ "texoutputext": "pdf",
                    \ "textopdf": "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
                    \ "textopdfviewerlaunch": "zathura %outputfile%",
                \ }
              ''
              else ''
                 let g:knap_settings = {
                    \ "texoutputext": "pdf",
                    \ "textopdf": "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
                    \ "textopdfviewerlaunch": "mupdf %outputfile%",
                    \ "textopdfviewerrefresh": "pkill -HUP mupdf"
                \ }
              '';
          }
        ];
      };
    };
}
