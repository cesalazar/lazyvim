return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, _)
        -- bg #1a1b26 (L≈12.5%) → +10% lightness
        hl.ColorColumn = { bg = "#2f3144" }

        -- bg #1a1b26 (L≈12.5%) → +13% lightness
        hl.WinSeparator = { fg = "#35374d" }
      end,

      -- -- Make TokyoNight Transparent
      -- transparent = true,
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },
    },
  },
}
