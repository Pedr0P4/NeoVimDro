require("pedroconfig.core.keymap")
require("pedroconfig.core.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require('lazy').setup({
	{'folke/tokyonight.nvim'},
	{'rafamadriz/neon'},
	{'nvim-lualine/lualine.nvim'},
	{'nvim-tree/nvim-web-devicons'},
	{'rcarriga/nvim-notify'},
	{'nvim-tree/nvim-tree.lua'},
	{'voldikss/vim-floaterm'},
})

require('lualine').setup {
	options = {
		theme = 'neon',  
		neon_style = 'default'
	}
}

vim.opt.termguicolors = true
vim.cmd.colorscheme('neon')


-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
