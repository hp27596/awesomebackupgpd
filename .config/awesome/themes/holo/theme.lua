--[[

     Custom functional focused Awesome WM theme by Hp
     github.com/hp27596

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local string, os = string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons"
theme.wallpaper                                 = os.getenv("HOME") .. "/.config/awesome/1099421.png"
theme.font                                      = "Ubuntu Mono 9"
theme.taglist_font                              = "Ubuntu Mono 9"
theme.fg_normal                                 = "#FFFFFF"
theme.fg_focus                                  = "#0099CC"
theme.bg_focus                                  = "#303030"
theme.bg_normal                                 = "#242424"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#006B8E"
theme.border_width                              = dpi(3)
theme.border_normal                             = "#252525"
theme.border_focus                              = "#0099CC"
theme.taglist_fg_focus                          = "#FFFFFF"
theme.tasklist_bg_normal                        = "#222222"
theme.tasklist_fg_focus                         = "#4CB7DB"
theme.menu_height                               = dpi(20)
theme.menu_width                                = dpi(160)
theme.menu_icon_size                            = dpi(36)
theme.cross = theme.icon_dir .. "/close.svg"
theme.awesome_icon                              = theme.icon_dir .. "/awesome_icon_white.png"
theme.awesome_icon_launcher                     = theme.icon_dir .. "/arch.png"
theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel.png"
theme.spr_small                                 = theme.icon_dir .. "/spr_small.png"
theme.spr_very_small                            = theme.icon_dir .. "/spr_very_small.png"
theme.spr_right                                 = theme.icon_dir .. "/spr_right.png"
theme.spr_bottom_right                          = theme.icon_dir .. "/spr_bottom_right.png"
theme.spr_left                                  = theme.icon_dir .. "/spr_left.png"
theme.bar                                       = theme.icon_dir .. "/bar.png"
-- theme.bottom_bar                                = theme.icon_dir .. "/bottom_bar.png"
theme.mpdl                                      = theme.icon_dir .. "/mpd.png"
theme.mpd_on                                    = theme.icon_dir .. "/mpd_on.png"
theme.prev                                      = theme.icon_dir .. "/prev.png"
theme.nex                                       = theme.icon_dir .. "/next.png"
theme.stop                                      = theme.icon_dir .. "/stop.png"
theme.pause                                     = theme.icon_dir .. "/pause.png"
theme.play                                      = theme.icon_dir .. "/play.png"
theme.clock                                     = theme.icon_dir .. "/clock.png"
theme.calendar                                  = theme.icon_dir .. "/cal.png"
theme.cpu                                       = theme.icon_dir .. "/cpu.png"
theme.net_up                                    = theme.icon_dir .. "/net_up.png"
theme.net_down                                  = theme.icon_dir .. "/net_down.png"
theme.layout_tile                               = theme.icon_dir .. "/tile.png"
theme.layout_tileleft                           = theme.icon_dir .. "/tileleft.png"
theme.layout_tilebottom                         = theme.icon_dir .. "/tilebottom.png"
theme.layout_tiletop                            = theme.icon_dir .. "/tiletop.png"
theme.layout_fairv                              = theme.icon_dir .. "/fairv.png"
theme.layout_fairh                              = theme.icon_dir .. "/fairh.png"
theme.layout_spiral                             = theme.icon_dir .. "/spiral.png"
theme.layout_dwindle                            = theme.icon_dir .. "/dwindle.png"
theme.layout_max                                = theme.icon_dir .. "/max.png"
theme.layout_fullscreen                         = theme.icon_dir .. "/fullscreen.png"
theme.layout_magnifier                          = theme.icon_dir .. "/magnifier.png"
theme.layout_floating                           = theme.icon_dir .. "/floating.png"
theme.powerw                                    = theme.icon_dir .. "/power_w.svg"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(3)
theme.gap_single_client = false
theme.titlebar_close_button_normal              = theme.default_dir.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.default_dir.."/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.default_dir.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.default_dir.."/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.default_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.default_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.default_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.default_dir.."/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.default_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.default_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.default_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.default_dir.."/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.default_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.default_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.default_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.default_dir.."/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.default_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.default_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.default_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.default_dir.."/titlebar/maximized_focus_active.png"

theme.musicplr = string.format("%s -e ncmpcpp", awful.util.terminal)

local markup = lain.util.markup
local blue   = "#80CCE6"
local space3 = markup.font("Roboto 3", " ")

-- Clock
local mytextclock = wibox.widget.textclock(markup("#FFFFFF", space3 .. "%H:%M" .. markup.font("Roboto 4", " ")))
mytextclock.font = theme.font
-- local clock_icon = wibox.widget.imagebox(theme.clock)
-- local clockbg = wibox.container.background(mytextclock, theme.bg_focus, gears.shape.rectangle)
-- local clockwidget = wibox.container.margin(clockbg, dpi(0), dpi(1), dpi(0), dpi(0))
local clockwidget = wibox.container.margin(mytextclock, dpi(0), dpi(0), dpi(0), dpi(0))

-- Calendar
local mytextcalendar = wibox.widget.textclock(markup.fontfg(theme.font, "#FFFFFF", space3 .. "%a %d %b" .. markup.font("Roboto 5", " ")))
-- local calbg = wibox.widget.imagebox(theme.calendar)
-- local calbg = wibox.container.background(mytextcalendar, theme.bg_focus, gears.shape.rectangle)
local calendarwidget = wibox.container.margin(mytextcalendar, dpi(0), dpi(0), dpi(1), dpi(1))
theme.cal = lain.widget.cal({
    attach_to = { mytextclock, mytextcalendar },
    notification_preset = {
        fg = "#FFFFFF",
        bg = theme.bg_normal,
        position = "top_right",
        font = "Monospace 10"
    }
})

-- Mail IMAP check
--[[ to be set before use
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        mail_notification_preset.fg = "#FFFFFF"
        mail  = ""
        count = ""

        if mailcount > 0 then
            mail = "Mail "
            count = mailcount .. " "
        end

        widget:set_markup(markup.font(theme.font, markup(blue, mail) .. markup("#FFFFFF", count)))
    end
})
--]]

-- MPD
-- local mpd_icon = awful.widget.launcher({ image = theme.mpdl, command = theme.musicplr })
-- local prev_icon = wibox.widget.imagebox(theme.prev)
-- local next_icon = wibox.widget.imagebox(theme.nex)
-- local stop_icon = wibox.widget.imagebox(theme.stop)
-- local pause_icon = wibox.widget.imagebox(theme.pause)
-- local play_pause_icon = wibox.widget.imagebox(theme.play)
-- theme.mpd = lain.widget.mpd({
--     settings = function ()
--         if mpd_now.state == "play" then
--             mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
--             mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
--             widget:set_markup(markup.font("Roboto 4", " ")
--                               .. markup.font(theme.taglist_font,
--                               " " .. mpd_now.artist
--                               .. " - " ..
--                               mpd_now.title .. "  ") .. markup.font("Roboto 5", " "))
--             play_pause_icon:set_image(theme.pause)
--         elseif mpd_now.state == "pause" then
--             widget:set_markup(markup.font("Roboto 4", " ") ..
--                               markup.font(theme.taglist_font, " MPD PAUSED  ") ..
--                               markup.font("Roboto 5", " "))
--             play_pause_icon:set_image(theme.play)
--         else
--             widget:set_markup("")
--             play_pause_icon:set_image(theme.play)
--         end
--     end
-- })
-- local musicbg = wibox.container.background(theme.mpd.widget, theme.bg_focus, gears.shape.rectangle)
-- local musicwidget = wibox.container.margin(musicbg, dpi(0), dpi(0), dpi(5), dpi(5))

-- musicwidget:buttons(my_table.join(awful.button({ }, 1,
-- function () awful.spawn(theme.musicplr) end)))
-- prev_icon:buttons(my_table.join(awful.button({}, 1,
-- function ()
--     os.execute("mpc prev")
--     theme.mpd.update()
-- end)))
-- next_icon:buttons(my_table.join(awful.button({}, 1,
-- function ()
--     os.execute("mpc next")
--     theme.mpd.update()
-- end)))
-- stop_icon:buttons(my_table.join(awful.button({}, 1,
-- function ()
--     play_pause_icon:set_image(theme.play)
--     os.execute("mpc stop")
--     theme.mpd.update()
-- end)))
-- play_pause_icon:buttons(my_table.join(awful.button({}, 1,
-- function ()
--     os.execute("mpc toggle")
--     theme.mpd.update()
-- end)))

-- Battery
local bat = lain.widget.bat({
    settings = function()
        bat_header = " "
        bat_p      = bat_now.perc .. "%"
        if bat_now.ac_status == 1 then
            bat_header = bat_header .. " "
        else
            bat_header = bat_header .. " "
        end
        -- widget:set_markup(markup.font(theme.font, markup(blue, bat_header) .. bat_p))
        widget:set_markup(markup.font("Roboto 8", bat_header) .. bat_p)
    end
})
-- bat = wibox.container.background(bat.widget, theme.bg_focus, gears.shape.rectangle)

-- CPU
-- local cpu_icon = wibox.widget.imagebox(theme.cpu)
-- local cpu = lain.widget.cpu({
--     settings = function()
--         widget:set_markup(space3 .. markup.font(theme.font, "CPU " .. cpu_now.usage
--                           .. "% ") .. markup.font("Roboto 5", " "))
--     end
-- })
-- local cpubg = wibox.container.background(cpu.widget, theme.bg_focus, gears.shape.rectangle)
-- local cpuwidget = wibox.container.margin(cpubg, dpi(0), dpi(0), dpi(5), dpi(5))

-- -- Net
-- local netdown_icon = wibox.widget.imagebox(theme.net_down)
-- local netup_icon = wibox.widget.imagebox(theme.net_up)
-- local net = lain.widget.net({
--     settings = function()
--         widget:set_markup(markup.font("Roboto 1", " ") .. markup.font(theme.font, net_now.received .. " - "
--                           .. net_now.sent) .. markup.font("Roboto 2", " "))
--     end
-- })
-- local netbg = wibox.container.background(net.widget, theme.bg_focus, gears.shape.rectangle)
-- local networkwidget = wibox.container.margin(netbg, dpi(0), dpi(0), dpi(5), dpi(5))

-- Wireless Widget
local net_widgets = require("net_widgets")
net_wireless = net_widgets.wireless({interface = "wlp1s0",
                                     onclick = "alacritty -e /home/hp/.config/misc/nmtui.sh"})
-- net_wireless = wibox.container.background(net_wireless, theme.bg_focus, gears.shape.rectangle)


-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
-- local tempfile = "/sys/devices/virtual/thermal/thermal_zone8/temp"
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.fontfg(theme.taglist_font, "#FFFFFF", " " .. coretemp_now .. "°C"))
    end
})


-- Volume
local volume_widget = require('awesome-wm-widgets.volume-widget.volume') { widget_type = 'icon_and_text' }
-- volume_widget = wibox.container.background(volume_widget, theme.bg_focus, gears.shape.rectangle)

-- Backlight
local brightness_widget = require('awesome-wm-widgets.brightness-widget.brightness') { type = 'icon_and_text', program = 'brightnessctl', base = 65, tooltip = true, percentage = true, timeout = 100, step = 5 }

-- Cmus
-- local cmus_widget = require('awesome-wm-widgets.cmus-widget.cmus') { space = 5, timeout = 5 }
local cmus_widget = awful.widget.watch([[ bash -c '~/.config/awesome/cmus.sh' ]], 5, function(widget, stdout)  widget:set_markup(markup.font("Ubuntu Mono 9", stdout)) end )
cmus_widget = wibox.container.margin(cmus_widget, dpi(0), dpi(0), dpi(3), dpi(4))
cmus_widget:connect_signal("button::press", function() awful.spawn.with_shell('cmus-remote -u') end )
-- cmus_widget = wibox.container.background(cmus_widget, theme.bg_focus, gears.shape.rectangle)

-- Weather
-- local weather = awful.widget.watch([[ bash -c '~/.config/awesome/wttr.sh']], 300, function(widget, stdout) widget:set_markup(markup.font("Ubuntu Mono 9", stdout)) end )

-- Launcher
local mylauncher = awful.widget.button({ image = theme.awesome_icon_launcher, layout = wibox.layout.fixed.horizontal() })
mylauncher = wibox.container.margin(mylauncher, dpi(5), dpi(5), dpi(5), dpi(5))
mylauncher = wibox.container.background(mylauncher, theme.bg_focus, gears.shape.rectangle)
mylauncher:connect_signal("button::press", function() awful.spawn.with_shell('xfce4-appfinder') end )

local lockbutton = awful.widget.button({ image = theme.powerw })
lockbutton = wibox.container.margin(lockbutton, dpi(0), dpi(8), dpi(8), dpi(8))
lockbutton:connect_signal("button::press", function() awful.spawn.with_shell('~/.config/misc/dm-logout.sh') end )

-- Caffeinate
caffeine_widget, caffeine_timer = awful.widget.watch([[ bash -c '~/.config/awesome/caffe_watch.sh' ]], 60, function(widget, stdout) widget:set_markup(markup.font("Ubuntu Mono 20", stdout)) end )
caffeine_widget:connect_signal("button::press", function() awful.spawn.with_shell('~/.config/awesome/caffe_toggle.sh') end )
-- caffeine_widget = wibox.container.background(caffeine_widget, theme.bg_focus, gears.shape.rectangle)
caffeine_widget = wibox.container.margin(caffeine_widget, dpi(0), dpi(0), dpi(0), dpi(0))

-- rot8
rot_widget, rot_timer = awful.widget.watch([[ bash -c '~/.config/awesome/rot_watch.sh' ]], 60, function(widget, stdout) widget:set_markup(markup.font("Ubuntu Mono 22", stdout)) end )
rot_widget:connect_signal("button::press", function() awful.spawn.with_shell('~/.config/awesome/rot_toggle.sh') end )
rot_widgetcont = wibox.container.margin(rot_widget, dpi(8), dpi(0), dpi(-5), dpi(-12))

-- onboard
-- local onboard = wibox.widget.textbox('')
-- onboard:connect_signal("button::press", function() awful.spawn.with_shell('onboard') end )
-- onboard = wibox.container.margin(onboard, dpi(8), dpi(0), dpi(6), dpi(2))

-- Separators
local first = wibox.widget.textbox('<span font="Roboto 7"> </span>')
local spr_small = wibox.widget.imagebox(theme.spr_small)
local spr_very_small = wibox.widget.imagebox(theme.spr_very_small)
local spr_right = wibox.widget.imagebox(theme.spr_right)
local spr_bottom_right = wibox.widget.imagebox(theme.spr_bottom_right)
local spr_left = wibox.widget.imagebox(theme.spr_left)
local bar = wibox.widget.imagebox(theme.bar)
local vertbar = wibox.widget.textbox(' | ')

local barcolor  = gears.color({
    type  = "linear",
    from  = { dpi(32), 0 },
    to    = { dpi(32), dpi(32) },
    stops = { {0, theme.bg_focus}, {0.25, "#505050"}, {1, theme.bg_focus} }
})

function theme.at_screen_connect(s)
    -- Quake application
    -- s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    -- s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = awful.util.taglist_buttons,
        layout = {
            spacing = 0,
            layout  = wibox.layout.fixed.vertical
        },
        style = {
            -- shape = gears.shape.powerline,
            bg_urgent = '#F70000',
            bg_focus = barcolor,
            font = 10,
            spacing = 28,
        },
    }

    s.mytaglist = wibox.container.margin(s.mytaglist, dpi(2), dpi(0), dpi(5), dpi(5))
    s.mytag = wibox.container.background(s.mytaglist, theme.bg_focus, gears.shape.rectangle)
    -- s.mytag = wibox.container.margin(mytaglistcont, dpi(0), dpi(0), dpi(0), dpi(0))

    local tasks = require('widget.task-list')
    -- Create a tasklist widget
    -- s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklistbuttons, { bg_focus = theme.bg_focus, shape = gears.shape.rectangle, shape_border_width = 5, shape_border_color = theme.tasklist_bg_normal, align = "center" })

    -- Create the left wibox
    s.mywibox = awful.wibar({ position = "left", screen = s , width = dpi(28) })

    -- Create systray
    s.systray = wibox.widget.systray()
    s.systray:set_horizontal(false)
    s.systray:set_base_size(25)
    s.systray = wibox.container.background(s.systray, theme.bg_normal, gears.shape.rectangle)
    s.systraycont = wibox.container.margin(s.systray, dpi(4), dpi(0), dpi(2), dpi(0))

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.vertical,
        { -- Left widgets
            layout = wibox.layout.fixed.vertical,
            s.mytag,
        },
        nil, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.vertical,
            s.systraycont,
            -- onboard,
            -- rot_widgetcont,
            s.mylayoutbox,
        },
    }

    -- Create the top wibox
    s.mytopwibox = awful.wibar({ position = "top", screen = s, border_width = dpi(0), height = dpi(28) })

    -- Add widgets to the top wibox
    s.mytopwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
        },
        tasks(s), -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            vertbar,
            temp,
            vertbar,
            brightness_widget,
            vertbar,
            bat,
            vertbar,
            net_wireless,
            vertbar,
            volume_widget,
            vertbar,
            -- calendar_icon,
            calendarwidget,
            vertbar,
            -- clock_icon,
            clockwidget,
            -- vertbar,
            -- cmus_widget,
            vertbar,
            caffeine_widget,
            vertbar,
            lockbutton,
        },
    }
end

return theme
