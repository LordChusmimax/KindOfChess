extends Node2D
class_name Dragged_Piece

@onready
var sprite: Sprite2D = $Sprite2D
static var current: Dragged_Piece

func _init():
	current = self

func _process(_delta):
	position = get_global_mouse_position()

func on_click():
	if Tile.moved_piece_tile.piece.colour == ChessPieceNode.COLOUR.NONE or Tile.moved_piece_tile.piece.piece == ChessPieceNode.PIECE.NONE:
		sprite.texture = null
	else:
		sprite.texture = ChessPieceNode.sprites[Tile.moved_piece_tile.piece.colour][Tile.moved_piece_tile.piece.piece]
	sprite.modulate.a=1

func _input(event):
	if event.is_action_released("Left_Click"):
		sprite.modulate.a=0
