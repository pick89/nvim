return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
        "cucumber_language_server",
        "grammarly",
        "sqls",
        "taplo",
        "lemminx",
        "kotlin_language_server",
        "jsonls",
        "gradle_ls",
        "golangci_lint_ls",  -- corrected spelling for Go language server
        "astro",
        "jdtls",  -- corrected Java language server
      },
    })
  end,
}
