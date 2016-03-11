Screen = {
	Cursor = {
        _oldx = 0,
        _oldy = 0,
        
		_x = 1,
		_y = 1,
		_sp = function() term.setCursorPos(Screen.Cursor._x, Screen.Cursor._y) end,

		getPos = function() return {_x, _y}	end,
		setPos = function(intX, intY)
			Screen.Cursor._x = intX
			Screen.Cursor._y = intY
			Screen.Cursor._sp()
		end,
		setX = function(int) _x = int _sp() end,
		setY = function(int) _y = int _sp() end,
        
        savePos = function()
            Screen.Cursor._oldx = Screen.Cursor._x
            Screen.Cursor._oldy = Screen.Cursor._y
        end,        
        restorePos = function()
            Screen.Cursor._x = Screen.Cursor._oldx
            Screen.Cursor._y = Screen.Cursor._oldy
        end
	},
	Color = {
		Bg = {
			set = term.setBackgroundColor,
			get = term.getBackgroundColor
		},
		Text = {
			set = term.setTextColor,
			get = term.getTextColor
		}
	},
	Drawing = {
        drawPixel = function(x, y, bgcol, txcol, str)
            Screen.Cursor.setPos(x, y)
            Screen.Cursor.savePos()
            
            paintutils.drawPixel(x, y, bgcol)
            
            Screen.Cursor.restorePos()
            Screen.Cursor._sp()
            write(str)
        end,
        drawLine = function(minx, miny, maxx, maxy, color)
            paintutils.drawLine(minx, miny, maxx, maxy, color)
            Screen.Cursor._sp()
        end
	},
    getSize = term.getSize,
    getSizeX = function() return ({ Screen.getSize()} )[1] end,
    getSizeY = function() return ({ Screen.getSize() })[2] end,
	clear = term.clear
}
