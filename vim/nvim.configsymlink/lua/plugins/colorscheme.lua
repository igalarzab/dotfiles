return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    opts = {
        default_integrations = true,
        auto_integrations = true,
        flavour = "macchiato",
        background = {
        light = "latte",
        dark = "macchiato",
        }
    }
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}