-- ~/.wezterm.lua -------------------------------------------------
local wezterm = require 'wezterm'
local config  = wezterm.config_builder()

-- --------  Fonts & text  ---------
config.font      = wezterm.font_with_fallback {
  'JetBrainsMono Nerd Font',      -- primary
  'SF Mono',                      -- fall-back
  'Apple Color Emoji',            -- emoji
}
config.font_size   = 26
config.line_height = 1.05         -- tighter vertical rhythm
config.bold_brightens_ansi_colors = true

-- --------  Colours  -------------
config.color_scheme = 'Catppuccin Mocha'  -- any of the 1000+ built-ins
-- ↳ list them on demand:
-- print(vim.inspect(wezterm.color.get_builtin_schemes()))

-- Optional manual tweaks
config.colors = {
  foreground = '#c0caf5',
  background = '#000000',
}

-- --------  Window aesthetics ----
config.window_decorations        = 'RESIZE'  -- no title-bar buttons
-- config.window_frame = {
--     border_left_width   = '0.035cell',
--     border_right_width  = '0.035cell',
--     border_top_height   = '0.0175cell',
--     border_bottom_height= '0.0175cell',
--     border_left_color   = '#97abc2',
--     border_right_color  = '#97abc2',
--     border_top_color    = '#97abc2',
--     border_bottom_color = '#97abc2',
--  }
config.window_background_opacity = 0.95
config.window_padding= { left = 0, right = 0, top = 0, bottom = 0 }

-- Optional textured backdrop
-- config.window_background_image = '/Users/francis/Pictures/grid.png'
-- config.window_background_image_hsb = { brightness = 0.08, hue = 1.0, saturation = 0.2 }

-- --------  Tab-bar  --------------
config.use_fancy_tab_bar              = false
config.hide_tab_bar_if_only_one_tab   = true
config.colors.tab_bar = {
  background = '#101010',
  active_tab =  { bg_color = '#2d3149', fg_color = '#c0caf5', intensity = 'Bold' },
  inactive_tab = { bg_color = '#1b1d2b', fg_color = '#7f85a3' },
}

-- --------  Cursor ----------------
config.default_cursor_style = 'SteadyBlock'

-- --------  Key-bindings (look) ---
config.keys = {
  { key = 'S', mods = 'CTRL|SHIFT', action = wezterm.action.PromptInputLine {
      description = 'Colour scheme:',
      action = wezterm.action_callback(function(window, _, line)
        if line then window:perform_action(
          wezterm.action{SetColorScheme={Scheme=line}}, window:active_pane()) end
      end)}
  },
    {
      key = 'w',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
        key = 'h',
        mods='ALT',
        action=wezterm.action.ActivateWindow(0),
    },
    {
        key = 'j',
        mods='ALT',
        action=wezterm.action.ActivateWindow(1),
    },
    {
        key = 'k',
        mods='ALT',
        action=wezterm.action.ActivateWindow(2),
    },
    {
        key = 'l',
        mods='ALT',
        action=wezterm.action.ActivateWindow(3),
    },
}


return config
-------------------------------------------------------------------
