lua << EOF
-- Set barbar's options
vim.g.bufferline = {
  -- Enable/disable animations
  animation = false,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  exclude_ft = {'javascript'},
  exclude_name = {'package.json'},

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = true,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,

}
  vim.api.nvim_create_autocmd('BufWinEnter', {
	pattern = '*',
	callback = function()
		if vim.bo.filetype == 'NvimTree' then
			require'bufferline.state'.set_offset(31, 'FileTree')
		end
	end
  })

  vim.api.nvim_create_autocmd('BufWinLeave', {
	pattern = '*',
	callback = function()
		if vim.fn.expand('<afile>'):match('NvimTree') then
			require'bufferline.state'.set_offset(0)
		end
	end
  })

-- !::exe [So]

local icons = require 'bufferline.icons'

-------------------
-- Section: helpers
-------------------

--- Generate a color.
--- @param index string where to look for the color.
--- @param groups table<string> the groups to source the color from.
--- @param default string the color to use if no `groups` have a valid color.
--- @param default_cterm number|string the color to use if no `groups` have a valid color and `termguicolors == false`.
--- @return number|string color
local function color(index, groups, default, default_cterm)
  local guicolors = vim.go.termguicolors
  for _, group in ipairs(groups) do
    local hl = vim.api.nvim_get_hl_by_name(group, guicolors)
    if hl[index] then
      return guicolors and string.format('#%06x', hl[index]) or hl[index]
    end
  end
  return guicolors and default or default_cterm
end

--- Generate a foreground color.
--- @param groups table<string> the groups to source the foreground color from.
--- @param default string the foreground color to use if no `groups` have a valid foreground color.
--- @param default_cterm number|string the color to use if no `groups` have a valid color and `termguicolors == false`.
--- @return number|string color
local function fg(groups, default, default_cterm)
  return color('foreground', groups, default, default_cterm or default)
end

--- Generate a background color.
--- @param groups table<string> the groups to source the background color from.
--- @param default string the background color to use if no `groups` have a valid background color.
--- @param default_cterm number|string the color to use if no `groups` have a valid color and `termguicolors == false`.
--- @return number|string color
local function bg(groups, default, default_cterm)
  return color('background', groups, default, default_cterm or default)
end

------------------
-- Section: module
------------------

--- @class bufferline.highlight
local highlight = {}

-- Initialize highlights
function highlight.setup()
  local fg_target = 'red'

  local fg_current  = fg({'Normal'}, '#efefef', 255)
  local fg_visible  = fg({'TabLineSel'}, '#efefef', 255)
  local fg_inactive = fg({'TabLineFill'}, '#888888', 102)

  local fg_modified = fg({'WarningMsg'}, '#E5AB0E', 178)
  local fg_special  = fg({'Special'}, '#599eff', 75)
  local fg_subtle = fg({'NonText', 'Comment'}, '#555555', 240)

  local bg_current  = bg({'Normal'}, 'none', nil)
  local bg_visible  = bg({'TabLineSel', 'Normal'}, 'none', nil)
  local bg_inactive = bg({'TabLineFill', 'StatusLine'}, 'none', nil)

  --      Current: current buffer
  --      Visible: visible but not current buffer
  --     Inactive: invisible but not current buffer
  --        -Icon: filetype icon
  --       -Index: buffer index
  --         -Mod: when modified
  --        -Sign: the separator between buffers
  --      -Target: letter in buffer-picking mode
  local hl = vim.go.termguicolors and
    function(group, background, foreground, bold)
      vim.api.nvim_set_hl(0, group, {
        bg = background,
        bold = bold,
        default = true,
        fg = foreground,
      })
    end or
    function(group, background, foreground, bold)
      vim.api.nvim_set_hl(0, group, {
        bold = bold,
        ctermbg = background,
        ctermfg = foreground,
        default = true,
      })
    end

  hl('BufferCurrent',        bg_current, fg_current)
  hl('BufferCurrentIndex',   bg_current, fg_special)
  hl('BufferCurrentMod',     bg_current, fg_modified)
  hl('BufferCurrentSign',    bg_current, fg_special)
  hl('BufferCurrentTarget',  bg_current, fg_target, true)
  hl('BufferInactive',       bg_inactive, fg_inactive)
  hl('BufferInactiveIndex',  bg_inactive, fg_subtle)
  hl('BufferInactiveMod',    bg_inactive, fg_modified)
  hl('BufferInactiveSign',   bg_inactive, fg_subtle)
  hl('BufferInactiveTarget', bg_inactive, fg_target, true)
  hl('BufferTabpageFill',    bg_inactive, fg_inactive)
  hl('BufferTabpages',       bg_inactive, fg_special, true)
  hl('BufferVisible',        bg_visible, fg_visible)
  hl('BufferVisibleIndex',   bg_visible, fg_visible)
  hl('BufferVisibleMod',     bg_visible, fg_modified)
  hl('BufferVisibleSign',    bg_visible, fg_visible)
  hl('BufferVisibleTarget',  bg_visible, fg_target, true)

  vim.api.nvim_set_hl(0, 'BufferCurrentIcon', {default = true, link = 'BufferCurrent'})
  vim.api.nvim_set_hl(0, 'BufferInactiveIcon', {default = true, link = 'BufferInactive'})
  vim.api.nvim_set_hl(0, 'BufferVisibleIcon', {default = true, link = 'BufferVisible'})
  vim.api.nvim_set_hl(0, 'BufferOffset', {default = true, link = 'BufferTabpageFill'})

  icons.set_highlights()
end

return highlight


EOF


" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>

" Pin/unpin buffer
nnoremap <silent>    <A-p> :BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>

" Magic buffer-picking mode
nnoremap <silent> <leader>b  :BufferPick<CR>
