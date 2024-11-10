return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*", -- follow latest release
      build = "make install_jsregexp", -- optional: for regex support in snippets
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion with luasnip
    "rafamadriz/friendly-snippets", -- useful snippets collection
    "onsails/lspkind.nvim", -- for vscode-like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load snippets from friendly-snippets and other plugins
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll up in docs
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll down in docs
        ["<C-Space>"] = cmp.mapping.complete(), -- trigger completion
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- confirm selection
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP suggestions
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
      -- configure lspkind for vscode-like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text", -- Show symbol and text
          maxwidth = 50, -- limits completion window width
          ellipsis_char = "...", -- truncates with ellipsis if max width is exceeded
          fields = { "kind", "abbr", "menu" }, -- specify fields to display
          expandable_indicator = true, -- show an expandable indicator
        }),
      },
    })
  end,
}
