Screen = {
	Cursor = {
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
		setY = function(int) _y = int _sp() end
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

	},
	clear = term.clear
}
