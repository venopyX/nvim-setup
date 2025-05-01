-- init.lua - Modern Neovim Configuration for Developers
-- Optimized for Go, TypeScript, Python and general development

-- Set up lazy.nvim package manager (install it if not already present)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic Settings
vim.g.mapleader = " " -- Space as leader key
vim.g.maplocalleader = ","
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.termguicolors = true -- True color support
vim.opt.showmode = false -- Don't show mode in command line
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.breakindent = true -- Preserve indentation in wrapped lines
vim.opt.undofile = true -- Persistent undo
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive when uppercase present
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.updatetime = 250 -- Faster update time
vim.opt.timeoutlen = 300 -- Faster timeout
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below
vim.opt.scrolloff = 8 -- Minimum lines to keep above/below cursor
vim.opt.sidescrolloff = 8 -- Minimum columns to keep left/right of cursor
vim.opt.completeopt = "menu,menuone,noselect" -- Better completion
vim.opt.mouse = "a" -- Enable mouse
vim.opt.pumheight = 10 -- Limit height of popup menu
vim.opt.shiftwidth = 2 -- Number of spaces for each indentation
vim.opt.tabstop = 2 -- Number of spaces for a tab
vim.opt.softtabstop = 2 -- Number of spaces for a tab in editing
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smartindent = true -- Smart autoindent
vim.opt.wrap = false -- No line wrapping
vim.opt.hidden = true -- Allow unsaved buffers

-- Set GOBIN in path
vim.env.GOBIN = vim.env.HOME .. "/go/bin"
vim.env.PATH = vim.env.PATH .. ":" .. vim.env.GOBIN


-- Load plugins with lazy.nvim
require("lazy").setup({
  -- Color scheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        term_colors = true,
        transparent_background = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          which_key = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = {"branch", "diff", "diagnostics"},
          lualine_c = {
            {
              "filename",
              path = 1, -- Relative path
              symbols = {
                modified = " ●",
                readonly = " ",
                unnamed = "[No Name]",
              }
            }
          },
          lualine_x = {"encoding", "fileformat", "filetype"},
          lualine_y = {"progress"},
          lualine_z = {"location"}
        },
      }
    end,
  },
  
  -- Tab/Buffer line
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    config = function()
      require("bufferline").setup {
        options = {
          mode = "tabs",
          separator_style = "slant",
          always_show_bufferline = false,
        },
      }
    end,
  },
  
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup {
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
      }
    end,
  },
  
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
          },
          sorting_strategy = "ascending",
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }
      require("telescope").load_extension("fzf")
    end,
  },
  
  -- Git integrations
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          
          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, {expr=true})
          
          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, {expr=true})
          
          -- Actions
          map("n", "<leader>gs", gs.stage_hunk)
          map("n", "<leader>gr", gs.reset_hunk)
          map("n", "<leader>gS", gs.stage_buffer)
          map("n", "<leader>gu", gs.undo_stage_hunk)
          map("n", "<leader>gR", gs.reset_buffer)
          map("n", "<leader>gp", gs.preview_hunk)
          map("n", "<leader>gb", function() gs.blame_line{full=true} end)
          map("n", "<leader>tb", gs.toggle_current_line_blame)
          map("n", "<leader>gd", gs.diffthis)
          map("n", "<leader>gD", function() gs.diffthis("~") end)
          map("n", "<leader>td", gs.toggle_deleted)
        end
      }
    end,
  },
  
  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Additional lua configuration
      "folke/neodev.nvim",
      -- LSP status
      { "j-hui/fidget.nvim", tag = "legacy" },
    },
    config = function()
      -- Setup mason
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "gopls",
          "tsserver",
          "pyright",
          "lua_ls",
          "rust_analyzer",
        },
        automatic_installation = true,
      }
      
      -- Setup lua development for neovim
      require("neodev").setup()
      
      -- Status updates for LSP
      require("fidget").setup()
      
      -- LSP settings
      local lspconfig = require("lspconfig")
      
      -- Define on_attach function
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        
        -- Buffer local mappings
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
      end
      
      -- Common capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      
      -- Setup LSP servers
      lspconfig.gopls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      }
      
      lspconfig.tsserver.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
      
      lspconfig.pyright.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      }
      
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }
      
      lspconfig.rust_analyzer.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            assist = {
              importGranularity = "module",
              importPrefix = "self",
            },
            cargo = {
              loadOutDirsFromCheck = true,
            },
            procMacro = {
              enable = true,
            },
          },
        },
      }
    end,
  },

  -- Completions
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",  -- Add this line to install jsregexp
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
      },
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      
      -- Load snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      
      -- Add support for javascript regex
      require("luasnip").config.set_config({
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
        region_check_events = "InsertEnter",
        delete_check_events = "TextChanged,InsertLeave",
      })
      
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        experimental = {
          ghost_text = true,
        },
      }
      
      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })
      
      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })
    end,
  },
  
  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "go", "gomod", "gosum", "gowork",
          "typescript", "tsx", "javascript", "html", "css", "json",
          "python",
          "lua", "vim", "vimdoc",
          "rust",
          "markdown", "markdown_inline",
          "bash",
          "regex",
          "c", "cpp",
          "yaml",
          "dockerfile",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
        },
      }
    end,
  },
  
  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {
        check_ts = true,
      }
      
      -- Integration with cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
  
  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  
  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup {
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = { enabled = true },
      }
    end,
  },
  
  -- Highlight and remove trailing whitespace
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_whitespace_on_save = 1
      vim.g.strip_whitespace_confirm = 0
    end,
  },
  
  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      }
    end,
  },
  
  -- Dashboard/Start screen
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      
      -- Custom header
      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
        " ███████╗ ██████╗ ██████╗         ██████╗  ██████╗  ",
        " ██╔════╝██╔═══██╗██╔══██╗        ██╔══██╗██╔════╝  ",
        " █████╗  ██║   ██║██████╔╝        ██║  ██║█████╗    ",
        " ██╔══╝  ██║   ██║██╔══██╗        ██║  ██║██╔══╝    ",
        " ██║     ╚██████╔╝██║  ██║        ██████╔╝███████╗  ",
        " ╚═╝      ╚═════╝ ╚═╝  ╚═╝        ╚═════╝ ╚══════╝  ",
        "                                                     ",
      }
      
      -- Menu
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
        dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      }
      
      -- Footer
      dashboard.section.footer.val = "Ready to code like a pro!"
      
      alpha.setup(dashboard.opts)
    end,
  },
  
  -- Which-key for keybinding help
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup {
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
        window = {
          border = "rounded",
          padding = { 2, 2, 2, 2 },
        },
      }
      
      -- Register key groups
      local wk = require("which-key")
      wk.register({
        f = {
          name = "File",
          f = { "<cmd>Telescope find_files<cr>", "Find File" },
          r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
          g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
          b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
          n = { "<cmd>enew<cr>", "New File" },
        },
        g = {
          name = "Git",
          s = { "Stage Hunk" },
          r = { "Reset Hunk" },
          S = { "Stage Buffer" },
          u = { "Undo Stage Hunk" },
          R = { "Reset Buffer" },
          p = { "Preview Hunk" },
          b = { "Blame Line" },
          d = { "Diff This" },
          D = { "Diff This ~" },
        },
        p = {
          name = "Project",
          f = { "<cmd>Telescope git_files<cr>", "Find Git Files" },
          s = { "<cmd>Telescope git_status<cr>", "Git Status" },
          b = { "<cmd>Telescope git_branches<cr>", "Git Branches" },
          c = { "<cmd>Telescope git_commits<cr>", "Git Commits" },
          t = { "<cmd>NvimTreeToggle<cr>", "Toggle NvimTree" },
        },
        l = {
          name = "LSP",
          a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
          d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go To Definition" },
          D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go To Declaration" },
          i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go To Implementation" },
          r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
          R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
          f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
          h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Documentation" },
          s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
          t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
          l = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Line Diagnostics" },
        },
        t = {
          name = "Toggle",
          t = { "<cmd>ToggleTerm<cr>", "Terminal" },
          b = { "Toggle Git Blame" },
          d = { "Toggle Deleted" },
        },
        w = {
          name = "Window",
          v = { "<cmd>vsplit<cr>", "Vertical Split" },
          s = { "<cmd>split<cr>", "Horizontal Split" },
          h = { "<cmd>wincmd h<CR>", "Move Left" },
          j = { "<cmd>wincmd j<CR>", "Move Down" },
          k = { "<cmd>wincmd k<CR>", "Move Up" },
          l = { "<cmd>wincmd l<CR>", "Move Right" },
          q = { "<cmd>q<cr>", "Close Window" },
          o = { "<cmd>only<cr>", "Only Window" },
        },
        ["<space>"] = { "<cmd>Telescope<cr>", "Telescope" },
      }, { prefix = "<leader>" })
    end,
  },
  
  -- Add Go development tools
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        goimport = 'gopls', -- goimport command
        gofmt = 'gopls', -- gofmt command
        max_line_len = 120, -- max line length in goline format
        tag_transform = false, -- tag_transfer  check gomodifytags for details
        verbose = false, -- output loginf in messages
        log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
        lsp_codelens = true, -- set to false to disable codelens
        lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
        lsp_document_formatting = true,
        -- lsp_cfg = false, -- true: apply go.nvim non-default gopls setup
        -- lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        diagnostic = {
          hdlr = true, -- hook lsp diag handler
          virtual_text = true, -- show virtual for diagnostic message
          underline = true, -- use underline for diagnostic
        },
        test_dir = '', -- default: "", -- if set, will be added to `go.test.files`
        run_in_floaterm = true, -- set to true to run in float window.
      })

      -- Set up autocommands for Go
      local autocmd = vim.api.nvim_create_autocmd
      autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require('go.format').goimport()
        end,
      })

      -- Key mappings for Go
      local function map(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true }
        if opts then options = vim.tbl_extend("force", options, opts) end
        vim.keymap.set(mode, lhs, rhs, options)
      end

      map("n", "<leader>gt", "<cmd>GoTest<CR>", { desc = "Go Test" })
      map("n", "<leader>gtf", "<cmd>GoTestFunc<CR>", { desc = "Go Test Function" })
      map("n", "<leader>gr", "<cmd>GoRun<CR>", { desc = "Go Run" })
      map("n", "<leader>gi", "<cmd>GoImport<CR>", { desc = "Go Import" })
      map("n", "<leader>gI", "<cmd>GoImpl<CR>", { desc = "Go Implement" })
      map("n", "<leader>gfs", "<cmd>GoFillStruct<CR>", { desc = "Go Fill Struct" })
      map("n", "<leader>gat", "<cmd>GoAddTag<CR>", { desc = "Go Add Tags" })
      map("n", "<leader>grt", "<cmd>GoRmTag<CR>", { desc = "Go Remove Tags" })
    end,
  },
  
  -- Python development
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      
      dapui.setup()
      
      -- Auto open/close dapui
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
      
      -- Python setup
      require('dap-python').setup('python')
      
      -- Set up Python debugging adapter
      dap.adapters.python = {
        type = 'executable',
        command = 'python',
        args = { '-m', 'debugpy.adapter' }
      }

      -- Configure Python debugging configurations
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          pythonPath = function()
            -- If you're using a virtual environment, you might want to use its python
            local venv = os.getenv('VIRTUAL_ENV')
            if venv then
              return venv .. '/bin/python'
            end
            -- Otherwise, use the system python
            return '/usr/bin/python'
          end,
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Launch with arguments',
          program = '${file}',
          args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, ' ')
          end,
          pythonPath = function()
            local venv = os.getenv('VIRTUAL_ENV')
            if venv then
              return venv .. '/bin/python'
            end
            return '/usr/bin/python'
          end,
        }
      }

      -- Key mappings for debugging
      local function map(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true }
        if opts then options = vim.tbl_extend("force", options, opts) end
        vim.keymap.set(mode, lhs, rhs, options)
      end
      
      map('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
      map('n', '<leader>dc', function() require('dap').continue() end, { desc = 'Debug: Continue' })
      map('n', '<leader>do', function() require('dap').step_over() end, { desc = 'Debug: Step Over' })
      map('n', '<leader>di', function() require('dap').step_into() end, { desc = 'Debug: Step Into' })
      map('n', '<leader>du', function() require('dap').step_out() end, { desc = 'Debug: Step Out' })
      map('n', '<leader>dr', function() require('dap').repl.open() end, { desc = 'Debug: Open REPL' })
      map('n', '<leader>dq', function() require('dap').terminate() end, { desc = 'Debug: Terminate' })
      map('n', '<leader>dui', function() require('dapui').toggle() end, { desc = 'Debug: Toggle UI' })
    end,
  },
  -- TypeScript/JavaScript development
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("typescript-tools").setup({
        on_attach = function(client, bufnr)
          -- LSP keymaps
          local opts = { noremap=true, silent=true, buffer=bufnr }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
          
          -- TypeScript specific keymaps
          vim.keymap.set("n", "<leader>tso", "<cmd>TSToolsOrganizeImports<CR>", opts)
          vim.keymap.set("n", "<leader>tsr", "<cmd>TSToolsRenameFile<CR>", opts)
          vim.keymap.set("n", "<leader>tsi", "<cmd>TSToolsAddMissingImports<CR>", opts)
          vim.keymap.set("n", "<leader>tsf", "<cmd>TSToolsFixAll<CR>", opts)
          vim.keymap.set("n", "<leader>tsd", "<cmd>TSToolsGoToSourceDefinition<CR>", opts)
        end,
        settings = {
          -- Customize TypeScript settings here
          tsserver_plugins = {},
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      })
    end,
  },
  
  -- Debugging setup with DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
      "leoluz/nvim-dap-go",
    },
    config = function()
      local status_dap_ok, dap = pcall(require, 'dap')
      if not status_dap_ok then
        print('DAP not loaded')
        return
      end

      local status_dapui_ok, dapui = pcall(require, 'dapui')
      if not status_dapui_ok then
        print('DAPUI not loaded')
        return
      end

      local status_virtual_text_ok, virtual_text = pcall(require, 'nvim-dap-virtual-text')
      if not status_virtual_text_ok then
        print('DAP Virtual Text not loaded')
        return
      end

      -- Configure DAP UI
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        layouts = {
          {
            elements = {
              'scopes',
              'breakpoints',
              'stacks',
              'watches',
            },
            size = 40,
            position = 'left',
          },
          {
            elements = {
              'repl',
              'console',
            },
            size = 10,
            position = 'bottom',
          },
        },
      })

      -- Configure Virtual Text
      virtual_text.setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        virt_text_pos = 'eol',
      })

      -- Customize breakpoint signs
      vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapBreakpointCondition', {text='🔵', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapStopped', {text='➡️', texthl='', linehl='', numhl=''})

      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Language specific setup
      local status_dap_python_ok, dap_python = pcall(require, 'dap-python')
      if status_dap_python_ok then
        dap_python.setup('python')
      end

      local status_dap_go_ok, dap_go = pcall(require, 'dap-go')
      if status_dap_go_ok then
        dap_go.setup()
      end

      -- Add Go debugging configuration to nvim-dap
      dap.adapters.go = {
        type = 'executable',
        command = 'dlv',
        args = {'dap'},
        name = 'go',
      }

      dap.configurations.go = {
        {
          type = 'go',
          name = 'Debug File',
          request = 'launch',
          program = "${file}",
        },
        {
          type = 'go',
          name = 'Debug Package',
          request = 'launch',
          program = "${fileDirname}",
        },
        {
          type = 'go',
          name = 'Debug Test (go.mod)',
          request = 'launch',
          mode = 'test',
          program = "./${relativeFileDirname}",
        },
      }

      -- Global DAP keymaps
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, { desc = 'Conditional Breakpoint' })
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue' })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step Into' })
      vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step Over' })
      vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Step Out' })
      vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Open REPL' })
      vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Run Last' })
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Toggle UI' })
      vim.keymap.set('n', '<leader>dx', dap.terminate, { desc = 'Terminate' })
    end,
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    config = function()
      local status_ok, neoscroll = pcall(require, 'neoscroll')
      if not status_ok then
        return
      end

      neoscroll.setup({
        easing_function = "quadratic",
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        pre_hook = nil,
        post_hook = nil,
      })
    end,
  },

  -- Zen mode for focusing
  {
    "folke/zen-mode.nvim",
    config = function()
      local status_ok, zen_mode = pcall(require, "zen-mode")
      if not status_ok then
        return
      end

      zen_mode.setup {
        window = {
          backdrop = 0.9,
          width = 120,
          height = 1,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = "0",
            list = false,
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
          },
          gitsigns = { enabled = false },
          tmux = { enabled = false },
          twilight = { enabled = true },
        },
      }
      
      vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { noremap = true, silent = true })
    end,
  },

  -- Twilight - dim inactive portions of code
  {
    "folke/twilight.nvim",
    config = function()
      local status_ok, twilight = pcall(require, "twilight")
      if not status_ok then
        return
      end

      twilight.setup {
        dimming = {
          alpha = 0.25,
          color = { "Normal", "#ffffff" },
          inactive = true,
        },
        context = 10,
        treesitter = true,
      }
    end,
  },

  -- Colorizer for highlighting color codes
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      local status_ok, colorizer = pcall(require, "colorizer")
      if not status_ok then
        return
      end

      colorizer.setup(
        {"*"},
        {
          RGB = true,
          RRGGBB = true,
          names = true,
          RRGGBBAA = true,
          rgb_fn = true,
          hsl_fn = true,
          mode = "background",
        }
      )
    end,
  },
  
  -- Surround text objects
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      local status_ok, surround = pcall(require, "nvim-surround")
      if not status_ok then
        return
      end

      surround.setup({})
    end
  },
  
  -- Hop for quick navigation
  {
    "phaazon/hop.nvim",
    branch = "v2",
    event = "VeryLazy",
    config = function()
        local status_ok, hop = pcall(require, "hop")
        if not status_ok then
            vim.notify("Failed to load hop", "error")
            return
        end

        hop.setup({
            keys = 'etovxqpdygfblzhckisuran',
            jump_on_sole_occurrence = true,
            case_insensitive = true,
            create_hl_autocmd = true,
            teasing = false,
        })

        -- Keymaps for Hop
        local opts = { silent = true, noremap = true }
        vim.keymap.set("n", "<leader>hw", "<cmd>HopWord<CR>", vim.tbl_extend("force", opts, { desc = "Hop Word" }))
        vim.keymap.set("n", "<leader>hl", "<cmd>HopLine<CR>", vim.tbl_extend("force", opts, { desc = "Hop Line" }))
        vim.keymap.set("n", "<leader>hc", "<cmd>HopChar1<CR>", vim.tbl_extend("force", opts, { desc = "Hop Char" }))
        vim.keymap.set("n", "<leader>hp", "<cmd>HopPattern<CR>", vim.tbl_extend("force", opts, { desc = "Hop Pattern" }))
    end,
  },
  
  -- Ensure nvim-dap-ui is properly loaded
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    lazy = false,  -- Load immediately instead of lazy loading
    priority = 999,  -- High priority to load before other plugins
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        icons = {
          expanded = "▾",
          collapsed = "▸",
          current_frame = "*"
        },
        layouts = {
          {
            elements = {
              -- Elements can be strings or table with id and size keys.
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 10,
            position = "bottom",
          },
        },
        controls = {
          -- Requires Neovim nightly (or 0.8 when released)
          enabled = true,
          -- Display controls in this element
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
          },
        },
      })

      -- Automatically open UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Add keymaps for DAP UI
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
      vim.keymap.set("n", "<leader>de", function()
        dapui.eval(vim.fn.input("Expression > "))
      end, { desc = "Evaluate Expression" })
    end
  },

  -- Ensure Go debugging tools are properly set up
  {
    "leoluz/nvim-dap-go",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    lazy = false,
    config = function()
      local status_ok, dap_go = pcall(require, "dap-go")
      if not status_ok then
        print("Failed to load nvim-dap-go")
        return
      end

      -- Configure delve (Go debugger)
      dap_go.setup({
        -- Path to the delve command
        delve = {
          path = "dlv",
          initialize_timeout_sec = 20,
          port = "${port}",
          args = {},
        },
        -- Debugging configurations
        configurations = {
          {
            type = "go",
            name = "Debug",
            request = "launch",
            program = "${file}",
          },
          {
            type = "go",
            name = "Debug test",
            request = "launch",
            mode = "test",
            program = "${file}",
          },
          {
            type = "go",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}",
          },
        },
      })
    end,
  },
  
  -- Highlight TODO comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup {
        signs = true,
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
      }
    end,
  },
  
  -- Custom statuscolumn (line numbers, signs, etc)
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          { text = { "%s" }, click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
        },
      })
    end,
  },
  
  -- Highlight current word under cursor
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 100,
        filetypes_denylist = {
          "dirvish",
          "fugitive",
          "alpha",
          "NvimTree",
          "packer",
          "neogitstatus",
          "Trouble",
          "lir",
          "Outline",
          "spectre_panel",
          "toggleterm",
          "DressingSelect",
          "TelescopePrompt",
        },
      })
    end,
  },
  
  -- Harpoon for quick file navigation
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup({})
      
      -- Keymaps for Harpoon
      vim.keymap.set("n", "<leader>ha", function() require("harpoon.mark").add_file() end, { desc = "Harpoon Add File" })
      vim.keymap.set("n", "<leader>hm", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Harpoon Menu" })
      vim.keymap.set("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end, { desc = "Harpoon File 1" })
      vim.keymap.set("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end, { desc = "Harpoon File 2" })
      vim.keymap.set("n", "<leader>h3", function() require("harpoon.ui").nav_file(3) end, { desc = "Harpoon File 3" })
      vim.keymap.set("n", "<leader>h4", function() require("harpoon.ui").nav_file(4) end, { desc = "Harpoon File 4" })
    end,
  },
  
  -- Mini plugins
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Mini.pairs - better autopairing
      require("mini.pairs").setup()
      
      -- Mini.ai - better text objects
      require("mini.ai").setup()
      
      -- Mini.align - alignment
      require("mini.align").setup()
      
      -- Keymaps for mini.align
      vim.keymap.set("n", "ga", "<Cmd>lua MiniAlign.align_operator()<CR>", { desc = "Mini.align" })
      vim.keymap.set("x", "ga", "<Cmd>lua MiniAlign.align_visual()<CR>", { desc = "Mini.align visual" })
    end,
  },
  
  -- Symbols outline
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup {
        auto_close = true,
        show_symbol_details = true,
        position = "right",
      }
      
      -- Keymap for symbols outline
      vim.keymap.set("n", "<leader>so", "<cmd>SymbolsOutline<CR>", { desc = "Toggle Symbols Outline" })
    end,
  },
  
  -- Persistence for session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
      
      -- Keymaps for persistence
      vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore Session" })
      vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session" })
      vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Current Session" })
    end,
  },
  
  -- Improved UI components
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup {
        input = {
          default_prompt = "➤ ",
          winhighlight = "Normal:Normal,NormalNC:Normal",
        },
        select = {
          backend = { "telescope", "fzf", "builtin" },
          telescope = { theme = "dropdown" },
        },
      }
    end,
  },
  
  -- Clipboard manager
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua", -- Add sqlite dependency for persistent history
    },
    event = "VeryLazy", -- Load on event instead of immediately
    config = function()
      local status_ok, neoclip = pcall(require, "neoclip")
      if not status_ok then
        vim.notify("Failed to load neoclip", "error")
        return
      end

      neoclip.setup({
        history = 100,
        enable_persistent_history = true,
        continuous_sync = false, -- Changed from true to avoid potential issues
        db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
        preview = true,
        on_select = {
          move_to_front = true,
          close_telescope = true,
        },
        on_paste = {
          set_reg = false,
          move_to_front = true,
        },
        keys = {
          telescope = {
            i = {
              select = '<cr>',
              paste = '<c-p>',
              paste_behind = '<c-k>',
              replay = '<c-q>', -- replay a macro
              delete = '<c-d>', -- delete an entry
            },
            n = {
              select = '<cr>',
              paste = 'p',
              paste_behind = 'P',
              replay = 'q',
              delete = 'd',
            },
          },
        },
      })
      
      -- Register with Telescope safely
      pcall(require('telescope').load_extension, 'neoclip')
      
      -- Keymapping for clipboard history
      vim.keymap.set("n", "<leader>fc", "<cmd>Telescope neoclip<CR>", { desc = "Clipboard History" })
    end,
  },
  
  -- Neodev for Neovim Lua development
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({
        library = {
          plugins = { "nvim-dap-ui" },
          types = true,
        },
      })
    end,
  },
  
  -- Additional language parsers for Treesitter
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,
        max_lines = 3,
        trim_scope = "outer",
        patterns = {
          default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
          },
        },
        zindex = 20,
        mode = "cursor",
      }
    end,
  },
  
  -- Improved UI for LSP definitions, references, diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup {
        position = "bottom",
        height = 10,
        icons = true,
        mode = "workspace_diagnostics",
        fold_open = "",
        fold_closed = "",
        group = true,
        padding = true,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = {"<cr>", "<tab>"},
          open_split = {"<c-x>"},
          open_vsplit = {"<c-v>"},
          open_tab = {"<c-t>"},
          jump_close = {"o"},
          toggle_mode = "m",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          close_folds = {"zM", "zm"},
          open_folds = {"zR", "zr"},
          toggle_fold = {"zA", "za"},
          previous = "k",
          next = "j"
        },
      }
      
      -- Keymappings for Trouble
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" })
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics" })
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List" })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List" })
      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { desc = "LSP References" })
    end,
  },
  
  -- Notifications manager
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      notify.setup({
        stages = "fade",
        timeout = 3000,
        background_colour = "#000000",
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        },
      })
      
      -- Set as default notification system
      vim.notify = notify
    end,
  },
  
  -- Noice for improved cmdline and notifications
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = {
            enabled = true,
          },
          signature = {
            enabled = true,
          },
        },
        cmdline = {
          enabled = true,
          view = "cmdline",
        },
        messages = {
          enabled = true,
        },
        popupmenu = {
          enabled = true,
          backend = "nui",
        },
        notify = {
          enabled = true,
          view = "notify",
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = true,
          lsp_doc_border = false,
        },
      })
    end,
  },
})

-- Additional key mappings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- General mappings
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "No Highlight" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Navigate left" })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate down" })
map("n", "<C-k>", "<C-w>k", { desc = "Navigate up" })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate right" })

-- Resize with arrows
map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Shrink window height" })
map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Shrink window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Navigate buffers
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>c", "<cmd>Bdelete!<CR>", { desc = "Close buffer" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Outdent line" })
map("v", ">", ">gv", { desc = "Indent line" })

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", { desc = "Move text down" })
map("v", "<A-k>", ":m .-2<CR>==", { desc = "Move text up" })
map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move selection down" })
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move selection up" })
map("x", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "Move selection down" })
map("x", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "Move selection up" })

-- Telescope mappings
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "Find word under cursor" })
map("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Find projects" })
map("n", "<leader>ft", "<cmd>Telescope treesitter<CR>", { desc = "Treesitter symbols" })
map("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "Commands" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
map("n", "<leader>fr", "<cmd>Telescope registers<CR>", { desc = "Registers" })

-- Git telescope mappings
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- Terminal mappings
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- Auto commands
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    set_terminal_keymaps()
  end
})

-- Enhanced diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    source = "if_many",
  },
  float = {
    source = "always",
    border = "rounded",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Modern diagnostic symbols
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Format on save for specific filetypes
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go", "*.lua", "*.py", "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Auto create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    local dir = vim.fn.fnamemodify(file, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- Language-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

-- Project-specific settings via .nvim.lua files
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local project_config = vim.fn.getcwd() .. "/.nvim.lua"
    if vim.fn.filereadable(project_config) == 1 then
      vim.cmd("source " .. project_config)
    end
  end,
})

-- Performance improvements
vim.g.matchparen_timeout = 20
vim.g.matchparen_insert_timeout = 20
vim.opt.lazyredraw = true

-- Startup performance optimization
vim.loader.enable()

-- Print startup message
print([[
 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

 Welcome to your professional development environment!
]])

-- End of init.lua


-- Error logging
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyComplete",
  callback = function()
    require("notify").notify("Neovim setup complete!", "info", {
      title = "Startup Status",
      timeout = 2000,
    })
  end,
})

-- Enhance error reporting
vim.opt.debug = "msg"

-- Make sure lazy.nvim reloads the plugins
-- require("lazy").sync()
