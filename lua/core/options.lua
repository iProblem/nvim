local opts = {
	expandtab = true,
	smarttab = true,
	tabstop = 4,
	shiftwidth = 4,
	autoindent = true,

	hlsearch = true,
	incsearch = true,
	ignorecase = true,
	smartcase = true,

	splitbelow = true,
	splitright = true,
--    wrap = false,
	scrolloff = 10,
	fileencoding = "utf-8",
	termguicolors = true,
	title = true,

	number = true,
	relativenumber = true,
	cursorline = true,
	hidden = true,
	mouse = "a",
--	colorcolumn = "80",
	signcolumn = 'yes',

	spelllang = "pt",
}


-- Set options from table
for opt, val in pairs(opts) do
	vim.o[opt] = val
end


-- Set other options
vim.opt.clipboard = "unnamedplus"

local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)
