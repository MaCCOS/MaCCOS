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
    end,
    
}