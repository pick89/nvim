return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    { "b0o/schemastore.nvim", ft = "json" }, -- Optional: Include only if JSON schema support is needed
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Set up key mappings for LSP
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references", unpack(opts) })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", unpack(opts) })
        -- Add other key mappings as needed...
      end,
    })

    -- Configure diagnostic symbols in the sign column
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Set up Mason handlers for LSP servers
    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({ capabilities = capabilities })
      end,

      -- Specific configuration for various language servers
      ["pyright"] = function()
        lspconfig["pyright"].setup({ capabilities = capabilities })
      end,

      ["dockerls"] = function()
        lspconfig["dockerls"].setup({ capabilities = capabilities })
      end,

      ["jdtls"] = function()
        lspconfig["jdtls"].setup({ capabilities = capabilities })
      end,

      ["jsonls"] = function()
        -- JSON configuration with optional schemastore integration
        local jsonls_config = {
          capabilities = capabilities,
        }

        -- Use schemastore if available
        if pcall(require, "schemastore") then
          jsonls_config.settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          }
        end

        lspconfig["jsonls"].setup(jsonls_config)
      end,

      ["kotlin_language_server"] = function()
        lspconfig["kotlin_language_server"].setup({ capabilities = capabilities })
      end,

      ["sourcekit"] = function()
        lspconfig["sourcekit"].setup({ capabilities = capabilities })
      end,

      ["gopls"] = function()
        lspconfig["gopls"].setup({
          capabilities = capabilities,
          settings = {
            gopls = {
              analyses = { unusedparams = true },
              staticcheck = true,
            },
          },
        })
      end,
    })
  end,
}
