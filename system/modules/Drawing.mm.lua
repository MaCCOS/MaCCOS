Drawing = {
    setBgColor = function(color)
        Screen.Cursor.savePos()
        Screen.Color.Bg.set(color)
        Screen.clear()
        Screen.Cursor.restorePos()
    end,
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
    end,
    drawRect = function(minx, miny, maxx, maxy, color)
        Drawing.drawLine(1, 1, maxx, 1, color)
        Drawing.drawLine(maxx, 1, maxx, maxy, color)
        Drawing.drawLine(maxx, maxy, 1, maxy, color)
        Drawing.drawLine(1, maxy, 1, 1, color)
    end
}