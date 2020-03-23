extends TileMap

var gridsize = 8
var gridpos = []
var gOffsetx = 10
var gOffsety = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _draw():
	for k in range(gridsize):
		var squarecolor = ""
		var tileCode = 0
		for j in gridsize:
			
			if ((k % 2 == 0) && (j % 2 == 0)) || (k % 2 > 0 && j % 2 > 0):
				squarecolor = "#e1e5ff"
				tileCode = 17
			else:
				squarecolor = "#8696fe"
				tileCode = 16
			draw_rect(Rect2(Vector2(k*cell_size.x,j*cell_size.y),Vector2(64,64)),squarecolor,true,1,false)
			set_cell(k+gOffsetx,j,tileCode)
			
			
		
		#draw_circle(gridpos[k],10,squarecolor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
