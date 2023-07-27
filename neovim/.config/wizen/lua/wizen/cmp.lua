local function cmp_opt()
  local cmp = require("cmp")
  local cmp_select = { behavior = cmp.SelectBehavior.Select }

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api
          .nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match("%s")
        == nil
  end

  local luasnip = require("luasnip")

  local icons = require("wizen.icons")

  return {
    snippet = {
      expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    formatting = {
      fields = { "abbr", "kind", "menu" },
      format = function(entry, vim_item)
        local client_name = ""
        if entry.source.name == "nvim_lsp" then
          client_name = "/" .. entry.source.source.client.name
        end

        vim_item.menu = string.format("%s%s", ({
          buffer = "﬘ Buffer",
          nvim_lsp = " ",
          luasnip = "🧞 Luasnip",
          nvim_lua = "󰢱 ",
          path = "󰑢 Path",
          rg = "RripGrep",
          omni = "Omni",
          neorg = "🦄 Neorg",
        })[entry.source.name] or entry.source.name, client_name)

        vim_item.kind = string.format("%s %-9s", icons.kinds[vim_item.kind], vim_item.kind)
        vim_item.dup = {
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
          luasnip = 1,
        }
        return vim_item
      end,
    },
    window = {
      completion = cmp.config.window.bordered {
        winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
        -- winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",
        scrollbar = true,
        border = icons.border_chars_outer_thin,
        -- side_padding = 1,
      },
      documentation = cmp.config.window.bordered {
        winhighlight = "Normal:Pmenu,FloatBorder:PmenuDocBorder,CursorLine:PmenuSel,Search:None",
        scrollbar = true,
        border = icons.border_chars_outer_thin,
        -- side_padding = 3, -- Not working?
      },
    },
    view = {
      entries = { name = "custom", selection_order = "near_cursor" },
    },
    mapping = {
      ["<C-k>"] = cmp.mapping(
        cmp.mapping.select_prev_item(cmp_select),
        { "i", "c" }
      ),
      ["<C-j>"] = cmp.mapping(
        cmp.mapping.select_next_item(cmp_select),
        { "i", "c" }
      ),
      ["<Up>"] = cmp.mapping(
        cmp.mapping.select_prev_item(cmp.select),
        { "i", "c" }
      ),
      ["<Down>"] = cmp.mapping(
        cmp.mapping.select_next_item(cmp.select),
        { "i", "c" }
      ),
      ["<M-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-4),
      { "i", "c" }),
      ["<M-j>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping({
        i = require("copilot.suggestion").next,
        c = cmp.complete,
      }),
      ["<C-e>"] = cmp.mapping(function()
        local suggestion = require("copilot.suggestion")
        if cmp.visible() then
          cmp.abort()
        elseif suggestion.is_visible() then
          suggestion.dismiss()
        end
      end, { "i", "c" }),
      ["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end, { "i", "c" }),
      -- ["<CR>"] = cmp.mapping(function(fallback) fallback() end, { "i", "c" }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        local suggestion = require("copilot.suggestion")
        if suggestion.is_visible() then
          suggestion.accept()
        elseif cmp.visible() then
          cmp.confirm({ select = true })
        -- elseif luasnip.expand_or_jumpable() then
        -- 	luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "c" }),
    },
    sources = cmp.config.sources({
      {
        name = "nvim_lsp",
        priority = 80,
        group_index = 1,
      },
      { name = "nvim_lua", priority = 80, group_index = 1 },
      { name = "path", priority = 40, group_index = 5 },
      { name = "luasnip", priority = 10, group_index = 2 },
      { name = "calc", group_index = 3 },
      { name = "nvim_lsp_signature_help" },
      {
        name = "buffer",
        priority = 5,
        keyword_length = 3,
        group_index = 5,
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      },
      {
        name = "rg",
        keyword_length = 3,
        priority = 5,
        group_index = 5,
        option = {
          additional_arguments = "--max-depth 6 --one-file-system --ignore-file ~/.config/nvim/scripts/rgignore",
        },
      },
      { name = "emoji", priority = 2 },
      { name = "nerdfont", priority = 1 },
      { name = "neorg", keyword_length = 1 },
      { name = "dynamic", keyword_length = 1 },
    })

  }
end

local cmp = require("cmp")
cmp.setup(cmp_opt())

local ts_utils = require("nvim-treesitter.ts_utils")
local pairs_cmp = require("nvim-autopairs.completion.cmp")
local pairs = require("nvim-autopairs")
local ts_node_func_parens_disabled = {
  -- don't create autopairs for
  -- `use crate::<function>`
  -- or
  -- `use crate::{ ..., <function> }`
  use_declaration = true,
  use_list = true,

  -- don't create autopairs for attribute macros (Rust)
  -- for example, there should not be autopairs after `test` in `#[test]`
  attribute_item = true,
  attribute = true,
  source_file = true,
}

local default_handler = pairs_cmp.filetypes["*"]["("].handler
pairs_cmp.filetypes["*"]["("].handler = function(
  char,
  item,
  bufnr,
  rules,
  commit_character
)
  local node = ts_utils.get_node_at_cursor()
  local node_type = node:type()
  if ts_node_func_parens_disabled[node_type] then
    if item.data then
      item.data.funcParensDisabled = true
    else
      char = ""
    end
  end
  default_handler(char, item, bufnr, rules, commit_character)
end

cmp.event:on("confirm_done", pairs_cmp.on_confirm_done())

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "cmdline", group_index = 1 },
    -- { name = "async_path", group_index = 1 },
    { name = "cmdline_history", group_index = 2 },
    { name = "copilot", group_index = 2 },
  }),
  enabled = function()
    -- Set of disable commands
    local disabled = {
      IncRename = true,
    }
    -- get first word of cmdline
    local cmd = vim.fn.getcmdline():match("%S+")
    return (not disabled[cmd]) or cmp.close()
  end,
})

cmp.setup.filetype("harpoon", {
  sources = cmp.config.sources({
    { name = "async_path" },
  }),
})

cmp.setup.filetype("gitcommit", {
  sources = {
    { name = "commit" },
    { name = "async_path" },
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol" },
    { name = "buffer" },
  }),
})
