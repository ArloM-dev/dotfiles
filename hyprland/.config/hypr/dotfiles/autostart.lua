-------------------
---- AUTOSTART ----
-------------------

 hl.on("hyprland.start", function ()
   hl.exec_cmd("awww-daemon")
   hl.exec_cmd("blueman-applet")
   hl.exec_cmd("waybar")
 end)