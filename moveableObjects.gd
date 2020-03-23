extends TileMap

var startPos = Vector2()
var endPos = Vector2()
var activePiece
var pieceType
var startPieces = []
var dragging = false
var updateSpritePos = false
var b_pawnStartPos = []
var w_pawnStartPos = []
var validMoves = [Vector2(0,0)]
var drawValidMoves = false
var startBoard = []

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,8):
		var cellPiece
		for j in range(0,8):
			if get_cell(j,i) != -1:
				cellPiece = get_cell(j,i)
				if cellPiece == 5:
					b_pawnStartPos.append(Vector2(j,i))
				if cellPiece == 11:
					w_pawnStartPos.append(Vector2(j,i))
				startBoard.append(get_cell(j,i))
				startPieces.append(cellPiece)
	
	print("Pieces Array: ",startPieces)
	print("Pieces Count: ",startPieces.size())
	print("b_PawnStart Array: ",b_pawnStartPos)
	print("w_PawnStart Array: ",w_pawnStartPos)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:

			if !dragging && get_cellv(world_to_map(event.position)) != -1:
				
				startPos = world_to_map(event.position)
				activePiece = get_cellv(startPos)
				var validMoveOrigin = startPos
				
				$Sprite.frame = activePiece
				$Sprite.visible = true
				updateSpritePos = true
				
				match activePiece:
					0,6: 
						pieceType = "Queen"
						
						
					1,7:
						pieceType = "King"
						
						
					2,8: 
						pieceType = "Rook"
						
						
					3,9: 
						pieceType = "Knight"
						
						
					4,10:
						pieceType = "Bishop"
						
						
					5,11: 
						pieceType = "Pawn"
						if activePiece == 5: # Black Pawn Movement
							validMoves.clear()
							if b_pawnStartPos.find(startPos) != -1: 
								validMoves.append(Vector2(validMoveOrigin.x,validMoveOrigin.y+2))
							else:
								validMoves.append(Vector2(validMoveOrigin.x,validMoveOrigin.y+1))
						if activePiece == 11: # White Pawn Movement
							validMoves.clear()
							if w_pawnStartPos.find(startPos) != -1: 
								validMoves.append(Vector2(validMoveOrigin.x,validMoveOrigin.y-2))
							else:
								validMoves.append(Vector2(validMoveOrigin.x,validMoveOrigin.y-1))
								
					-1 : 
						pieceType = "none"
				
				
				
				drawValidMoves = true
				
				set_cellv(startPos,-1)
				dragging = true
				print("startPos: ",startPos)
				print(validMoves[0])
			
			if dragging:
				if get_cellv(world_to_map(event.position)) == -1 && world_to_map(event.position) != startPos:
					endPos = world_to_map(event.position)
					set_cellv(endPos,activePiece)
					$Sprite.visible = false
					updateSpritePos = false
					activePiece = -1 
					dragging = false
					drawValidMoves = false
					print("endPos: ",endPos," startPos Tile Index: ",get_cellv(startPos))
					
					
			print("Piece Tile Index: ",activePiece," = ", pieceType)
#		if event is InputEventMouseMotion and dragging:

				
		if event.button_index == BUTTON_RIGHT and event.pressed:
			if dragging:
				$Sprite.visible = false
				set_cellv(startPos, activePiece)
				dragging = false
				updateSpritePos = false
				drawValidMoves = false
				
	update()
	
func _draw():
	if drawValidMoves:
		for m in validMoves.size():
			draw_rect(Rect2(map_to_world(validMoves[m]),Vector2(64,64)),Color(0.55, 0, 0, 0.4),true)
		
			
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if updateSpritePos:
		$Sprite.position = get_viewport().get_mouse_position()
		
	
