return {
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        top_down = false,
      },
      picker = {
        layouts = {
          default = {
            fullscreen = true,
            layout = {
              box = "horizontal",
              width = 0.8,
              min_width = 120,
              height = 0.8,
              {
                box = "vertical",
                border = true,
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", border = true, width = 2 / 3 },
            },
          },
        },
        win = {
          input = {
            keys = {
              ["<C-p>"] = { "history_back", mode = { "i", "n" } },
              ["<C-n>"] = { "history_forward", mode = { "i", "n" } },
              ["<C-A-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<C-A-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<C-p>"] = "history_back",
              ["<C-n>"] = "history_forward",
              ["<C-A-j>"] = "preview_scroll_down",
              ["<C-A-k>"] = "preview_scroll_up",
            },
          },
        },
      },
    },
  },
}
