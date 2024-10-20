return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },
  { "tomasiser/vim-code-dark" },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    options = {
      transparency = true,
    },
  },
  {
    "Mofiqul/adwaita.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.adwaita_darker = true -- for darker version
      vim.g.adwaita_disable_cursorline = true -- to disable cursorline
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "tjdevries/colorbuddy.nvim",
  },
  {
    "svrana/neosolarized.nvim",
  },
}
