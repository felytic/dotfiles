-------------------------------------------------------------------------------
-- General
-------------------------------------------------------------------------------

vim.opt.number = true -- Show current line number
vim.opt.relativenumber = true -- Enable relative line numbers

vim.opt.ignorecase = true -- Ignore case while search
vim.opt.smartcase = true -- Don't ignore uppercase letters in search

vim.opt.wrap = false -- Don't wrap lines

vim.opt.tabstop = 2 -- Number of visual spaces per TAB
vim.opt.softtabstop = 2 -- Number of spaces in tab when editing
vim.opt.shiftwidth = 2 -- Number of spaces inserted on TAB press
vim.opt.expandtab = true -- Insert spaces instead of tabs

vim.opt.list = true -- Show unprintable chars
vim.opt.listchars = "tab:>-,trail:•,extends:#,nbsp:•" -- List of chars to show

vim.opt.cursorline = true -- Highlight current line

vim.opt.swapfile = false -- Disable swap files

-- Highlight 89th column for python files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	command = "set colorcolumn=89",
})

vim.opt.scrolloff = 4 -- Keep 4 lines above and below the cursor

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
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")

-- Use H and L to move at the beggining and at the end of the line
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "^")

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

-- Resize buffers with Alt-< and Alt->
vim.keymap.set("n", "<M-<>", ":vertical resize -1<CR>")
vim.keymap.set("n", "<M->>", ":vertical resize +1<CR>")

-- Insert python breakpoint
vim.keymap.set("n", "<leader>b", "obreakpoint()<Esc>")

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
-- Plugins list
-------------------------------------------------------------------------------

local plugins = {
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{ "zbirenbaum/copilot.lua" },
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{ "HiPhish/rainbow-delimiters.nvim" },
	{
		"numToStr/Comment.nvim",
		lazy = false,
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
	},
	{ "neovim/nvim-lspconfig" },
	{ "ms-jpq/coq_nvim" },
	{ "sbdchd/neoformat" },
	{ "lewis6991/gitsigns.nvim" },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true,
	},
	{
		"ruifm/gitlinker.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "chaoren/vim-wordmotion" },
}

local opts = {}

-- This coq.nvim settings need to be set before lazy.nvim is loaded
vim.g.coq_settings = {
	auto_start = "shut-up",
	keymap = {
		pre_select = true,
		jump_to_mark = "",
		manual_complete = "",
	},
}

require("lazy").setup(plugins, opts)

-------------------------------------------------------------------------------
-- Plugins configuration
-------------------------------------------------------------------------------

-- Gruvbox colorscheme
require("gruvbox").setup()
vim.cmd("colorscheme gruvbox")

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<F6>", builtin.git_files, {})
vim.keymap.set("n", "<F5>", builtin.live_grep, {})
vim.keymap.set("n", "<F7>", builtin.grep_string, {})

-- Treesitter
local configs = require("nvim-treesitter.configs")
configs.setup({
	ensure_installed = { "lua", "vim", "vimdoc", "python", "markdown", "dockerfile", "json", "yaml", "toml" },
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})

-- Neo-tree
vim.keymap.set("n", "<F2>", ":Neotree toggle<CR>", {})
vim.keymap.set("n", "F", ":Neotree reveal<CR>", {}) -- Go to current file in Neotree
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
		},
	},
})

-- Gihub Copilot
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

-- LSP
local lsp = require("lspconfig")
lsp.pyright.setup({}) -- Python
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	end,
})

-- Coq.nvim
local coq = require("coq")
lsp.pyright.setup(coq.lsp_ensure_capabilities({}))
vim.keymap.set("n", "<C-f>", ":Neoformat<CR>")

-- Git signs
require("gitsigns").setup()
vim.keymap.set("n", "<C-n>", ":Gitsigns next_hunk<CR>")
vim.keymap.set("n", "<C-p>", ":Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "U", ":Gitsigns reset_hunk<CR>")

-- ibl
require("ibl").setup({
	scope = { enabled = false },
	indent = {
		char = "▏",
	},
})

-- Lualine
require("lualine").setup()

-- Neogit
require("neogit").setup()
vim.keymap.set("n", "<leader>g", ":Neogit<CR>")

-- Surround
require("nvim-surround").setup()

-- Comment.nvim
require("Comment").setup()

-- Gitlinker
require("gitlinker").setup({
	mappings = "<leader>t",
})
