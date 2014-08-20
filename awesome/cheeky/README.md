cheeky
======

A cheeky window switcher for Awesome WM

Description
-----------

It popus up a menu with all your clients. As you type,
case-insensitively filters the clients that match with the
name or class.

It's cheeky. If no clients are matched it resets to the complete list
of clients... and it tells you about it.

It was inspired by the oh-so-great:

- https://github.com/seanpringle/xowl
- https://github.com/seanpringle/simpleswitcher

Installation
------------

Clone this repository into your Awesome configuration directory:

```
  git clone https://github.com/svexican/cheeky ~/.config/awesome
```

Usage
-----

Include the module on your `rc.lua` file:

```lua
  require("cheeky")
```

and assign a shortcut in your `root.keys` table. For example:

```lua
  modkey = "Mod4"

  root.keys(awful.util.table.join(
    -- lots of your shortcuts

      awful.key({ modkey }, "/", function() cheeky.util.switcher() end),

    -- lots of more shortcuts
  ))
```

Type away!

TODO
----

- Reduce the flickering (it's not too bad)
- Fuzzy matching?
- Select entry by number
- Auto select when single match
- Allow the user to
  * set a static screen and coordinates for the menu
  * disable the cheeky reset
  * disable the cheeky notification
