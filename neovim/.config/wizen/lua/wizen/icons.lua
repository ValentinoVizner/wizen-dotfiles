local M = {}

M.kinds = {
    Array = "[]",
    Boolean = " ",
    Calendar = " ",
    Class = "󰠱 ",
    Codeium = " ",
    Color = "󰏘 ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = "󰜢 ",
    File = "󰈚 ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = "󰌋 ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = "ﳠ ",
    Number = " ",
    Object = "󰅩 ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = "󰙅 ",
    Table = " ",
    TabNine = "",
    Tag = " ",
    Text = "󰉿 ",
    TypeParameter = "󰊄 ",
    Unit = "󰑭 ",
    Value = "󰎠 ",
    Variable = "󰀫 ",
}

M.diagnostics = {
  errors = "🔥", --
  warnings = " ", -- "",--
  hints = "󱩑 ", --"󰮔",
  info = "💬",
}
M.diagnostics.Error = M.diagnostics.errors
M.diagnostics.Warn = M.diagnostics.warnings
M.diagnostics.Hint = M.diagnostics.hints
M.diagnostics.Info = M.diagnostics.info

M.lsp = {
  action_hint = "",
}

M.git = {
  diff = {
    added = "",
    modified = "󰆗 ",
    removed = "󰩹 ",
  },
  signs = {
    bar = "┃",
    untracked = "•",
  },
  branch = "",
  copilot = "",
  copilot_err = "",
  copilot_warn = "",
}

M.dap = {
  breakpoint = {
    conditional = "",
    data = "",
    func = "",
    log = "",
    unsupported = "",
  },
  action = {
    continue = "",
    coverage = "",
    disconnect = "",
    line_by_line = "",
    pause = "",
    rerun = "",
    restart = "",
    restart_frame = "",
    reverse_continue = "",
    start = "",
    step_back = "",
    step_into = "",
    step_out = "",
    step_over = "",
    stop = "",
  },
  stackframe = "",
  stackframe_active = "",
  console = "",
}

M.actions = {
    close_hexagon = "󰅜 ",
    close2 = "󰅙 ",
    close_round = "󰅙 ",
    close_outline = "󰅚 ",
    close = " ",
    close_box = "󰅗",
}

M.fold = {
  open = "",
  closed = "",
}

M.separators = {
  angle_quote = {
    left = "«",
    right = "»",
  },
  chevron = {
    left = "",
    right = "",
    down = "",
  },
  circle = {
    left = "",
    right = "",
  },
  arrow = {
    left = "",
    right = "",
  },
  slant = {
    left = "",
    right = "",
  },
  bar = {
    left = "⎸",
    right = "⎹",
  },
}

M.blocks = {
  left = {
    "▏",
    "▎",
    "▍",
    "▌",
    "▋",
    "▊",
    "▉",
    "█",
  },
  right = {
    eighth = "▕",
    half = "▐",
    full = "█",
  },
}

M.misc = {
  datetime = "󱛡 ",
  modified = "●",
  fold = "",
  newline = "",
  circle = "",
  circle_filled = "",
  circle_slash = "",
  ellipse = "…",
  ellipse_dbl = "",
  kebab = "",
  tent = "⛺",
  comma = "󰸣",
  hook = "󰛢",
  hook_disabled = "󰛣",
}

  M.border_chars = {
    border_chars_none = { "", "", "", "", "", "", "", "" },
    border_chars_empty = { " ", " ", " ", " ", " ", " ", " ", " " },
    border_chars_tmux = { " ", " ", " ", " ", " ", " ", " ", " " },
    border_chars_inner_thick = { " ", "▄", " ", "▌", " ", "▀", " ", "▐" },
    border_chars_outer_thick = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
    border_chars_outer_thin = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    border_chars_inner_thin = { " ", "▁", " ", "▏", " ", "▔", " ", "▕" },
    border_chars_outer_thin_telescope = {
      "▔",
      "▕",
      "▁",
      "▏",
      "🭽",
      "🭾",
      "🭿",
      "🭼",
    },
    border_chars_outer_thick_telescope = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
  }
return M
