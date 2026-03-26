return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        vtsls = {
          handlers = {
            -- Disabled diagnostics:
            -- 6133 - Could not find a declaration file for module...
            -- 7016 - The imports and exports are not sorted
            ["textDocument/publishDiagnostics"] = function(err, result, ctx)
              local ignoredCodes = { 6133, 7016 }
              if result and result.diagnostics then
                result.diagnostics = vim.tbl_filter(function(d)
                  return not vim.tbl_contains(ignoredCodes, d.code)
                end, result.diagnostics)
              end
              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
            end,
          },
        },
        ["*"] = {
          keys = {
            { "<a-n>", false },
          },
        },
      },
    },
  },
}
