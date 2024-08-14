let
  keysWithPrefix = p: ks: map (k: k // {key = p + k.key;}) ks;
  keysWithLeader = ks: keysWithPrefix "<leader>" ks;
  keysWithLeaderPrefix = p: ks: keysWithLeader (keysWithPrefix p ks);
  ensureMode = map (a:
    if !(a ? mode)
    then a // {mode = ["n"];}
    else a);
in
  helpers: {
    global = ensureMode (
      [
        {
          action = "<gv";
          key = "<";
          mode = ["x" "v"];
        }
        {
          action = ">gv";
          key = ">";
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
          action = helpers.mkRaw "require('Comment.api').toggle.linewise.current";
          key = "<C-c>";
        }
        {
          action = helpers.mkRaw "require('hover').hover";
          key = "K";
        }
        {
          action = helpers.mkRaw ''
            function()
              local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
              vim.api.nvim_feedkeys(esc, 'nx', false)
              require('Comment.api').toggle.linewise(vim.fn.visualmode())
            end
          '';
          key = "<C-c>";
          mode = ["x" "v"];
        }
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
          action = helpers.mkRaw ''
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
      ]
      ++ keysWithLeaderPrefix "p" [
        {
          action = helpers.mkRaw "require('knap').process_once";
          key = "r";
          options.desc = "Open/Refresh knap viewer";
        }
        {
          action = helpers.mkRaw "require('knap').close_viewer";
          key = "c";
          options.desc = "Close knap viewer";
        }
      ]
    );

    lsp = ensureMode (
      [
        {
          action = helpers.mkRaw "vim.lsp.buf.signature_help";
          key = "<C-k>";
          options.desc = "Show signature help";
        }
        {
          action = helpers.mkRaw "vim.diagnostic.open_float";
          key = "D";
        }
      ]
      ++ keysWithPrefix "g" [
        {
          action = helpers.mkRaw "vim.lsp.buf.declaration";
          key = "D";
          options.desc = "Goto declaration";
        }
        {
          action = helpers.mkRaw "vim.lsp.buf.definition";
          key = "d";
          options.desc = "Goto definition";
        }
        {
          action = "<C-t>";
          key = "b";
          options.desc = "Go back";
        }
        {
          action = helpers.mkRaw "vim.lsp.buf.implementation";
          key = "i";
          options.desc = "Goto implementation";
        }
      ]
      ++ keysWithLeader [
        {
          action = helpers.mkRaw "vim.lsp.buf.rename";
          key = "rn";
          options.desc = "Rename symbol";
        }
        # {
        #   action = "<cmd>CodeActionMenu<CR>";
        #   key = "a";
        #   options.desc = "Show availavle code actions";
        # }
        {
          action = helpers.mkRaw "require('actions-preview').code_actions";
          key = "a";
          options.desc = "Show availavle code actions";
        }
        {
          action = helpers.mkRaw "vim.lsp.buf.format";
          key = "=";
        }
      ]
    );

    coq = ensureMode (keysWithLeaderPrefix "c" [
      {
        action = "<Plug>CoqNext";
        key = "<Down>";
      }
      {
        action = "<Plug>CoqUndo";
        key = "<Up>";
      }
      {
        action = "<Plug>CoqToLine";
        key = "<Right>";
      }
      {
        action = "<Plug>CoqToTop";
        key = "<Left>";
      }
    ]);
  }
