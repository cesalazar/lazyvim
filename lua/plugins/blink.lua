return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        -- Use <C-Space> instead
        documentation = { auto_show = false },
        ghost_text = { enabled = false },
        list = { selection = { preselect = false, auto_insert = false } },
        menu = { auto_show = true },
      },
      keymap = {
        ["<C-A-j>"] = { "scroll_documentation_down", "fallback" },
        ["<C-A-k>"] = { "scroll_documentation_up", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "show", "select_next", "fallback" },
      },
      -- sources = {
      --   providers = {
      --     snippets = { score_offset = 1 },
      --   },
      -- },
    },
  },
}
