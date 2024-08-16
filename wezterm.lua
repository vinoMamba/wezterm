local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- config
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"

if string.find(wezterm.target_triple, "windows") then
  config.default_domain = "WSL:Arch"
end

--Colors & Appearance
config.color_scheme = 'Dark Flat'
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.show_tab_index_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
-- SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar
config.default_cursor_style = 'SteadyUnderline'

config.window_padding = {
  left = 10,
  right = 0,
  top = 20,
  bottom = 0,
}

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

config.window_background_opacity = 0.3
config.text_background_opacity = 0.3
config.macos_window_background_blur = 20

-- Fonts
config.font = wezterm.font_with_fallback({
  {
    family = "JetBrains Mono",
    scale = 1.24,
    weight = "Medium",
    -- italic = true,
    -- => != !==
    -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  },
})

-- Key Bingding
config.disable_default_key_bindings = true

local act = wezterm.action

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  { key = 'r',          mods = 'LEADER',         action = act.ReloadConfiguration },
  { key = 'n',          mods = 'LEADER',         action = act.SpawnWindow },
  { key = 'w',          mods = 'LEADER',         action = act.CloseCurrentTab { confirm = true } },
  { key = 'q',          mods = 'LEADER',         action = act.QuitApplication },
  { key = 'f',          mods = 'LEADER',         action = act.ToggleFullScreen },
  { key = 'n',          mods = 'ALT',            action = act.SpawnTab 'CurrentPaneDomain' },

  { key = '=',          mods = 'LEADER',         action = act.ActivateTabRelative(1) },
  { key = '-',          mods = 'LEADER',         action = act.ActivateTabRelative(-1) },

  { key = 'l',          mods = 'LEADER',         action = act.ActivateWindowRelative(1) },
  { key = 'h',          mods = 'LEADER',         action = act.ActivateWindowRelative(-1) },

  { key = '0',          mods = 'SHIFT|CTRL',     action = act.ResetFontSize },
  { key = '+',          mods = 'SHIFT|CTRL',     action = act.IncreaseFontSize },
  { key = '-',          mods = 'SHIFT|CTRL',     action = act.DecreaseFontSize },
  { key = 'H',          mods = 'LEADER',         action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'V',          mods = 'LEADER',         action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'c',          mods = 'SUPER',          action = act.CopyTo 'Clipboard' },
  { key = 'v',          mods = 'SUPER',          action = act.PasteFrom 'Clipboard' },



  { key = 'F',          mods = 'CTRL',           action = act.Search 'CurrentSelectionOrEmptyString' },

  { key = 'P',          mods = 'CTRL',           action = act.ActivateCommandPalette },
  { key = 'X',          mods = 'CTRL',           action = act.ActivateCopyMode },
  { key = 'Z',          mods = 'CTRL',           action = act.TogglePaneZoomState },
  { key = 'Q',          mods = 'CTRL',           action = act.QuickSelect },

  { key = 'PageUp',     mods = 'SHIFT',          action = act.ScrollByPage(-1) },
  { key = 'PageDown',   mods = 'SHIFT',          action = act.ScrollByPage(1) },
  { key = 'PageDown',   mods = 'SHIFT|CTRL',     action = act.MoveTabRelative(1) },
  { key = 'LeftArrow',  mods = 'SHIFT|CTRL',     action = act.ActivatePaneDirection 'Left' },
  { key = 'LeftArrow',  mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Left', 1 } },
  { key = 'RightArrow', mods = 'SHIFT|CTRL',     action = act.ActivatePaneDirection 'Right' },
  { key = 'RightArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Right', 1 } },
  { key = 'UpArrow',    mods = 'SHIFT|CTRL',     action = act.ActivatePaneDirection 'Up' },
  { key = 'UpArrow',    mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Up', 1 } },
  { key = 'DownArrow',  mods = 'SHIFT|CTRL',     action = act.ActivatePaneDirection 'Down' },
  { key = 'DownArrow',  mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Down', 1 } },
}

config.key_tables = {
  copy_mode = {
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },

    { key = 'v',      mods = 'NONE', action = act.CopyMode { SetSelectionMode = 'Cell' } },
    { key = 'V',      mods = 'NONE', action = act.CopyMode { SetSelectionMode = 'Line' } },
    { key = 'v',      mods = 'CTRL', action = act.CopyMode { SetSelectionMode = 'Block' } },

    { key = 'b',      mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
    { key = 'w',      mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
    { key = 'e',      mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },

    { key = 'h',      mods = 'NONE', action = act.CopyMode 'MoveLeft' },
    { key = 'j',      mods = 'NONE', action = act.CopyMode 'MoveDown' },
    { key = 'k',      mods = 'NONE', action = act.CopyMode 'MoveUp' },
    { key = 'l',      mods = 'NONE', action = act.CopyMode 'MoveRight' },

    { key = 'L',      mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = 'H',      mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },

    { key = 'y',      mods = 'NONE', action = act.Multiple { { CopyTo = 'ClipboardAndPrimarySelection' }, { CopyMode = 'Close' } } },
  },
  search_mode = {
    { key = 'Enter',     mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'Escape',    mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'n',         mods = 'CTRL', action = act.CopyMode 'NextMatch' },
    { key = 'p',         mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
    { key = 'r',         mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
    { key = 'u',         mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
    { key = 'PageUp',    mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
    { key = 'PageDown',  mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
    { key = 'UpArrow',   mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
  }
}


-- Mouse Bingding
config.mouse_bindings = {
  -- copy the selection
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },

  -- Open HyperLink
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
}

-- event: gui-startup
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():set_inner_size(1800, 1400)
  window:gui_window():set_position(200, 100)
end)

-- event: update-status
config.status_update_interval = 1000
wezterm.on("update-status", function(window)
  local date = wezterm.strftime '%b %-d %H:%M '

  window:set_right_status(wezterm.format({
    { Text = ' ' },
    { Foreground = { Color = '#74c7ec' } },
    { Background = { Color = 'rgba(0,0,0,0.4)' } },
    { Attribute = { Intensity = "Bold" } },
    { Text = wezterm.nerdfonts.fa_calendar .. ' ' .. date },
    { Text = ' ' },
  }))
end)

-- event: format-tab-title

wezterm.on('format-tab-title', function(tab, _, _, _, _)
  -- i do not like how i can basically hide tabs if i zoom in
  local is_zoomed = ''
  if tab.active_pane.is_zoomed then
    is_zoomed = 'z'
  end

  return {
    { Text = ' ' .. tab.tab_index + 1 .. is_zoomed .. ' ' },
  }
end)

return config
