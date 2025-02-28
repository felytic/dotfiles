-------------------------------------------------------------------------------
-- General
-------------------------------------------------------------------------------

vim.opt.number = true -- Show current line number
vim.opt.relativenumber = true -- Enable relative line numbers

vim.opt.ignorecase = true -- Ignore case while search
vim.opt.smartcase = true -- Don't ignore uppercase letters in search
vim.opt.incsearch = true -- Show search results as you type
vim.opt.inccommand = "split" -- Show live preview of substitutions

vim.opt.wrap = false -- Don't wrap lines

vim.opt.tabstop = 2 -- Number of visual spaces per TAB
vim.opt.softtabstop = 2 -- Number of spaces in tab when editing
vim.opt.shiftwidth = 2 -- Number of spaces inserted on TAB press
vim.opt.expandtab = true -- Insert spaces instead of tabs

vim.opt.list = true -- Show unprintable chars
vim.opt.listchars = "tab:>-,trail:•,extends:#,nbsp:•" -- List of chars to show

vim.opt.cursorline = true -- Highlight current line
vim.opt.scrolloff = 4 -- Keep 4 lines above and below the cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns of context on horizontal scroll

vim.opt.splitbelow = true -- Vertical split splits below the current buffer
vim.opt.splitright = true -- Horizontalsplit splits at the right of the current buffer
vim.opt.diffopt = "internal,filler,closeoff,vertical" -- Use vertical split for diffs

vim.opt.mouse = "" -- Disable mouse

vim.opt.confirm = true -- Always ask for saving changes
vim.opt.hidden = false -- Don't hide buffers when switching

vim.opt.undofile = true -- Allow undo across sessions
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false -- Avoid redundant backup files

vim.opt.lazyredraw = true -- Improve performance when executing macros or scripts
vim.opt.updatetime = 250 -- Make NeoVim more responsive

vim.opt.laststatus = 3 -- Show a single statusline at the bottom

vim.opt.colorcolumn = "89" -- Highlight 89th column
-------------------------------------------------------------------------------
-- Abbreviations
-------------------------------------------------------------------------------

-- Abbreviations for common typos
vim.cmd("cnoreabbrev Qa qa")
vim.cmd("cnoreabbrev QA qa")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev Wqa wqa")
vim.cmd("cnoreabbrev WQa wqa")
vim.cmd("cnoreabbrev WQA wqa")

-------------------------------------------------------------------------------
-- Keybindings
-------------------------------------------------------------------------------

-- Set Space as the leader key
vim.g.mapleader = " "

-- Save current file on double space
vim.keymap.set("n", "<leader><leader>", "<cmd>write<cr>")

-- Open this file on F12
vim.keymap.set("n", "<F12>", ":vsplit ~/.config/nvim/init.lua <CR>")

-- Split navigations
vim.keymap.set("n", "<C-J>", "<C-W>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-K>", "<C-W>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-L>", "<C-W>l", { noremap = true, silent = true })
vim.keymap.set("n", "<C-H>", "<C-W>h", { noremap = true, silent = true })

-- Use H and L to move at the beggining and at the end of the line
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "^")
vim.keymap.set("v", "L", "$")
vim.keymap.set("v", "H", "^")

-- Use kj or jk for exit Insert mode
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+yg_')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '"+yy')

-- Paste from clipboard
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P')

-- Resize buffers with Alt-h/j/k/l
vim.keymap.set("n", "<M-h>", ":vertical resize -1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-l>", ":vertical resize +1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-k>", ":resize -1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-j>", ":resize +1<CR>", { noremap = true, silent = true })

-- Search forwards with #
vim.api.nvim_set_keymap('n', '#', '*', { noremap = true, silent = true })

-- Center the screen on the search result and hide command line messages
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

vim.keymap.set("n", "<TAB>", "za", { noremap = true, silent = true })

-- Insert python breakpoint
vim.keymap.set("n", "<leader>b", "Obreakpoint()<Esc>j", { noremap = true })

-------------------------------------------------------------------------------
-- Lazy.nvim setup
-------------------------------------------------------------------------------

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


-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------
local plugins = {
  {
    -- Gruvbox color scheme
    "ellisonleao/gruvbox.nvim",
    lazy = false,    -- load this during startup
    priority = 1000, -- load this before all the other start plugins
    config = function()
      vim.cmd("colorscheme gruvbox")
    end,
  },
  {
    -- Fuzzy finder over lists
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<F6>", builtin.git_files, {})
      vim.keymap.set("n", "<F5>", function() builtin.live_grep({ use_quickfix = true }) end, {})
      vim.keymap.set("n", "<F7>", function() builtin.grep_string({ use_quickfix = true }) end, {})
    end,
  },
  {
    -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "python",
          "markdown",
          "dockerfile",
          "json",
          "yaml",
          "toml",
          "terraform",
          "rust",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    -- LSP client
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              format = {
                enable = true, -- Enable LSP-based formatting
              },
              diagnostics = {
                globals = { "vim" }, -- Tell LSP to recognize `vim` as a global
              },
            },
          },
        },
        ruff = {},
        pyright = {},
        jsonls = {
          init_options = {
            filetypes = { "json", "jsonc", "geojson" }
          }
        }
      }
    },
    config = function(_, opts)
      local lsp = require("lspconfig")
      local blink = require('blink.cmp')

      for server, config in pairs(opts.servers) do
        config.capabilities = blink.get_lsp_capabilities(config.capabilities)

        config.capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
        }

        lsp[server].setup(config)
      end


      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),

        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<space>r", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<C-]>", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<C-[>", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "<C-F>", function() vim.lsp.buf.format({ async = true }) end,
            { noremap = true, silent = true })
        end,
      })
    end,
  },
  {
    -- File system tree
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.keymap.set("n", "<F2>", ":Neotree toggle<CR>", {}) -- Open/close Neotree
      vim.keymap.set("n", "F", ":Neotree reveal<CR>", {})    -- Go to current file in Neotree

      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
          },
        },
        window = {
          mappings = {
            ["<TAB>"] = "open_vsplit",
            ["h"] = "close_node",
            ["l"] = "open",
          },
        },
      })
    end,
  },
  {
    -- Autocompletion
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    opts = {
      keymap = {
        preset = 'cmdline',
        ['<C-space>'] = {}
      },
      appearance = {
        use_nvim_cmp_as_default = true,
      },
      signature = { enabled = true },
      completion = {
        list = {
          selection = { preselect = false },
        },
        documentation = { auto_show = true },
        menu = {
          draw = {
            treesitter = { 'lsp' }
          },
        }
      }
    },
  },
  { "HiPhish/rainbow-delimiters.nvim" }, -- Rainbow delimiters
  {
    -- Show git changes in the gutter
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<C-n>", ":Gitsigns next_hunk<CR>")
      vim.keymap.set("n", "<C-p>", ":Gitsigns prev_hunk<CR>")
      vim.keymap.set("n", "U", ":Gitsigns reset_hunk<CR>")
    end
  },
  { "tpope/vim-fugitive" }, -- Git plugin
  {
    -- Surround text objects with quotes, brackets, etc
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },
  {
    -- Show tags in a sidebar
    "preservim/tagbar",
    config = function()
      vim.keymap.set("n", "<F4>", "<cmd>TagbarToggle<CR>")
    end
  },
  { -- Better folding
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      require('ufo').setup({
        open_fold_hl_timeout = 0
      })
      vim.o.foldlevel = 99 -- Keep folds open by default
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
      local folded_hl = vim.api.nvim_get_hl(0, { name = "Folded" })
      local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })

      vim.api.nvim_set_hl(0, "Folded", {
        bg = normal_hl.bg,
        fg = normal_hl.fg,
        italic = true
      })
      vim.api.nvim_set_hl(0, "UfoFoldedEllipsis", {
        bg = folded_hl.bg,
        fg = comment_hl.fg,
        italic = true
      })
    end
  },
  {
    -- Open GitHub links in the browser
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitlinker").setup({
        mappings = "<leader>t",
      })
    end
  },
  {
    -- Statusline
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = true,
        },
        sections = {
          lualine_c = { { 'filename', path = 1 } },
        },
        extensions = {
          "fugitive",
          "neo-tree",
          "quickfix",
        }
      }
    end
  },
  {
    -- GitHub Copilot
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<C-Space>",
          },
        },
      })
      vim.keymap.set("n", "gp", ":Copilot panel<CR>", {})
      vim.g.copilot_no_tab_map = true
    end
  },
  {
    -- GitHub Copilot chat
    "CopilotC-Nvim/CopilotChat.nvim",
    config = function()
      require("CopilotChat").setup()
    end,
  },
  {
    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.mypy,
        },
      })
    end,
  }
}

require("lazy").setup(plugins, {})
