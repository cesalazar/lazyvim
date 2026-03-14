return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, _)
        -- bg #1a1b26 (L≈12.5%) → +10% lightness
        hl.ColorColumn = { bg = "#2f3144" }

        -- bg #1a1b26 (L≈12.5%) → +13% lightness
        hl.WinSeparator = { fg = "#35374d" }

        -- Visual gets underlined only
        hl.Visual = { undercurl = true, sp = "#7aa2f7", bg = "NONE" }
        hl.VisualNOS = { undercurl = true, sp = "#7aa2f7", bg = "NONE" }
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
