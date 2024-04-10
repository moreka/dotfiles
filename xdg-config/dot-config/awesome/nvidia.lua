local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local nvidia_widget = {}
local popup

local worker = function(user_args)
  local args = user_args or {}
  local font = args.font or beautiful.font

  local timeout = args.timeout or 10
  local space = args.space or 3

  nvidia_widget.widget = wibox.widget({
    {
      id = "text",
      font = font,
      widget = wibox.widget.textbox,
    },
    spacing = space,
    layout = wibox.layout.fixed.horizontal,
    set_title = function(self, title)
      self:get_children_by_id("text")[1]:set_text(title)
    end,
  })

  popup = awful.popup({
    ontop = true,
    visible = false,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 4)
    end,
    border_width = 1,
    border_color = beautiful.bg_focus,
    maximum_width = 400,
    offset = { y = 5 },
    widget = {},
  })

  local switch_intel = function()
    awful.spawn.with_shell("nvidia-switch intel")
    awesome.quit()
  end
  local switch_nvidia = function()
    awful.spawn.with_shell("nvidia-switch nvidia")
    awesome.quit()
  end

  local menu_items = {
    { name = "Switch to Intel", command = switch_intel },
    { name = "Switch to NVIDIA", command = switch_nvidia },
  }

  local rows = { layout = wibox.layout.fixed.vertical }

  for _, item in ipairs(menu_items) do
    local row = wibox.widget({
      {
        {
          {
            text = item.name,
            font = beautiful.font,
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        margins = 8,
        layout = wibox.container.margin,
      },
      bg = beautiful.bg_normal,
      widget = wibox.container.background,
    })

    row:connect_signal("mouse::enter", function(c)
      c:set_bg(beautiful.bg_focus)
    end)
    row:connect_signal("mouse::leave", function(c)
      c:set_bg(beautiful.bg_normal)
    end)

    row:buttons(awful.util.table.join(awful.button({}, 1, function()
      popup.visible = not popup.visible
      item.command()
    end)))

    table.insert(rows, row)
  end

  popup:setup(rows)

  local function update_widget(widget, stdout, _, _, code)
    if code == 0 then
      widget:set_title(stdout)
    end
  end

  nvidia_widget.widget:buttons(awful.util.table.join(awful.button({}, 1, function()
    if popup.visible then
      popup.visible = not popup.visible
    else
      popup:move_next_to(mouse.current_widget_geometry)
    end
  end)))

  watch("sb-nvidia", timeout, update_widget, nvidia_widget.widget)
  return nvidia_widget.widget
end

return setmetatable(nvidia_widget, {
  __call = function(_, ...)
    return worker(...)
  end,
})
