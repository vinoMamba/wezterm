local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- config
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"

--Colors & Appearance
config.color_scheme = 'Arthur'
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

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

config.window_background_opacity = 0.9
config.text_background_opacity = 0.3

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

local act = wezterm.action

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    { key = 'r', mods = 'SUPER', action = act.ReloadConfiguration },
    { key = 'q', mods = 'CTRL', action = act.QuitApplication },
    -- tab
    { key = 'n', mods = 'ALT',    action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'q', mods = 'LEADER', action = act.CloseCurrentTab { confirm = false } },
    { key = '=', mods = 'ALT', action = act.ActivateTabRelative(1) },
    { key = '-', mods = 'ALT', action = act.ActivateTabRelative(-1) },
    { key = 'f', mods = 'ALT', action = act.ToggleFullScreen },
    -- move tab
    { key = ']', mods = 'ALT', action = act.MoveTabRelative(1) },
    { key = '[', mods = 'ALT', action = act.MoveTabRelative(-1) },

    -- window
    { key = 'N', mods = 'ALT', action = act.SpawnWindow },

    -- font size
    { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize },

    --panel
    { key = 'j', mods = 'ALT', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
    { key = 'l', mods = 'ALT', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
    { key = 'q', mods = 'LEADER', action = act.CloseCurrentPane{ confirm = false } },

    { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },
    { key = 'z', mods = 'CTRL', action = act.TogglePaneZoomState },

    { key = 'h', mods = 'LEADER', action = act.AdjustPaneSize{ 'Left',  5 } },
    { key = 'j', mods = 'LEADER', action = act.AdjustPaneSize{ 'Down',  5 } },
    { key = 'k', mods = 'LEADER', action = act.AdjustPaneSize{ 'Up',    5 } },
    { key = 'l', mods = 'LEADER', action = act.AdjustPaneSize{ 'Right', 5 } },


    { key = '\\', mods = 'ALT', action = act.QuickSelect },

    { key = 'f', mods = 'CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'm', mods = 'CTRL', action = act.Hide },
    { key = 'P', mods = 'CTRL', action = act.ActivateCommandPalette },
}

-- Mouse Bingding
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },
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
  window:gui_window():set_inner_size(1600, 1000)
  window:gui_window():set_position(1000, 500)

end)


-- config.status_update_interval = 1000
-- wezterm.on("update-status", function(window)
--
--   window:set_right_status(wezterm.format({
--     { Text = "vino" },
--   }))
-- end)



return config
