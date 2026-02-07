if vim.loader then
    vim.loader.enable()
end
require("options")
require("keybindings")
require("text_objects").setup()
require("lazy_nvim")

vim.o.updatetime = 300
vim.cmd("colorscheme tokyonight-night")
