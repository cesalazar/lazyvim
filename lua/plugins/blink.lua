return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
      },
      sources = {
        providers = {
          snippets = { score_offset = 1 },
        },
      },
    },
  },
}
