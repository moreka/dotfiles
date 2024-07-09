local wezterm = require("wezterm")
local config = wezterm.config_builder()

local solarized = wezterm.color.get_builtin_schemes()["Solarized (dark) (terminal.sexy)"]
solarized.background = "#00141a"
solarized.foreground = "#93a1a1"

config.color_schemes = {
	["My Solarized"] = solarized,
}
config.color_scheme = "My Solarized"

config.font = wezterm.font_with_fallback({
	"Comic Code Ligatures",
	"Symbols Nerd Font",
})
config.use_fancy_tab_bar = false
config.enable_scroll_bar = false
config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.keys = {
	{ key = "k", mods = "ALT", action = wezterm.action.ScrollByLine(-1) },
	{ key = "j", mods = "ALT", action = wezterm.action.ScrollByLine(1) },
	{ key = "k", mods = "ALT|SHIFT", action = wezterm.action.IncreaseFontSize },
	{ key = "j", mods = "ALT|SHIFT", action = wezterm.action.DecreaseFontSize },
	{ key = "c", mods = "ALT", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "ALT", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
}

return config
