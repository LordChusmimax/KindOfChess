extends Sprite2D
class_name ChessPieceNode

enum PIECE {NONE = -1, PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING}
enum COLOUR {NONE = -1, WHITE, BLACK}

var piece_object :ChessPiece

var unmoved :get = _get_unmoved
func _get_unmoved() -> bool:
	return piece_object.unmoved

var colour :get = _get_colour
func _get_colour() -> COLOUR:
	return piece_object.colour

var piece :get = _get_piece
func _get_piece() -> PIECE:
	return piece_object.piece

static var sprites = [[preload("res://Resources/Pawn.png"),
preload("res://Resources/Horse.png"),
preload("res://Resources/Bishop.png"),
preload("res://Resources/Tower.png"),
preload("res://Resources/Queen.png"),
preload("res://Resources/King.png")],
[preload("res://Resources/Pawn_Black.png"),
preload("res://Resources/Horse_Black.png"),
preload("res://Resources/Bishop_Black.png"),
preload("res://Resources/Tower_Black.png"),
preload("res://Resources/Queen_Black.png"),
preload("res://Resources/King_Black.png")]]


@onready
var sprite:Sprite2D

func _ready():
	piece_object = ChessPiece.new()
	_load_texture()
	pass

func set_piece(piece_object: PIECE, colour: COLOUR, unmoved :bool =false):
	self.piece_object = ChessPiece.new()\
		.set_piece(piece_object,colour)\
		.set_unmoved(unmoved)
	_load_texture()
	return

func _load_texture():
	if piece_object.piece == PIECE.NONE or piece_object.colour == COLOUR.NONE:
		texture = null
		return
	texture = sprites[piece_object.colour][piece_object.piece]
