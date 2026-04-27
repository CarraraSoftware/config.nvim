-------------------------------------------------------------------------------
--- REQUIRED DEPENDENCIES:
--- nvim >= 0.12.0
--- curl                   // for nvim-treesitter, mason
--- tar                    // for nvim-treesitter, mason
--- fzf                    // for telescope-fzf-native.nvim 
--- tree-sitter-cli        // for treesitter
---
--- OPTIONAL DEPENDENCIES:
--- rg                     // for telescope
--- fd                     // for telescope
---
--------------------------------------- REMAPS --------------------------------
--source: https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
-- THE LEADER
vim.g.mapleader = " "

-- FILE NAVIGATION
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>")
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- MOVE LINES UP AND DOWN
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- SLIGHTLY CHANGE DEFAULT BEHAVIOR
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- PASTE WIHTOUT CHANGING BUFFER
vim.keymap.set("x", "<leader>p", [["_dP]])

-- COPY TO CLIPBOARD
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- dont remember
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- CTRL-C = ESC
vim.keymap.set("i", "<C-c>", "<Esc>")

-- KILL Q
vim.keymap.set("n", "Q", "<nop>")

-- JUMP NEXT/PREVIOUS IN LIST
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- FIND AND REPLACE CURRENT WORD
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- MAKE CURRENT FILE INTO EXECUTABLE
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- ERRORHANDLING BOILERPLATE IN GOLANG
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")
-- COMPILE TEMPL FILE
vim.keymap.set("n", "<leader>tt", "<cmd>!templ generate<CR>", { silent = true })

-- BACKSPACE EQUALS GO BACK TO ALTERNATE FILE
vim.keymap.set("n", "<BS>", "<C-^>")

-- NAVIGATE DIAGNOSTIC
vim.keymap.set("n", "<leader>sd", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>nd", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>pd", vim.diagnostic.goto_prev)

-- SOURCE CURRENT FILE
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- ALIGN ON EQUAL
vim.keymap.set({ "v", "x" }, "<leader>ae", "<cmd>:'<,'>! column -t -s '=' -o '='<CR>")

-- COPY AND PASTE CURRENT LINE
vim.keymap.set({ "n", "v" }, "<leader>jj", "Vyp")
vim.keymap.set({ "n", "v" }, "<leader>kk", "VyP")

-- OPEN TERMINAL WINDOW
vim.keymap.set("n", "<leader>tr", ":term<CR>i")
vim.keymap.set("n", "<leader>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("L")
    vim.api.nvim_win_set_width(0, 100)
end)
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>")

vim.api.nvim_set_keymap('t', '<C-l><C-l>', [[<C-\><C-N>:lua ClearTerm(0)<CR>]], {})
vim.api.nvim_set_keymap('t', '<C-l><C-l><C-l>', [[<C-\><C-N>:lua ClearTerm(1)<CR>]], {})

function ClearTerm(reset)
  vim.opt_local.scrollback = 1

  vim.api.nvim_command("startinsert")
  if reset == 1 then
    vim.api.nvim_feedkeys("reset", 't', false)
  else
    vim.api.nvim_feedkeys("clear", 't', false)
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cr>', true, false, true), 't', true)

  vim.opt_local.scrollback = 10000
end

-------------------------------- OPTIONS ---------------------------------------------------
require("vim._core.ui2").enable()

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 0
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 32
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.virtualedit = "all"

vim.g.moonflyTransparent = true

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.h",
  command = "set filetype=c",
})

--------------------------------------- PLUGINS -------------------------------
local function gh(x)
    return "https://github.com/" .. x
end

vim.pack.add({
    { src = gh("echasnovski/mini.icons") },
 	{ src = gh("stevearc/oil.nvim") },
})
require("oil").setup({
    view_options = {
        show_hidden = true,
    },
})

vim.pack.add({ gh("CarraraSoftware/href.nvim") })
require("href").setup();

vim.pack.add({
    {
        src = gh("bluz71/vim-moonfly-colors"),
        name = "moonfly",
    },
})
vim.g.moonflyItalics = false
vim.cmd.colorscheme("moonfly")

vim.pack.add({ gh("laytan/cloak.nvim") })
require('cloak').setup({
    enabled = true,
    cloak_character = '*',
    highlight_group = 'Comment',
    cloak_length = nil, -- Provide a number if you want to hide the true length of the value.
    try_all_patterns = true,
    cloak_telescope = true,
    cloak_on_leave = false,
    patterns = {
        {
            file_pattern = '*.env*',
            cloak_pattern = '=.+',
            replace = nil,
        },
    },
})

vim.pack.add({ gh("nvim-lualine/lualine.nvim") })
require('lualine').setup({
    options = {
        theme = 'codedark'
    }
})

vim.pack.add({ gh("brenoprata10/nvim-highlight-colors") })
require("nvim-highlight-colors").setup({
	---Render style
	---@usage 'background'|'foreground'|'virtual'
	render = "virtual",

	---Set virtual symbol (requires render to be set to 'virtual')
	virtual_symbol = "■",

	---Set virtual symbol suffix (defaults to '')
	virtual_symbol_prefix = "",

	---Set virtual symbol suffix (defaults to ' ')
	virtual_symbol_suffix = "",

	---Set virtual symbol position()
	---@usage 'inline'|'eol'|'eow'
	---inline mimics VS Code style
	---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
	---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
	virtual_symbol_position = "eol",

	---Highlight hex colors, e.g. '#FFFFFF'
	enable_hex = true,

	---Highlight short hex colors e.g. '#fff'
	enable_short_hex = true,

	---Highlight rgb colors, e.g. 'rgb(0 0 0)'
	enable_rgb = true,

	---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
	enable_hsl = true,

	-- Highlight hsl colors without function, e.g. '--foreground: 0 69% 69%;'
	enable_hsl_without_function = true,

	---Highlight CSS variables, e.g. 'var(--testing-color)'
	enable_var_usage = true,

	---Highlight named colors, e.g. 'green'
	enable_named_colors = true,

	---Highlight tailwind colors, e.g. 'bg-blue-500'
	enable_tailwind = true,

	---Set custom colors
	---Label must be properly escaped with '%' to adhere to `string.gmatch`
	--- :help string.gmatch
	-- custom_colors = {
	-- 	{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
	-- 	{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
	-- },

	-- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
	-- exclude_filetypes = {},
	-- exclude_buftypes = {},
	-- Exclude buffer from highlighting e.g. 'exclude_buffer = function(bufnr) return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1000000 end'
	-- exclude_buffer = function(bufnr) end,
})

vim.pack.add({ gh('MeanderingProgrammer/render-markdown.nvim') })


-- TREESITTER --
vim.pack.add({ gh("nvim-treesitter/nvim-treesitter") })
local treesitter = require("nvim-treesitter")
treesitter.setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
    highlight = { enable = true },
    indent = { enable = true },
})
treesitter.install({
    "lua", "python", "go", "html", "json", "xml", "sql", "templ", "javascript",
})
---------

-- TELESCOPE --
local install_telescope_fzf = function (ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
        vim.system({ "make" }, { cwd = ev.data.path }):wait()
    end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = install_telescope_fzf })
vim.pack.add({ gh("nvim-lua/plenary.nvim") })
vim.pack.add({ gh("nvim-telescope/telescope-fzf-native.nvim") })
vim.pack.add({ gh("nvim-telescope/telescope.nvim") })
vim.pack.add({ gh("nvim-telescope/telescope-ui-select.nvim") })
local telescope = require("telescope")
telescope.setup({
    extensions = {
        fzf = {},
        ["ui-select"] =  {
            require("telescope.themes").get_dropdown({}),
        }
    },
    defaults = {
        file_ignore_patterns = { "node_modules", "venv", "__pycache__" },
    },
})
telescope.load_extension("fzf")
telescope.load_extension("ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<C-b>", builtin.buffers, {})
vim.keymap.set("n", "<C-h>", builtin.command_history, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>mp", builtin.man_pages, {})
---------

-- LSP --
vim.pack.add({ gh("nvimtools/none-ls.nvim") })
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.pyink,
    },
})
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

vim.pack.add({
    gh("hrsh7th/cmp-nvim-lsp"),
    gh("saadparwaiz1/cmp_luasnip"),
    gh("rafamadriz/friendly-snippets"),
    gh("L3MON4D3/LuaSnip"),
    gh("hrsh7th/nvim-cmp"),
})
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if luasnip.expandable() then
					luasnip.expand()
				else
					cmp.confirm({
						select = true,
					})
				end
			else
				fallback()
			end
		end),
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		format = require("nvim-highlight-colors").format,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

vim.pack.add({
    gh("williamboman/mason.nvim"),
	gh("williamboman/mason-lspconfig.nvim"),
	gh("neovim/nvim-lspconfig"),
})
require("mason").setup()
require("mason-lspconfig").setup({
   ensure_installed = {
   	"lua_ls",
   	-- "pyright",
    -- "pylsp",
   	"html",
   	"gopls",
   	"templ",
   	"jsonls",
   	"cssls",
   	"tailwindcss",
   	"ts_ls",
   	"clangd",
   	"htmx",
   	"denols",
   	-- "rust_analyzer",
   },
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.lsp.config.lua_ls = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
}

vim.lsp.config.clangd = {
  cmd = {
    'clangd',
    '--clang-tidy',
    '--background-index',
    '--offset-encoding=utf-8',
  },
  root_markers = { '.clangd', 'compile_commands.json' },
  filetypes = { 'c', 'cpp' },
}
vim.lsp.config.gdscript = {
    name = "godot",
    cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
}
vim.lsp.config.tailwindcss = {
    include_languages = { html =  "templ" },
	capabilities = capabilities,
}
vim.diagnostic.config({ underline = false })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

vim.pack.add({ gh("mfussenegger/nvim-dap") })
local dap = require("dap")
dap.adapters.godot = {
    type = "server",
    host = "127.0.0.1",
    port = 6006,
}
dap.configurations.gdscript = {
    {
        type = "godot",
        request = "launch",
        name = "Launch scene",
        project = "${workspaceFolder}",
        launch_scene = true,
    },
}

vim.pack.add({ gh("mrcjkb/rustaceanvim") })
---------
