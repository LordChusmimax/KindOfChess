extends Node2D

class_name Promote_Menu

@onready var horse_button = $HorseButton
@onready var bishop_button = $BishopButton
@onready var rook_button = $RookButton
@onready var queen_button = $QueenButton
@onready var bottom_node = $BottomNode

var colour :ChessPieceNode.COLOUR
var tile :Tile

static var current: Node2D

func _ready():
	current = self
	horse_button.pressed.connect(_horse_button_pressed)
	bishop_button.pressed.connect(_bishop_button_pressed)
	rook_button.pressed.connect(_rook_button_pressed)
	queen_button.pressed.connect(_queen_button_pressed)
	
func set_menu():
	Promote_Menu.current.visible = 1
	horse_button.texture_normal = ChessPieceNode.sprites[colour][ChessPieceNode.PIECE.KNIGHT]
	bishop_button.texture_normal = ChessPieceNode.sprites[colour][ChessPieceNode.PIECE.BISHOP]
	rook_button.texture_normal = ChessPieceNode.sprites[colour][ChessPieceNode.PIECE.ROOK]
	queen_button.texture_normal = ChessPieceNode.sprites[colour][ChessPieceNode.PIECE.QUEEN]
	
func _horse_button_pressed():
	_promote_piece.rpc(ChessPieceNode.PIECE.KNIGHT,colour,tile.row,tile.col)
	
func _bishop_button_pressed():
	_promote_piece.rpc(ChessPieceNode.PIECE.BISHOP,colour,tile.row,tile.col)
	
func _rook_button_pressed():
	_promote_piece.rpc(ChessPieceNode.PIECE.ROOK,colour,tile.row,tile.col)

func _queen_button_pressed():
	_promote_piece.rpc(ChessPieceNode.PIECE.QUEEN,colour,tile.row,tile.col)

@rpc("any_peer","call_local","reliable")
func _promote_piece(piece:ChessPieceNode.PIECE,colour:ChessPieceNode.COLOUR,row,col):
	Promote_Menu.current.visible = 0
	Board.current.tiles[row][col].piece.piece_object.set_piece(piece,colour)
	Board.current.tiles[row][col].piece._load_texture()
	Board.current.waiting = false
	Board.current.override_last_move()
	Board.current.check_endgame(row,col)
