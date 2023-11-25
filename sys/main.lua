function love.load()
 require("glove_simple")
 gloveload()
 require("colors")
 x,y,w,h = 0,0,appWidth,appHeight
 sx,sy,sw,sh = tbscrollactive[2] or 0,tbscrollactive[3] or 0,appWidth+20,appHeight+20
 funcao=(function() end)
 ascroll("area","show",funcao,x,y,w,h,sw,sh)
end
function love.update()
 gloveupdate()
 gloveupdateEnds()
end
function love.draw()
 write("a",sx,sy)
 glovedraw()
end