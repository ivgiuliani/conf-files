local awful = require("awful")

mymainmenu = awful.menu({
  items = {
    { "Terminal", terminal },
    { "Irssi", "/home/ivan/bin/irssi.sh" },
    { "Chrome", "google-chrome" },
    { "Firefox", "firefox" },
    { "Gimp", "gimp" },
    { "IntelliJ IDEA", "/home/ivan/.system/idea-IU/bin/idea.sh" },
    { "PyCharm", "/home/ivan/.system/pycharm/bin/pycharm.sh" },
    { "PHPStorm", "/home/ivan/.system/phpstorm/bin/phpstorm.sh" },
    { "RubyMine", "/home/ivan/.system/rubymine/bin/rubymine.sh" },
    { "Sublime", "/home/ivan/.system/SublimeText2/sublime_text" },
    { "Android Studio", "/home/ivan/.system/android-studio/bin/studio.sh" },
    { "VirtualBox", "virtualbox" },
    { "Transmission", "transmission-gtk" },
		{ "Suspend", "dbus-send --system --print-reply --dest=\"org.freedesktop.UPower\" /org/freedesktop/UPower org.freedesktop.UPower.Suspend"},
		{ "Hibernate", "/home/ivan/bin/hibernate.sh" },
    { "Logout", awesome.quit }
  }
})
