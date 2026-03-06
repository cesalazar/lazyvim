return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
      { "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
      { "<leader>bi", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<M-i>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
      { "<M-o>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
    },
    opts = {
      options = {
        always_show_bufferline = true,
        auto_toggle_bufferline = false,
      },
    },
  },
}
