local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

-- Standard awesome library
local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
                      require("awful.autofocus")
-- Widget and layout library
local wibox         = require("wibox")

-- Theme handling library
local beautiful     = require("beautiful")
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")

-- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100

local lain          = require("lain")
local freedesktop   = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

-- run_once({ "unclutter -root" }) -- entries must be comma-separated

local themes = {
    "powerarrow", -- 1
    "blackburn",
    "copland",
    "dremora",
    "holo", -- 5
    "multicolor",
    "powerarrow-dark",
    "rainbow",
    "steamburn",
    "vertex", -- 10
}

-- choose your theme here
local chosen_theme = themes[5]
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

local modkey      = "Mod4"
local altkey      = "Mod1"
local ctrlkey     = "Control"
local terminal    = "alacritty"
local browser     = "google-chrome-stable"
local editor      = "vim"
local emacs       = "emacsclient -c -a 'emacs' "
local mediaplayer = "mpv"

-- awesome variables
awful.util.terminal = terminal
-- awful.util.tagnames = {"", "", "", "", "", "", "", "", ""}
awful.util.tagnames = {}
local names = {"", "", "", "", "", "", "", "", ""}
local l = awful.layout.suit  -- Just to save some typing: use an alias.
local layouts = { l.tile, l.max, l.max, l.max, l.max,
    l.max, l.max, l.max, l.max }
awful.tag(names, s, layouts)


awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    --
    -- awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    --
    awful.layout.suit.max,
    -- awful.layout.suit.corner.nw,
    --
    -- awful.layout.suit.max.fullscreen,
}

awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = 250}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/theme.lua", chosen_theme))

local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e 'man awesome'" },
    { "edit config", "emacsclient -c emacs ~/.config/awesome/rc.lua" },
    { "arandr", "arandr" },
    { "restart", awesome.restart },
}

awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        --{ "Atom", "atom" },
        -- other triads can be put here
    },
    after = {
        { "Terminal", terminal },
        { "Log out", function() awesome.quit() end },
        { "Sleep", "systemctl suspend" },
        { "Restart", "systemctl reboot" },
        { "Exit", "systemctl poweroff" },
        -- other triads can be put here
    }
})

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", function(s)
--     -- Wallpaper
--     if beautiful.wallpaper then
--         local wallpaper = beautiful.wallpaper
--         -- If wallpaper is a function, call it with the screen
--         if type(wallpaper) == "function" then
--             wallpaper = wallpaper(s)
--         end
--         gears.wallpaper.maximized(wallpaper, s, true)
--     end
-- end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

globalkeys = my_table.join(

    -- {{{ Personal keybindings

    -- Awesome keybindings
    awful.key({ modkey,         }, "Return", function () awful.spawn( terminal ) end,
              {description = "Launch terminal", group = "awesome"}),
    awful.key({ modkey,         }, "g", function () awful.spawn( "google-chrome-stable" ) end,
              {description = "Launch qutebrowser", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "Reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "q",  function () awful.spawn.with_shell("dm-logout") end,
              {description = "Quit awesome", group = "awesome"}),
    -- awful.key({ modkey, "Shift" }, "p",      hotkeys_popup.show_help,
    --     {description = "Show help", group="awesome"}),

    awful.key({ modkey, "Shift" }, "p", function() awful.spawn.with_shell('cp=$(colorpicker --one-shot) && notify-send "Color:" "$cp" && ( echo -n "$cp" | grep -oE "[^ ]+$" | tr -d "\n" | xclip -sel clip)') end,
        {description = "Colorpicker", group = "awesome"}),

    awful.key({ modkey, "Shift" }, "w", function () awful.util.mymainmenu:show() end,
        {description = "Show main menu", group = "awesome"}),

    -- awful.key({ modkey }, "r", function () awful.spawn.with_shell("~/.config/misc/dm-frecency") end,
    --   {description = "Run Program Launcher", group = "hotkeys"}),

    awful.key({ modkey }, "r", function () awful.spawn.with_shell("rofi -show combi -theme '~/.config/rofi/launchers/type-4/style-1.rasi'") end,
      {description = "Run Program Launcher", group = "hotkeys"}),

    awful.key({ modkey }, "t", function () awful.spawn.with_shell("thunar") end,
      {description = "Run Thunar File Manager", group = "hotkeys"}),

    awful.key({ modkey }, "/", function () awful.spawn.with_shell("~/.config/misc/dm-scriptlauncher.sh") end,
      {description = "Run Script Launcher", group = "hotkeys"}),

    awful.key({ modkey }, ".", function () awful.spawn.with_shell("~/.config/misc/dm-opendot.sh") end,
      {description = "Open Dotfiles", group = "hotkeys"}),

    awful.key({ modkey }, "e", function () awful.spawn.with_shell("sh -c ~/.config/misc/emacs-launch.sh") end,
    -- awful.key({ modkey }, "e", function () awful.spawn.with_shell("emacsclient -c") end,
      {description = "Open Emacsclient", group = "hotkeys"}),

    awful.key({ modkey }, "o", function () awful.spawn.with_shell("~/.config/misc/dm-logout.sh") end,
      {description = "Open Exitmenu", group = "hotkeys"}),

    awful.key({ modkey }, "u", function () awful.spawn.with_shell(terminal .. " -e ~/.config/misc/nmtui.sh") end,
      {description = "Open Network Manager", group = "hotkeys"}),

    awful.key({ modkey }, "b", function () awful.spawn.with_shell(terminal .. " -t btop -e btop") end,
      {description = "Open System Monitor", group = "hotkeys"}),

    awful.key({ modkey }, "n", function () awful.spawn.with_shell(terminal .. " -t ranger -e ranger") end,
      {description = "Open Ranger File Manager", group = "hotkeys"}),

    awful.key({ ctrlkey, altkey }, "l", function () awful.spawn.with_shell("slock") end,
      {description = "Lock the screen", group = "hotkeys"}),

    -- awful.key({ modkey }, "F8", function () awful.spawn.with_shell("playerctl previous") end,
    --   {description = "Play Previous", group = "hotkeys"}),
    -- awful.key({ modkey }, "F9", function () awful.spawn.with_shell("playerctl play-pause") end,
    --   {description = "Play/Pause", group = "hotkeys"}),
    -- awful.key({ modkey }, "F10", function () awful.spawn.with_shell("playerctl next") end,
    --   {description = "Play Next", group = "hotkeys"}),

    awful.key({}, "XF86AudioPrev", function () awful.spawn.with_shell("playerctl previous") end,
      {description = "Play Previous", group = "hotkeys"}),
    awful.key({ }, "XF86AudioPlay", function () awful.spawn.with_shell("playerctl play-pause") end,
      {description = "Play/Pause", group = "hotkeys"}),
    awful.key({}, "XF86AudioNext", function () awful.spawn.with_shell("playerctl next") end,
      {description = "Play Next", group = "hotkeys"}),
    awful.key({}, "XF86AudioStop", function () awful.spawn.with_shell("playerctl pause") end,
      {description = "Play Next", group = "hotkeys"}),

    awful.key({ modkey }, "i", function () awful.spawn("clipmenu -i -l 15 -p 'Choose Clipboard:'") end,
        {description = "Clipboard manager", group = "hotkeys"}),

    -- Picom Toggle
    awful.key({ modkey }, "p", function () awful.spawn.with_shell("~/.config/misc/togglepicom.sh") end,
        {description = "Toggle Picom", group = "hotkeys"}),

    -- Printscreen
    awful.key({ }, "Print", function () awful.spawn.with_shell("flameshot full -p ~/Pictures") end,
        {description = "Capture Fullscreen", group = "hotkeys"}),
    awful.key({ ctrlkey }, "Print", function () awful.spawn.with_shell("flameshot gui") end,
        {description = "Capture Part of Screen", group = "hotkeys"}),

    -- Caffeinate
    awful.key({ modkey, "Shift" }, "e",
        function ()
            awful.spawn.with_shell("~/.config/awesome/caffe_toggle.sh")
        end,
        {description = "Toggle Caffeinate", group = "hotkeys"} ),

    -- Dmenu Package Installer
    awful.key({ modkey, "Shift" }, "i",
        function ()
            awful.spawn.with_shell("~/.config/misc/dm-packageinstall.sh")
        end,
        {description = "Toggle Caffeinate", group = "hotkeys"} ),

    -- Tag browsing with modkey
    awful.key({ modkey,         }, "Up",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey,         }, "Down",  awful.tag.viewnext,
        {description = "view next", group = "tag"}),

    awful.key({ modkey,         }, "Right", function () awful.client.focus.byidx( 1) end,
        {description = "Focus next by index", group = "client"}),
    awful.key({ modkey,         }, "Left", function () awful.client.focus.byidx(-1) end,
        {description = "Focus previous by index", group = "client"}),

    awful.key({ modkey,         }, "Tab", function () awful.client.focus.byidx( 1) end,
        {description = "Focus next by index", group = "client"}),
    awful.key({ modkey, "Shift" }, "Tab", function () awful.client.focus.byidx(-1) end,
        {description = "Focus previous by index", group = "client"}),

    -- Non-empty tag browsing CTRL+TAB (CTRL+SHIFT+TAB)
    -- awful.key({ altkey }, "Tab", function () lain.util.tag_view_nonempty(-1) end,
    --           {description = "view  previous nonempty", group = "tag"}),
    -- awful.key({ altkey, "Shift" }, "Tab", function () lain.util.tag_view_nonempty(1) end,
    --           {description = "view  previous nonempty", group = "tag"}),

    -- Default client focus
    awful.key({ modkey,         }, "k", function () awful.client.focus.byidx( 1) end,
        {description = "Focus next by index", group = "client"}),
    awful.key({ modkey,         }, "j", function () awful.client.focus.byidx(-1) end,
        {description = "Focus previous by index", group = "client"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx(1) end,
        {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx( -1) end,
        {description = "swap with previous client by index", group = "client"}),
    -- awful.key({ modkey          }, ".", function () awful.screen.focus_relative(1) end,
    --     {description = "focus the next screen", group = "screen"}),
    -- awful.key({ modkey          }, ",", function () awful.screen.focus_relative(-1) end,
    --     {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey, ctrlkey }, "k", function () awful.client.incwfact( 0.05) end,
        {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, ctrlkey }, "j", function () awful.client.incwfact(-0.05) end,
        {description = "swap with previous client by index", group = "client"}),


    -- change layout
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
    --           {description = "select previous", group = "layout"}),

    -- On the fly useless gaps change
    -- awful.key({ altkey, ctrlkey }, "j", function () lain.util.useless_gaps_resize(1) end,
    --     {description = "increment useless gaps", group = "tag"}),
    -- awful.key({ altkey, ctrlkey }, "k", function () lain.util.useless_gaps_resize(-1) end,
    --     {description = "decrement useless gaps", group = "tag"}),

    -- change master size
    awful.key({ modkey          }, "l", function () awful.tag.incmwfact( 0.05) end,
        {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey          }, "h", function () awful.tag.incmwfact(-0.05) end,
        {description = "decrease master width factor", group = "layout"}),

    -- Brightness
    -- awful.key({ }, "XF86MonBrightnessUp", function () awful.spawn.with_shell("~/.config/misc/extbright.sh up &") end,
    awful.key({ }, "XF86MonBrightnessUp",
        function ()
            brightness_widget:inc()
            naughty.notify({ title = "Brightness increased." })
        end,
        {description = "+10%", group = "hotkeys"}),
    -- awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn.with_shell("~/.config/misc/extbright.sh down &") end,
    awful.key({ }, "XF86MonBrightnessDown",
        function ()
            brightness_widget:dec()
            naughty.notify({ title = "Brightness decreased." })
        end,
        {description = "-10%", group = "hotkeys"}),

    -- ALSA volume control
    awful.key({ modkey }, "F12",
        function ()
            awful.spawn.with_shell("amixer -D pulse set Master 5%+")
            -- beautiful.volume.update()
            awful.spawn.with_shell("~/.config/misc/currentvolume.sh")
        end),
    awful.key({ modkey }, "F11",
        function ()
            awful.spawn.with_shell("amixer -D pulse set Master 5%-")
            -- beautiful.volume.update()
            awful.spawn.with_shell("~/.config/misc/currentvolume.sh")
        end),

    awful.key({ }, "XF86AudioRaiseVolume",
        function ()
            awful.spawn.with_shell("amixer -D pulse set Master 5%+")
            -- beautiful.volume.update()
            awful.spawn.with_shell("~/.config/misc/currentvolume.sh")
        end),
    awful.key({ }, "XF86AudioLowerVolume",
        function ()
            awful.spawn.with_shell("amixer -D pulse set Master 5%-")
            -- beautiful.volume.update()
            awful.spawn.with_shell("~/.config/misc/currentvolume.sh")
        end),
    awful.key({ }, "XF86AudioMute",
        function ()
            awful.spawn.with_shell("amixer -q set Master toggle")
            -- beautiful.volume.update()
            awful.spawn.with_shell("~/.config/misc/currentvolume.sh")
        end),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
        {description = "copy terminal to gtk", group = "hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    -- awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
    --     {description = "copy gtk to terminal", group = "hotkeys"})

    awful.key({ modkey }, "v", function () awful.spawn.with_shell("pavucontrol") end,
        {description = "Pulseaudio Volume Control", group = "hotkeys"})

    --]]
)

clientkeys = my_table.join(
    awful.key({ modkey, "Shift" }, "s",
        function (c)
            c.sticky = not c.sticky
        end,
        {description = "toggle sticky", group = "client"}),

    awful.key({ modkey }, "s",
        function (c)
            c.sticky = not c.sticky
            if c.sticky then
                c.floating = true
                c.ontop = true
            else
                c.floating = false
                c.ontop = false
            end
        end,
        {description = "toggle floating and sticky", group = "client"}),

    awful.key({ altkey, "Shift" }, "m",      lain.util.magnify_client,
        {description = "magnify client", group = "client"}),

    awful.key({ modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

    awful.key({ modkey }, "q", function (c) c:kill() end,
      {description = "close", group = "hotkeys"}),

    awful.key({ modkey, "Shift" }, "space", awful.client.floating.toggle,
      {description = "toggle floating", group = "client"}),
    awful.key({ modkey, ctrlkey }, "Return", function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}),
    awful.key({ modkey, "Shift" }, "t",
        function (c)
            c.ontop = not c.ontop
            naughty.notify({ title = "Sticky window toggled" })
        end,
      {description = "toggle keep on top", group = "client"}),
    -- awful.key({ modkey,         }, "o", function (c) c:move_to_screen() end,
    --   {description = "move to screen", group = "client"}),

    awful.key({ modkey,           }, "m",
        function ()
            if string.match(mouse.screen.selected_tag.layout.name, 'max') then
                awful.layout.set(awful.layout.suit.tile)
            else
                awful.layout.set(awful.layout.suit.max)
            end
        end,
        {description = "toggle between max and tile layout", group = "client"}),

    awful.key({ modkey, "Shift" }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
    {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = my_table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, ctrlkey }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                              tag:view_only()
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, ctrlkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end),
    awful.button({ modkey, ctrlkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },

    -- Set applications to always map on the tag 1 on screen 1.
    -- find class or role via xprop command

    { rule_any = { instance = { "google-chrome" } } ,
      properties = { tag = screen[1].tags[3] } },

    { rule_any = { instance = { "crx_mhkgffchfoemiimeghigadnlaogjkica" } } ,
      properties = { tag = screen[1].tags[5] } },

    { rule = { class = "Emacs" },
      properties = { tag = screen[1].tags[2] } },

    { rule_any = { class = { "Steam" } },
      properties = { tag = screen[1].tags[8] } },

    { rule_any = { name = { "Steam" } },
      properties = { tag = screen[1].tags[8] } },

    { rule = { name = "tmux" },
      properties = { tag = screen[1].tags[6] } },

    { rule_any = { name = { "ranger", "btop" } },
      properties = { tag = screen[1].tags[7] } },

    { rule_any = { class = { "Thunar" } },
      properties = { tag = screen[1].tags[7] } },

    { rule_any = { class = { "qBittorrent", "Virt-manager" } },
      properties = { tag = screen[1].tags[9] } },

    { rule_any = { class = { "vlc" } },
      properties = { tag = screen[1].tags[9] } },


    -- Set applications to be maximized at startup.
    -- find class or role via xprop command

    { rule = { class = "Gimp*", role = "gimp-image-window" },
          properties = { maximized = true } },

    { rule = { class = "Xfce4-settings-manager" },
          properties = { floating = false } },

    { rule = { class = "Onboard" },
          properties = { focusable = false } },


    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Blueberry",
          "Galculator",
          "Qalculate-gtk",
          "Gnome-font-viewer",
          "Gpick",
          "Imagewriter",
          "Font-manager",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Oblogout",
          "Peek",
          "Skype",
          "System-config-printer.py",
          "Steam",
          -- "Sxiv",
          "Unetbootin.elf",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "Xfce4-appfinder",
          "Onboard",
          "qutebrowser",
          "kate",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          -- "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          "Preferences",
          "setup",
        }
      }, properties = { floating = true }},

}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
-- client.connect_signal("request::titlebars", function(c)
--     -- Custom
--     if beautiful.titlebar_fun then
--         beautiful.titlebar_fun(c)
--         return
--     end

--     -- Default
--     -- buttons for the titlebar
--     local buttons = my_table.join(
--         awful.button({ }, 1, function()
--             c:emit_signal("request::activate", "titlebar", {raise = true})
--             awful.mouse.client.move(c)
--         end),
--         awful.button({ }, 3, function()
--             c:emit_signal("request::activate", "titlebar", {raise = true})
--             awful.mouse.client.resize(c)
--         end)
--     )

--     awful.titlebar(c, {size = 21}) : setup {
--         { -- Left
--             awful.titlebar.widget.iconwidget(c),
--             buttons = buttons,
--             layout  = wibox.layout.fixed.horizontal
--         },
--         { -- Middle
--             { -- Title
--                 align  = "center",
--                 widget = awful.titlebar.widget.titlewidget(c)
--             },
--             buttons = buttons,
--             layout  = wibox.layout.flex.horizontal
--         },
--         { -- Right
--             awful.titlebar.widget.floatingbutton (c),
--             awful.titlebar.widget.maximizedbutton(c),
--             awful.titlebar.widget.stickybutton   (c),
--             awful.titlebar.widget.ontopbutton    (c),
--             awful.titlebar.widget.closebutton    (c),
--             layout = wibox.layout.fixed.horizontal()
--         },
--         layout = wibox.layout.align.horizontal
--     }
-- end)

-- Focus urgent clients automatically
-- client.connect_signal("property::urgent", function(c)
--     c.minimized = false
--     c:jump_to()
-- end)

-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", {raise = true})
-- end)

-- No border and gaps for maximized clients
function border_adjust(c)
    local max = mouse.screen.selected_tag.layout.name == "max"
    local is_single = #mouse.screen.selected_tag:clients() == 1
    if (max or c.maximized or is_single) then -- no borders if only 1 client visible
        c.border_width = 0
    elseif #awful.screen.focused().clients > 1 then
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    end
end

client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.connect_signal("property::minimized", function(c)
    c.minimized = false
end)

awful.spawn.once("sh -c ~/.config/misc/autostart.sh", {})
