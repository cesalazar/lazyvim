return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        vtsls = {
          handlers = {
            -- Disable diagnostic "Could not find a declaration file for module ..."
            ["textDocument/publishDiagnostics"] = function(err, result, ctx)
              if result and result.diagnostics then
                result.diagnostics = vim.tbl_filter(function(d)
                  return d.code ~= 7016
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
