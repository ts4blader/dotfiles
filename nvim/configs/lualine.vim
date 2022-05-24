lua << END
local colors = {
bg       = '#202328',
fg       = '#bbc2cf',
yellow   = '#ECBE7B',
cyan     = '#008080',
darkblue = '#081633',
green    = '#98be65',
orange   = '#FF8800',
violet   = '#a9a1e1',
magenta  = '#c678dd',
blue     = '#51afef',
red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = { 'NvimTree' },
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch' },
    lualine_c = {'filename'},
    lualine_x = {'diagnostics', 
        {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '★ ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
 },
  cond = conditions.hide_in_width,
}
    },
    lualine_y = {
      {
          'filetype',
          icons_enabled = false
      }
    },
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
END
