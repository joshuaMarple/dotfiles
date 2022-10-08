local wezterm = require 'wezterm'

return {
  line_height = 1.4,
  cell_width = 1.05,
  color_scheme = 'AtomOneLight',
  hide_tab_bar_if_only_one_tab = true,
  font_size = 11.0,
  keys = {
      -- Use ctrl-tab/ctrl-shift-tab to move forward/back tmux tabs
      {key="Tab", mods="CTRL", action=wezterm.action({ SendString = "\x1b[9;5u" })},
      {key="Tab", mods="CTRL|SHIFT", action=wezterm.action({ SendString = "\x1b[9;6u" })},
      {key="e", mods="CTRL|SHIFT",
        action=wezterm.action{
          QuickSelectArgs={
            patterns={
              "https?://\\S+"
            },
            action = wezterm.action_callback(function(window, pane)
              local url = window:get_selection_text_for_pane(pane)
              wezterm.log_info("opening: " .. url)
              wezterm.open_with(url)
            end)
          }
        }
      },
  },
}
