extends Node2D
class_name Board

@export
var secret: bool

@export
var debug_mode: bool

static var current: Board
static var secret_board: Board

static var online: bool = false

var waiting :bool= false

var white_turn:bool =true

var tiles = []
var previous_moves = []
var available_tiles:Array[Tile] = []
var row:int
var col:int

var received_move = []

@onready var button_sprite = $Button_Sprite
@onready var button = $Button_Sprite/Button
@onready var button2 = $Button_Sprite2/Button
@onready var rich_text_label = $Scoreboard/RichTextLabel

@onready
var area:Area2D = $Back

func _ready():
	
	if secret:
		secret_board = self
	else:
		current = self
	_set_tiles()
	_get_children(self, true)
	
	if !secret:
		button.pressed.connect(load_move)
		button2.pressed.connect(_reset)
	
	for row in tiles:
		for tile in row:
			tile.ready(secret)
	
	_set_board()
	#_set_board_lategame()
	save_move()
	if !secret:
		Move_Validation.tiles = tiles
	
	if !secret:
		rich_text_label.text = ""
		pass

func _reset():
	
	rich_text_label.text = ""
	previous_moves = []
	white_turn = true
	_set_board()
	save_move()
	
func _set_tiles():
	for i in range(8):
		tiles.append([])
	
	for i in tiles:
		for j in range(8):
			i.append(null)
		
func _create_move_empty():
	var move = []
	for i in range(8):
		move.append([])
	
	for i in move:
		for j in range(8):
			i.append(null)
	return move
	
func save_move():
	var move = _create_move_empty()
	for i in range(8):
		for j in range(8):
			move[i][j]=ChessPiece.new().copy_piece(tiles[i][j].piece.piece_object)
	previous_moves.append(move)
	if online:
		_send_move_online(move)

func _send_move_online(move):
	Multiplayer_Class.current.start_sending_move.rpc()
	for row in range(8):
		for col in range(8):
			var tile_piece:ChessPiece = move[row][col]
			Multiplayer_Class.current.send_tile.rpc(row,col,tile_piece.piece,tile_piece.colour,tile_piece.unmoved,tile_piece.enpassantable_array)
	Multiplayer_Class.current.sent_move.rpc(white_turn)

func receive_new_move():
	received_move = _create_move_empty()

func receive_tile(row,col,piece,colour,unmoved,enpassantable):
	received_move[row][col] = ChessPiece.new().set_piece(piece,colour,unmoved).set_enpassantable_array(enpassantable)
	
func move_received(white_turn):
	self.white_turn = white_turn
	previous_moves.append(received_move)
	_load_current_move()
	
func _load_current_move():
	rich_text_label.text = ""
	if previous_moves.size() == 1:
		return
	for i in range(8):
		for j in range(8):
			tiles[i][j].piece.piece_object=ChessPiece.new().copy_piece(previous_moves[-1][i][j])
			tiles[i][j].piece._load_texture()
	
func override_last_move():
	var move = _create_move_empty()
	for i in range(8):
		for j in range(8):
			move[i][j]=ChessPiece.new().copy_piece(tiles[i][j].piece.piece_object)
	previous_moves[-1] = move
	
func load_move():
	rich_text_label.text = ""
	if previous_moves.size() == 1:
		return
	for i in range(8):
		for j in range(8):
			tiles[i][j].piece.piece_object=ChessPiece.new().copy_piece(previous_moves[-2][i][j])
			tiles[i][j].piece._load_texture()
	previous_moves.remove_at(previous_moves.size()-1)
	white_turn = !white_turn
	
func load_move_in_secret(move):
	for i in range(8):
		for j in range(8):
			tiles[i][j].piece.piece_object=ChessPiece.new().copy_piece(move[i][j])

func secret_move(source:Tile,destination:Tile):
	#print_board()
	tiles[destination.row][destination.col].piece.piece_object = ChessPiece.new().copy_piece(source.piece.piece_object)
	tiles[source.row][source.col].piece.piece_object = ChessPiece.new()
	#print_board()
	
func validate_move(source:Tile,destination:Tile) -> bool:
	
	return destination in available_tiles
	
func check_king_rooking(source:Tile,destination:Tile) -> bool:
	if source.piece.piece != ChessPieceNode.PIECE.KING:
		return false
	if destination.col == source.col+2:
		tiles[source.row][source.col+1].piece.piece_object = ChessPiece.new().set_piece(ChessPieceNode.PIECE.ROOK, source.piece.colour)
		tiles[source.row][7].piece.piece_object = ChessPiece.new().set_piece(ChessPieceNode.PIECE.NONE)
		reload_textures()
		return true
	if destination.col == source.col-2:
		tiles[source.row][source.col-1].piece.piece_object = ChessPiece.new().set_piece(ChessPieceNode.PIECE.ROOK, source.piece.colour)
		tiles[source.row][0].piece.piece_object = ChessPiece.new().set_piece(ChessPieceNode.PIECE.NONE)
		reload_textures()
		return true
	return false
	
func check_promoting_pawn(source:Tile,destination:Tile) -> bool:
	if source.piece.piece != ChessPieceNode.PIECE.PAWN:
		return false
		
	if destination.row == 7 and source.piece.colour == ChessPieceNode.COLOUR.WHITE:
		Promote_Menu.current.colour = source.piece.colour
		Promote_Menu.current.tile = destination
		Promote_Menu.current.set_menu()
		Promote_Menu.current.global_position = destination.global_position
		set_waiting.rpc()
		return true

	if destination.row == 0 and source.piece.colour == ChessPieceNode.COLOUR.BLACK:
		Promote_Menu.current.colour = source.piece.colour
		Promote_Menu.current.tile = destination
		Promote_Menu.current.set_menu()
		Promote_Menu.current.global_position = destination.global_position - Promote_Menu.current.bottom_node.position
		set_waiting.rpc()
		return false
	
	return false

@rpc("any_peer","call_local","reliable")
func set_waiting():
	waiting = true

func reload_textures():
	for i in range(8):
		for j in range(8):
			tiles[i][j].piece._load_texture()
	
@rpc("any_peer","call_local","reliable")
func check_endgame(row ,col):
	rich_text_label.text = ""
	var can_move:bool = total_possible_moves(Board.current.tiles[row][col].piece.colour).size()>0
	var checked:bool = check_making_check(Board.current.tiles[row][col])
	if !can_move and checked:
		rich_text_label.text = "CHECKMATE"
	elif can_move and checked:
		rich_text_label.text = "CHECKED"
	elif !can_move and !checked:
		rich_text_label.text = "STALEMATE"
	
func check_enpassant(source :Tile, destination :Tile):
	if source.piece.piece == ChessPieceNode.PIECE.PAWN:
		if abs(destination.row - source.row) == 2:
			if source.piece.colour == ChessPieceNode.COLOUR.WHITE:
				tiles[source.row+1][source.col].piece.piece_object.enpassantable=true
			else:
				tiles[source.row-1][source.col].piece.piece_object.enpassantable=true

func check_enpassanted(source :Tile, destination :Tile):
	if source.piece.piece == ChessPieceNode.PIECE.PAWN\
		and destination.piece.piece == ChessPieceNode.PIECE.NONE\
		and abs(destination.col-source.col)==1:
			if source.piece.colour == ChessPieceNode.COLOUR.WHITE:
				tiles[destination.row-1][destination.col].piece.piece_object = ChessPiece.new().set_piece(ChessPieceNode.PIECE.NONE)
			else:
				tiles[destination.row+1][destination.col].piece.piece_object = ChessPiece.new().set_piece(ChessPieceNode.PIECE.NONE)
			reload_textures()
	
func total_possible_moves(colour: ChessPieceNode.COLOUR)->Array[Tile]:
	var array : Array[Tile] = []
	var pieces : Array[Tile] = []
	
	for row in tiles:
		for tile in row:
			if tile.piece.colour != colour\
				and tile.piece.piece != ChessPieceNode.PIECE.NONE:
				pieces.append(tile)
	
	for piece in pieces:
		var checked_array = check_moves(piece,[],false)
		for checked_piece in checked_array:
			if !checked_piece in array: 
				array.append(checked_piece)
	
	return array
	
func check_making_check(source: Tile)-> bool:
	var opposing_pieces : Array[Tile] = []
	var checked:bool = false
	
	Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
	
	for row in tiles:
		for tile in row:
			if tile.piece.colour == source.piece.colour\
				and tile.piece.piece != ChessPieceNode.PIECE.NONE:
				opposing_pieces.append(tile)
	for tile in opposing_pieces:
		for check in checked_tiles(tile):
			if check.piece.piece == ChessPieceNode.PIECE.KING \
				and tiles[check.row][check.col].piece.colour != source.piece.colour:
					checked = true
	
	return checked
	
func check_checks(source: Tile)-> bool:
	var opposing_pieces : Array[Tile] = []
	var checked:bool = false
	
	for row in tiles:
		for tile in row:
			if tile.piece.colour != source.piece.colour\
				and tile.piece.piece != ChessPieceNode.PIECE.NONE:
				opposing_pieces.append(tile)
	for tile in opposing_pieces:
		for check in checked_tiles(tile):
			
			if check.piece.piece == ChessPieceNode.PIECE.KING \
				and check.piece.colour == source.piece.colour:
					checked = true
	
	return checked

func checked_tiles(source : Tile) -> Array[Tile]:
	
	if source.piece.colour==ChessPieceNode.COLOUR.WHITE \
		and source.piece.piece==ChessPieceNode.PIECE.PAWN:
		return Move_Validation.white_pawn_checks(source)
	
	if source.piece.colour==ChessPieceNode.COLOUR.BLACK \
		and source.piece.piece==ChessPieceNode.PIECE.PAWN:
		return Move_Validation.black_pawn_checks(source)
		
	if source.piece.piece==ChessPieceNode.PIECE.ROOK:
		return Move_Validation.rook_checks(source)
		
	if source.piece.piece==ChessPieceNode.PIECE.BISHOP:
		return Move_Validation.bishop_checks(source)
	
	if source.piece.piece==ChessPieceNode.PIECE.KNIGHT:
		return Move_Validation.knight_checks(source)
		
	if source.piece.piece==ChessPieceNode.PIECE.QUEEN:
		return Move_Validation.queen_checks(source)
		
	if source.piece.piece==ChessPieceNode.PIECE.KING:
		return Move_Validation.king_checks(source)
	
	return []

func check_moves(source : Tile, array :Array[Tile] = [], activate:bool = true):
	
	if source.piece.colour==ChessPieceNode.COLOUR.WHITE \
		and source.piece.piece==ChessPieceNode.PIECE.PAWN:
		if activate:
			activate_possibles(Move_Validation.movements_white_pawn(source, array))
			return
		return Move_Validation.movements_white_pawn(source, array)
	
	if source.piece.colour==ChessPieceNode.COLOUR.BLACK \
		and source.piece.piece==ChessPieceNode.PIECE.PAWN:
		if activate:
			activate_possibles(Move_Validation.movements_black_pawn(source,array))
			return
		return Move_Validation.movements_black_pawn(source,array)
		
	if source.piece.piece==ChessPieceNode.PIECE.ROOK:
		if activate:
			activate_possibles(Move_Validation.movements_rook(source,array))
			return
		return Move_Validation.movements_rook(source,array)
		
	if source.piece.piece==ChessPieceNode.PIECE.BISHOP:
		if activate:
			activate_possibles(Move_Validation.movements_bishop(source, array))
			return
		return Move_Validation.movements_bishop(source, array)
	
	if source.piece.piece==ChessPieceNode.PIECE.KNIGHT:
		if activate:
			activate_possibles(Move_Validation.movements_knight(source, array))
			return
		return Move_Validation.movements_knight(source, array)
		
	if source.piece.piece==ChessPieceNode.PIECE.QUEEN:
		if activate:
			activate_possibles(Move_Validation.movements_queen(source, array))
			return
		return Move_Validation.movements_queen(source, array)
		
	if source.piece.piece==ChessPieceNode.PIECE.KING:
		if activate:
			activate_possibles(Move_Validation.movements_king(source, array))
		return Move_Validation.movements_king(source, array)

func activate_possibles(tiles : Array[Tile]):
	available_tiles = tiles
	for tile in tiles:
		tile.set_possible(true)
	return

func _set_board():
	for row in tiles:
		for tile in row:
			tile.piece.set_piece(ChessPieceNode.PIECE.NONE, ChessPieceNode.COLOUR.NONE, true)
	
	tiles[0][0].piece.set_piece(ChessPieceNode.PIECE.ROOK, ChessPieceNode.COLOUR.WHITE, true)
	tiles[0][1].piece.set_piece(ChessPieceNode.PIECE.KNIGHT, ChessPieceNode.COLOUR.WHITE, true)
	tiles[0][2].piece.set_piece(ChessPieceNode.PIECE.BISHOP, ChessPieceNode.COLOUR.WHITE, true)
	tiles[0][3].piece.set_piece(ChessPieceNode.PIECE.QUEEN, ChessPieceNode.COLOUR.WHITE, true)
	tiles[0][4].piece.set_piece(ChessPieceNode.PIECE.KING, ChessPieceNode.COLOUR.WHITE, true)
	tiles[0][5].piece.set_piece(ChessPieceNode.PIECE.BISHOP, ChessPieceNode.COLOUR.WHITE, true)
	tiles[0][6].piece.set_piece(ChessPieceNode.PIECE.KNIGHT, ChessPieceNode.COLOUR.WHITE, true)
	tiles[0][7].piece.set_piece(ChessPieceNode.PIECE.ROOK, ChessPieceNode.COLOUR.WHITE, true)
	
	for tile in tiles[1]:
		tile.piece.set_piece(ChessPieceNode.PIECE.PAWN, ChessPieceNode.COLOUR.WHITE, true)
	
		
	for tile in tiles[6]:
		tile.piece.set_piece(ChessPieceNode.PIECE.PAWN, ChessPieceNode.COLOUR.BLACK, true)
	
	tiles[7][0].piece.set_piece(ChessPieceNode.PIECE.ROOK, ChessPieceNode.COLOUR.BLACK, true)
	tiles[7][1].piece.set_piece(ChessPieceNode.PIECE.KNIGHT, ChessPieceNode.COLOUR.BLACK, true)
	tiles[7][2].piece.set_piece(ChessPieceNode.PIECE.BISHOP, ChessPieceNode.COLOUR.BLACK, true)
	tiles[7][3].piece.set_piece(ChessPieceNode.PIECE.QUEEN, ChessPieceNode.COLOUR.BLACK, true)
	tiles[7][4].piece.set_piece(ChessPieceNode.PIECE.KING, ChessPieceNode.COLOUR.BLACK, true)
	tiles[7][5].piece.set_piece(ChessPieceNode.PIECE.BISHOP, ChessPieceNode.COLOUR.BLACK, true)
	tiles[7][6].piece.set_piece(ChessPieceNode.PIECE.KNIGHT, ChessPieceNode.COLOUR.BLACK, true)
	tiles[7][7].piece.set_piece(ChessPieceNode.PIECE.ROOK, ChessPieceNode.COLOUR.BLACK, true)

func _set_board_lategame():
	for row in tiles:
		for tile in row:
			tile.piece.set_piece(ChessPieceNode.PIECE.NONE, ChessPieceNode.COLOUR.NONE, true)
	
	tiles[0][3].piece.set_piece(ChessPieceNode.PIECE.KNIGHT, ChessPieceNode.COLOUR.WHITE, true)
	tiles[0][4].piece.set_piece(ChessPieceNode.PIECE.KING, ChessPieceNode.COLOUR.WHITE, true)
	

	tiles[7][4].piece.set_piece(ChessPieceNode.PIECE.KING, ChessPieceNode.COLOUR.BLACK, true)

func show_textures():
	for row in tiles:
		for tile in row:
			tile.piece.modulate.a = 1

func clear_possibles():
	for row in tiles:
		for tile in row:
			tile.set_possible(false)

func _get_children(node: Node, reset: bool=false):
	if reset:
		row=0
		col=0
	var children = node.get_children()
	for child in children:
		if child is Tile:
			tiles[row][col]=child
			child.col = col
			child.row = row
			col+=1
			if col>7:
				col=0
				row+=1
		else:
			_get_children(child) 
			pass
	
func print_board():
	print("------------")
	for itrow in tiles:
		var string = ""
		for tile in itrow:
			string = string + tile.piece.piece_object.piece_to_string()
		print(string)
	print("------------")
	pass

func change_turn():
	white_turn = !white_turn
	for row in tiles:
		for tile in row:
			tile.piece.piece_object.turn_change()
