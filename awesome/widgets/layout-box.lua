local clickable_container = require('widgets.clickable-container')
local awful = require('awful')

local layout_box = clickable_container(awful.widget.layoutbox(s))

layout_box:buttons(
   awful.util.table.join(
      awful.button({}, 1,
         function()
            awful.layout.inc(1)
         end
      ),
      awful.button({}, 3,
         function()
            awful.layout.inc(-1)
         end
      ),
      awful.button({}, 4,
         function()
            awful.layout.inc(1)
         end
      ),
      awful.button({}, 5,
         function()
            awful.layout.inc(-1)
         end
      )
   )
)

return layout_box
