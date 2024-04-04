{
  pkgs,
  pkgs-stable,
  lib,
  config,
  ...
}: {
  options = {
    neovim.enable = lib.mkEnableOption "Enable Neovim";
  };

  config = let
    keysWithPrefix = p: ks: map (k: k // {key = p + k.key;}) ks;
    keysWithLeader = ks: keysWithPrefix "<leader>" ks;
    keysWithLeaderPrefix = p: ks: keysWithLeader (keysWithPrefix p ks);
  in
    lib.mkIf config.neovim.enable {
      programs.nixvim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        globals.mapleader = " ";
        globals.maplocalleader = " ";

        luaLoader.enable =false;

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

        keymaps =
          map (a:
            if !(a ? mode)
            then a // {mode = ["n"];}
            else a) [
            {
              action = "<";
              key = "<gv";
              mode = ["x" "v"];
            }
            {
              action = ">";
              key = ">gv";
              mode = ["x" "v"];
            }
            {
              action = ":m '<-2<CR>gv=gv";
              key = "<Pageup>";
              mode = ["v"];
            }
            {
              action = ":m '>+1<CR>gv=gv";
              key = "<Pagedown>";
              mode = ["v"];
            }
            {
              action = "require('Comment.api').toggle.linewise.current";
              key = "<C-c>";
              lua = true;
            }
            {
              action = ''
                function()
                  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
                  vim.api.nvim_feedkeys(esc, 'nx', false)
                  require('Comment.api').toggle.blockwise(vim.fn.visualmode())
                end
              '';
              key = "<C-c>";
              mode = ["x" "v"];
              lua = true;
            }
            #{
            #  action = "require('hover').hover";
            #  key = "K";
            #  mode = [ "n" ];
            #  lua = true;
            #}
          ]
          ++ keysWithLeader [
            {
              action = "<cmd>Neotree<CR>";
              key = "t";
              options.desc = "Focus file tree";
            }
            {
              action = "<cmd>Neotree toggle<CR>";
              key = "F";
              options.desc = "Toggle file tree";
            }
            {
              action = "<cmd>Telescope find_files<CR>";
              key = "f";
              options.desc = "Open file finder";
            }
            {
              action = "<cmd>Telescope buffers<CR>";
              key = "b";
              options.desc = "Open buffer list";
            }
            {
              action = "<cmd>Telescope live_grep<CR>";
              key = "/";
              options.desc = "Search in workspace";
            }
            {
              action = "<cmd>Telescope diagnostics<CR>";
              key = "d";
              options.desc = "Show file diagnostics";
            }
            {
              action = "<cmd>Telescope lsp_document_symbols<CR>";
              key = "s";
              options.desc = "Show symbols in document";
            }
            {
              action = "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>";
              key = "S";
              options.desc = "Show symbols in workspace";
            }
          ]
          ++ keysWithPrefix "g" [
            {
              action = "G";
              key = "e";
              options.desc = "Go to file end";
              mode = ["n" "v"];
            }
            {
              action = "gg";
              key = "g";
              options.desc = "Go to file start";
              mode = ["n" "v"];
            }
            {
              action = "^";
              key = "h";
              options.desc = "Go to line start";
              mode = ["n" "v"];
            }
            {
              action = "$";
              key = "l";
              options.desc = "Go to line end";
              mode = ["n" "v"];
            }
          ]
          ++ keysWithLeaderPrefix "w" [
            {
              action = "<C-w>h";
              key = "<Left>";
              options.desc = "Focus left window";
            }
            {
              action = "<C-w>j";
              key = "<Down>";
              options.desc = "Focus down window";
            }
            {
              action = "<C-w>k";
              key = "<Up>";
              options.desc = "Focus up window";
            }
            {
              action = "<C-w>l";
              key = "<Right>";
              options.desc = "Focus right window";
            }
            {
              action = "<C-w>s";
              key = "s";
              options.desc = "Horizontal Split";
            }
            {
              action = "<C-w>v";
              key = "v";
              options.desc = "Vertical Split";
            }

            {
              action = "<cmd>new<CR>";
              key = "n";
              options.desc = "Horizontal Split New";
            }
            {
              action = "<cmd>vnew<CR>";
              key = "m";
              options.desc = "Vertical Split New";
            }
            # {
            #   action = "require('nvim-window').pick";
            #   key = "w";
            #   options.desc = "Jump to window";
            #   lua = true;
            # }
            {
              action = ''
                function()
                  vim.cmd.new();
                  vim.cmd.q();
                  vim.cmd.vnew();
                  vim.cmd.q();
                end
              '';
              key = "q";
              options.desc = "BalanceWindows";
            }
          ]
          ++ keysWithLeaderPrefix "T" [
            {
              action = "<cmd>Trouble document_diagnostics<CR>";
              key = "d";
              options.desc = "Show all diagnostics in document";
            }
            {
              action = "<cmd>Trouble document_workspace<CR>";
              key = "d";
              options.desc = "Show all workspace in document";
            }
          ]
          ++ keysWithLeaderPrefix "l" [
            {
              action = ''
                  function()
                local null_ls = require("none-ls")
                local diagnostics = null_ls.builtins.diagnostics
                local code_actions = null_ls.builtins.code_actions
                null_ls.toggle(diagnostics.cspell)
                null_ls.toggle(code_actions.cspell)
                  end
              '';
              key = "s";
              options.desc = "Toggle spell check";
            }
            {
              action = ''
                  function()
                local null_ls = require("none-ls")
                local formatting = null_ls.builtins.formatting
                null_ls.toggle(formatting)
                  end
              '';
              key = "f";
              options.desc = "Toggle formatting";
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

        colorschemes.base16 = {
          enable = true;
          colorscheme = "equilibrium-dark";
        };

        plugins = {
          lualine = {
            enable = true;
            iconsEnabled = true;

            componentSeparators = {
              left = "";
              right = "";
            };

            sectionSeparators = {
              left = "";
              right = "";
            };

            disabledFiletypes = {
              statusline = [
                "NeoTree"
                "TelescopePrompt"
                "toggleterm"
              ];
            };

            ignoreFocus = [
              "NeoTree"
            ];

            alwaysDivideMiddle = true;
            globalstatus = false;

            sections = {
              lualine_a = ["mode"];
              lualine_b = ["branch" "diff"];
              lualine_c = ["diagnostics" "filename"];

              lualine_x = ["encoding" "fileformat"];
              lualine_y = ["filetype"];
              lualine_z = ["location"];
            };

            inactiveSections = {
              lualine_a = [];
              lualine_b = ["branch" "diff"];
              lualine_c = ["diagnostics" "filename"];

              lualine_x = ["encoding" "fileformat"];
              lualine_y = ["filetype"];
              lualine_z = [];
            };
          };

          noice = {
            enable = true;

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

          notify.enable = true;
          fidget.enable = true;

          which-key = {
            enable = true;

            keyLabels = {
              "<Down>" = "";
              "<Up>" = "";
              "<Left>" = "";
              "<Right>" = "";
            };

            window = {
              border = "single";
              position = "bottom";
              margin = {
                top = 1;
                right = 1;
                left = 1;
                bottom = 1;
              };
              padding = {
                top = 2;
                right = 2;
                left = 2;
                bottom = 2;
              };
            };

            layout.align = "center";

            disable.filetypes = ["TelescopePrompt"];
          };

          dap = {
            enable = true;
            extensions.dap-ui = {
              enable = true;
            };
          };

          toggleterm = {
            enable = true;
            openMapping = "<c-\\>";
            size = 20;
            shadeTerminals = true;
            direction = "float";
            floatOpts = {
              border = "curved";
              winblend = 0;
            };
          };

          telescope = {
            enable = true;

            defaults = {
              __raw = ''
                   {
                mappings = {
                	i = {
                		["<ESC>"] = require('telescope.actions').close,
                	},
                     },
                   }
              '';
            };

            extensions = {
              file_browser = {
                enable = true;
              };
            };
          };

          neo-tree = {
            enable = true;
            filesystem.followCurrentFile = {
              enabled = true;
              leaveDirsOpen = true;
            };
            buffers.followCurrentFile = {
              enabled = true;
              leaveDirsOpen = true;
            };
          };

          gitsigns = {
            enable = true;
            settings = {
              numhl = true;
              currentLineBlameOpts.virtTextPos = "right_align";
            };
          };

          nvim-lightbulb.enable = true;

          # TODO hover.nvim

          # TODO nvim-code-action-menu

          treesitter = {
            enable = true;
            ensureInstalled = [
              "html"
              "java"
              "jsom"
              "latex"
              "lua"
              "make"
              "markdown"
              "markdown_inline"
              "nix"
              "python"
              "querry"
              "regex"
              "rust"
              "timl"
              "vim"
              "vimdoc"
            ];
            indent = true;
          };
          rainbow-delimiters.enable = true;
          ts-context-commentstring.enable = true;

          indent-blankline.enable = true;

          nvim-autopairs = {
            enable = true;
            checkTs = true;
            disabledFiletypes = ["TelescopePrompt" "NeoTree"];
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
                fields = ["kind" "abbr" "menu"];
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

            servers = {
              nil_ls = {
                enable = true;

                extraOptions = {
                  flake.autoEvalInputs = true;
                };
              };

              # TODO More Servers
            };
          };

          lsp-format = {
            enable = true;
          };

          none-ls = {
            enable = true;
            enableLspFormat = true;

            diagnosticsFormat = "[#{c}] #{m} (#{s})";

            # TODO Sources
          };

          trouble = {
            enable = true;
            # TODO Config
          };

          lsp-lines = {
            enable = true;
            currentLine = true;
          };
        };

        extraPlugins = with pkgs.vimPlugins; [hover-nvim nvim-code-action-menu];
      };
    };
}
