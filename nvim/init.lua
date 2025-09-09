-------------------------------------------------------------------------------
-- General
-------------------------------------------------------------------------------

------ Line Numbers -----------------------------------------------------------
vim.opt.number = true         -- Show current line number
vim.opt.relativenumber = true -- Enable relative line numbers

------ Search & Substitution --------------------------------------------------
vim.opt.ignorecase = true    -- Ignore case while search
vim.opt.smartcase = true     -- Don't ignore uppercase letters in search
vim.opt.incsearch = true     -- Show search results as you type
vim.opt.inccommand = "split" -- Show live preview of substitutions

------ Text Display -----------------------------------------------------------
vim.opt.wrap = false -- Don't wrap lines
vim.opt.cursorline = true -- Highlight current line
vim.opt.list = true -- Show unprintable chars
vim.opt.listchars = "tab:>-,trail:•,extends:#,nbsp:•" -- List of chars to show

-- Function to parse line-length from pyproject.toml
local function set_colorcolumn_from_pyproject()
  local cwd = vim.fn.getcwd()
  local pyproject_path = cwd .. "/pyproject.toml"

  -- Check if pyproject.toml exists
  local file = io.open(pyproject_path, "r")
  if not file then
    vim.opt.colorcolumn = "80" -- Default fallback
    return
  end

  local content = file:read("*all")
  file:close()

  -- Parse line-length from anywhere in the file
  local line_length = content:match("line%-length%s*=%s*(%d+)")
  if line_length then
    line_length = tonumber(line_length) + 1
  end

  -- Set colorcolumn based on parsed value or default
  vim.opt.colorcolumn = tostring(line_length or 80)
end

-- Set initial colorcolumn
set_colorcolumn_from_pyproject()

------ Indentation & Tabs ----------------------------------------------------
vim.opt.tabstop = 2        -- Number of visual spaces per TAB
vim.opt.softtabstop = 2    -- Number of spaces in tab when editing
vim.opt.shiftwidth = 2     -- Number of spaces inserted on TAB press
vim.opt.expandtab = true   -- Insert spaces instead of tabs
vim.opt.smartindent = true -- Better auto-indentation

------ Scrolling & Navigation -------------------------------------------------
vim.opt.scrolloff = 4     -- Keep 4 lines above and below the cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns of context on horizontal scroll
vim.opt.mouse = ""        -- Disable mouse

------ Window Behavior --------------------------------------------------------
vim.opt.splitbelow = true                             -- Vertical split splits below the current buffer
vim.opt.splitright = true                             -- Horizontal split splits at the right of the current buffer
vim.opt.diffopt = "internal,filler,closeoff,vertical" -- Use vertical split for diffs

------ Buffer Management ------------------------------------------------------
vim.opt.confirm = true -- Always ask for saving changes
vim.opt.hidden = false -- Don't hide buffers when switching

------ File & Backup Settings -------------------------------------------------
vim.opt.undofile = true  -- Allow undo across sessions
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false   -- Avoid redundant backup files

------ Performance & Responsiveness ----------0--------------------------------
vim.opt.lazyredraw = true -- Improve performance when executing macros or scripts
vim.opt.updatetime = 250  -- Make NeoVim more responsive

------ User Interface ---------------------------------------------------------
vim.opt.laststatus = 3                        -- Show a single statusline at the bottom
vim.opt.signcolumn = "yes"                    -- Always show signcolumn to prevent layout shifts
vim.opt.completeopt = "menu,menuone,noselect" -- Better completion behavior
vim.opt.wildmode = "longest:full,full"        -- Better command-line completion

------ Colors & Theme ---------------------------------------------------------
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.background = "dark"  -- Default to dark mode

-------------------------------------------------------------------------------
-- Abbreviations
-------------------------------------------------------------------------------

------ Common Typos -----------------------------------------------------------
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

-- Open this file
vim.keymap.set("n", "<F12>", ":vsplit " .. vim.fn.stdpath("config") .. "/init.lua<CR>")

------ Window Navigation ----------------------------------------------------
vim.keymap.set("n", "<C-J>", "<C-W>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-K>", "<C-W>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-L>", "<C-W>l", { noremap = true, silent = true })
vim.keymap.set("n", "<C-H>", "<C-W>h", { noremap = true, silent = true })

------ Use H and L to move at the beggining and at the end of the line --------
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "^")
vim.keymap.set("v", "L", "$")
vim.keymap.set("v", "H", "^")

------ Use kj or jk for exit Insert mode --------------------------------------
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")

------ Clipboard Operations ---------------------------------------------------
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+yg_')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '"+yy')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P')

------ Resize buffers with Alt-h/j/k/l ----------------------------------------
vim.keymap.set("n", "<M-h>", ":vertical resize -1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-l>", ":vertical resize +1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-k>", ":resize -1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-j>", ":resize +1<CR>", { noremap = true, silent = true })

------ Search & Navigation ----------------------------------------------------
vim.keymap.set("n", "#", "*", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

-- Toggle fold with TAB
vim.keymap.set("n", "<TAB>", "za", { noremap = true, silent = true })

-- Add Python breakpoint
vim.keymap.set("n", "<leader>b", "obreakpoint()<Esc>j", { noremap = true })

------ Visual Mode Enhancements -----------------------------------------------
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

------ Theme Switching --------------------------------------------------------
vim.keymap.set("n", "<leader>bg", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { desc = "Toggle background" })

-------------------------------------------------------------------------------
-- Autocommands
-------------------------------------------------------------------------------

------ Highlight yanked text --------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

------ Resize buffers on window resize ----------------------------------------
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

------ Update colorcolumn when entering directory with pyproject.toml ---------
vim.api.nvim_create_autocmd({ "DirChanged", "BufEnter" }, {
  callback = function()
    set_colorcolumn_from_pyproject()
  end,
})

-------------------------------------------------------------------------------
-- Setup lazy.nvim
-------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------
local plugins = {

  ------ Gruvbox color scheme -------------------------------------------------
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,    -- load this during startup
    priority = 1000, -- load this before all the other start plugins
    config = function()
      vim.cmd("colorscheme gruvbox")
    end,
  },

  ------ Telescope fuzzy finder -----------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = {
            horizontal = { preview_width = 0.6 }
          },
        }
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<F6>", builtin.git_files, {})
      vim.keymap.set("n", "<F5>", function() builtin.live_grep({ use_quickfix = true }) end, {})
      vim.keymap.set("n", "<F7>", function() builtin.grep_string({ use_quickfix = true }) end, {})
    end,
  },

  ------ Treesitter for syntax highlighting -----------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "query",
          "python", "rust",
          "html", "css", "json", "yaml", "toml", "markdown"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        }
      })
    end,
  },

  ------ Language Server Protocol ---------------------------------------------
  {
    "neovim/nvim-lspconfig",
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
        mypy = {},
        jsonls = {
          init_options = {
            filetypes = { "json", "jsonc", "geojson" }
          }
        }
      }
    },
    config = function(_, opts)
      local lsp = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<space>r", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<C-]>", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<C-[>", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<C-f>", function()
          require("conform").format({ async = true, lsp_fallback = true })
        end, { noremap = true, silent = true })
      end

      for server, config in pairs(opts.servers) do
        config.capabilities = cmp_nvim_lsp.default_capabilities()
        config.on_attach = on_attach

        config.capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
        }

        lsp[server].setup(config)
      end
    end,
  },

  ------ Neo-Tree File Explorer -----------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.keymap.set("n", "<F2>", ":Neotree toggle<CR>", {})
      vim.keymap.set("n", "<F3>", ":Neotree reveal<CR>", {})
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            never_show = { ".git" },
          },
          follow_current_file = { enabled = true },
        },
        window = {
          mappings = {
            ["<TAB>"] = "open_vsplit",
            ["h"] = "close_node",
            ["l"] = "open",
            ["<S-TAB>"] = "open_split",
            ["P"] = "toggle_preview",
          },
        },
      })
    end,
  },

  ------ Autocompletion -------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              local line = vim.api.nvim_get_current_line()
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local before_cursor = string.sub(line, 1, col)
              if before_cursor:match("^%s*$") then
                fallback()
              elseif before_cursor:match("%w$") or before_cursor:match("[.:]$") then
                cmp.complete()
              else
                fallback()
              end
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_previous_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
          { name = "path" },
        })
      })
    end,
  },


  ------ Rainbow delimiters ---------------------------------------------------
  {
    "HiPhish/rainbow-delimiters.nvim",
  },

  ------ Show git changes in the gutter ---------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<C-n>", ":Gitsigns next_hunk<CR>")
      vim.keymap.set("n", "<C-p>", ":Gitsigns prev_hunk<CR>")
      vim.keymap.set("n", "U", ":Gitsigns reset_hunk<CR>")
    end,
  },

  ------ Git plugin -----------------------------------------------------------
  {
    "tpope/vim-fugitive",
  },

  ------ Surround text objects with quotes, brackets, etc ---------------------
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },

  ------ Show tags in a sidebar -----------------------------------------------
  {
    "preservim/tagbar",
    config = function()
      vim.keymap.set("n", "<F4>", "<cmd>TagbarToggle<CR>")
      vim.api.nvim_exec([[
        hi! link TagbarAccessPublic GruvboxGreen
        hi! link TagbarAccessProtected GruvboxBlue
        hi! link TagbarAccessPrivate   GruvboxRed
      ]], false)
    end
  },

  ------ Better code folding --------------------------------------------------
  {
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

  ------ Generate GitHub links ------------------------------------------------
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitlinker").setup({
        mappings = "<leader>t",
      })
    end
  },

  ------ Statusline -----------------------------------------------------------
  {
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

  ------ GitHub Copilot -------------------------------------------------------
  {
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

  ------ Linter ---------------------------------------------------------------
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "mypy", "ruff" },
        yaml   = { "yamllint" },
        json   = { "jsonlint" },
      }
    end,
  },

  ------ Formatter ------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        yaml   = { "yamlfmt" },
        json   = { "jq" },
      },
    },
  },

  ------ Show colors for hex codes and color names ----------------------------
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        user_default_options = {
          names = false,   -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
        },
      })
    end,
  },

  ------ Better word motions --------------------------------------------------
  {
    "chaoren/vim-wordmotion"
  },
}

require("lazy").setup(plugins, {})
