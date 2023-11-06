extends Node2D
class_name Tile

var pressed:bool
var mouse_in:bool = false

static var moved_piece_tile :Tile

enum STATE{RELEASED, GRABBED}

static var state: STATE = STATE.RELEASED

@export_range(0,8)
var row:int
@export_range(0,8)
var col:int

@onready
var sprite:Sprite2D = $Sprite
@onready
var area:Area2D = $Area2D
@onready
var piece: ChessPieceNode = $Piece
@onready
var possible: Sprite2D = $Possible

func ready(secret):
	sprite.modulate.a = 0
	if secret:
		return
	area.mouse_entered.connect(_on_Area2D_mouse_entered)
	area.mouse_exited.connect(_on_Area2D_mouse_exited)
	area.input_event.connect(_on_Area2D_input_event)
	Board.current.area.input_event.connect(_outside_press)

func _on_Area2D_mouse_entered() -> void:
	mouse_in = true
	_set_alpha()
	
func _on_Area2D_mouse_exited() -> void:
	mouse_in = false
	_set_alpha()
	
func _on_Area2D_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event.is_action_pressed("Left_Click"):
		if Board.current.online:
			if !Board.current.white_turn and Multiplayer_Class.server:
				return
			
			if Board.current.white_turn and !Multiplayer_Class.server:
				return

		if Board.current.waiting:
			return		
		if state == STATE.GRABBED:
			return
		if Board.current.white_turn\
			and piece.colour != ChessPieceNode.COLOUR.WHITE\
			and !Board.current.debug_mode:
			return
		elif !Board.current.white_turn\
			and piece.colour != ChessPieceNode.COLOUR.BLACK\
			and !Board.current.debug_mode:
			return
		pressed = true
		piece.modulate.a=0
		moved_piece_tile = self
		state = STATE.GRABBED
		Dragged_Piece.current.on_click()
		Board.current.clear_possibles()
		Board.current.check_moves(self)
		
	elif event.is_action_released("Left_Click"):
		if Board.current.online:
			if !Board.current.white_turn and Multiplayer_Class.server:
				return
			
			if Board.current.white_turn and !Multiplayer_Class.server:
				return
			
		if Board.current.waiting:
			return
		if state == STATE.RELEASED:
			return
		state = STATE.RELEASED
		
		if !Board.current.validate_move(moved_piece_tile,self)\
		or moved_piece_tile == self:
			moved_piece_tile.piece.modulate.a=1
			moved_piece_tile.pressed = false
			_set_alpha()
			moved_piece_tile._set_alpha()
			return
		
		Board.current.check_king_rooking(moved_piece_tile,self)
		Board.current.check_promoting_pawn(moved_piece_tile,self)
		Board.current.check_enpassant(moved_piece_tile,self)
		Board.current.check_enpassanted(moved_piece_tile,self)
		change_turn()
		piece.set_piece(moved_piece_tile.piece.piece, moved_piece_tile.piece.colour)
		moved_piece_tile.piece.set_piece(ChessPieceNode.PIECE.NONE, ChessPieceNode.COLOUR.NONE)
		pressed = false
		moved_piece_tile.pressed = false
		piece.modulate.a=1
		moved_piece_tile._set_alpha()
		_set_alpha()
		Board.current.show_textures()
		Board.current.clear_possibles()
		Board.current.save_move()
		Board.current.check_endgame.rpc(row,col)
		
func _outside_press(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event.is_action_released("Left_Click"):
		state = STATE.RELEASED
		pressed = false
		piece.modulate.a=1
		_set_alpha()

func change_turn():
	Board.current.change_turn()

func _set_alpha():
	if pressed:
		sprite.modulate.a = 0.5
		return
	elif mouse_in:
		sprite.modulate.a = 0.2
		return
	sprite.modulate.a = 0
	return

func set_possible(active):
	possible.visible = active
