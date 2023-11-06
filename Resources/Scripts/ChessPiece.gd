class_name ChessPiece

var piece: ChessPieceNode.PIECE = ChessPieceNode.PIECE.NONE
var colour: ChessPieceNode.COLOUR = ChessPieceNode.COLOUR.NONE
var unmoved: bool = false
var enpassantable:bool = false : get = _get_enpassantable, set = _set_enpassantable
var enpassantable_array : Array[bool] = [false,false]

func _get_enpassantable() -> bool:
	return enpassantable_array[0]

func _set_enpassantable(enpassantable: bool = false):
	enpassantable_array = [enpassantable,enpassantable]
	
func set_enpassantable_array(enpassantable_array):
	self.enpassantable_array[0] = enpassantable_array[0]
	self.enpassantable_array[1] = enpassantable_array[1]
	return self

func copy_piece(chessPiece : ChessPiece):
	self.piece = chessPiece.piece
	self.colour = chessPiece.colour
	self.unmoved = chessPiece.unmoved
	self.enpassantable_array = chessPiece.enpassantable_array
	return self

func set_piece(
	piece :ChessPieceNode.PIECE = ChessPieceNode.PIECE.NONE,
	colour: ChessPieceNode.COLOUR=ChessPieceNode.COLOUR.NONE,
	unmoved: bool = false):
	enpassantable_array = [false,false]
	if piece == ChessPieceNode.PIECE.NONE\
		or colour==ChessPieceNode.COLOUR.NONE:
		self.piece = ChessPieceNode.PIECE.NONE
		self.colour = ChessPieceNode.COLOUR.NONE
	else:
		self.piece = piece
		self.colour = colour
		self.unmoved = unmoved
	return self

func set_unmoved(unmoved: bool):
	self.unmoved = unmoved
	return self

func piece_to_string() -> String:
	if piece == ChessPieceNode.PIECE.NONE:
		return "-"
	if piece == ChessPieceNode.PIECE.PAWN:
		return "p"
	if piece == ChessPieceNode.PIECE.ROOK:
		return "R"
	if piece == ChessPieceNode.PIECE.KNIGHT:
		return "N"
	if piece == ChessPieceNode.PIECE.BISHOP:
		return "B"
	if piece == ChessPieceNode.PIECE.KING:
		return "K"
	if piece == ChessPieceNode.PIECE.QUEEN:
		return "Q"
	return " "

func turn_change():
	if enpassantable_array[1]:
		enpassantable_array[1]= false
		return
	if enpassantable_array[0]:
		enpassantable_array[0]= false
		return
