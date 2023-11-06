class_name Move_Validation

static var tiles

static func movements_white_pawn(source:Tile, tile_list: Array[Tile] = []) -> Array[Tile]:
	
	if source.row+1>7:
		pass
	#movement
	elif tiles[source.row+1][source.col].piece.piece == ChessPieceNode.PIECE.NONE:
		Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
		#Board.secret_board.print_board()
		Board.secret_board.secret_move(source,tiles[source.row+1][source.col])
		if !Board.secret_board.check_checks(source):
			tile_list.append(tiles[source.row+1][source.col])
	
	#double movement
	if source.row+2>7:
		pass
	elif tiles[source.row+2][source.col].piece.piece == ChessPieceNode.PIECE.NONE \
		and source.piece.unmoved \
		and tiles[source.row+1][source.col].piece.piece == ChessPieceNode.PIECE.NONE:
		Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
		#Board.secret_board.print_board()
		Board.secret_board.secret_move(source,tiles[source.row+2][source.col])
		if !Board.secret_board.check_checks(source):
			tile_list.append(tiles[source.row+2][source.col])
	
	if source.row+1>7 \
		or source.col+1>7 :
		pass
	#taking
	elif tiles[source.row+1][source.col+1].piece.piece != ChessPieceNode.PIECE.NONE\
		and tiles[source.row+1][source.col+1].piece.colour != source.piece.colour:	
		Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
		#Board.secret_board.print_board()
		Board.secret_board.secret_move(source,tiles[source.row+1][source.col+1])
		if !Board.secret_board.check_checks(source):
			tile_list.append(tiles[source.row+1][source.col+1])
		
	if source.row+1>7 \
		or source.col-1<0 :
		pass
	elif tiles[source.row+1][source.col-1].piece.piece != ChessPieceNode.PIECE.NONE\
		and tiles[source.row+1][source.col-1].piece.colour != source.piece.colour:
		Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
		#Board.secret_board.print_board()
		Board.secret_board.secret_move(source,tiles[source.row+1][source.col-1])
		if !Board.secret_board.check_checks(source):
			tile_list.append(tiles[source.row+1][source.col-1])
	
	if source.row+1>7 \
		or source.col+1>7 :
		pass
	#enpassant
	elif tiles[source.row+1][source.col+1].piece.piece == ChessPieceNode.PIECE.NONE\
		and tiles[source.row+1][source.col+1].piece.piece_object.enpassantable:		
		Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
		#Board.secret_board.print_board()
		Board.secret_board.secret_move(source,tiles[source.row+1][source.col+1])
		if !Board.secret_board.check_checks(source):
			tile_list.append(tiles[source.row+1][source.col+1])
	
	if source.row+1>7 \
		or source.col+1>7 :
		pass
	elif tiles[source.row+1][source.col-1].piece.piece == ChessPieceNode.PIECE.NONE\
		and tiles[source.row+1][source.col-1].piece.piece_object.enpassantable:
		Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
		#Board.secret_board.print_board()
		Board.secret_board.secret_move(source,tiles[source.row+1][source.col+1])
		if !Board.secret_board.check_checks(source):
			tile_list.append(tiles[source.row+1][source.col-1])
		
	return tile_list
	
static func white_pawn_checks(source:Tile, tile_list: Array[Tile] = []) -> Array[Tile]:
	
	if source.row+1>7:
		pass
	
	if source.row+1>7 \
		or source.col+1>7 :
		pass
	#taking
	elif Board.secret_board.tiles[source.row+1][source.col+1].piece.piece != ChessPieceNode.PIECE.NONE\
		and Board.secret_board.tiles[source.row+1][source.col+1].piece.colour != source.piece.colour:
		tile_list.append(Board.secret_board.tiles[source.row+1][source.col+1])
		
	if source.row+1>7 \
		or source.col-1<0 :
		pass
	elif Board.secret_board.tiles[source.row+1][source.col-1].piece.piece != ChessPieceNode.PIECE.NONE\
		and Board.secret_board.tiles[source.row+1][source.col-1].piece.colour != source.piece.colour:
		tile_list.append(Board.secret_board.tiles[source.row+1][source.col-1])
	
	if source.row+1>7 \
		or source.col+1>7 :
		pass
		
	return tile_list
	
static func movements_black_pawn(source:Tile, tile_list: Array[Tile] = []) -> Array[Tile]:
	
	if source.row-1<0:
		pass
	#movement
	elif tiles[source.row-1][source.col].piece.piece == ChessPieceNode.PIECE.NONE:
		Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
		#Board.secret_board.print_board()
		Board.secret_board.secret_move(source,tiles[source.row-1][source.col])
		if !Board.secret_board.check_checks(source):
			tile_list.append(tiles[source.row-1][source.col])
	
	#double movement
	if source.row-2<0:
		pass
	elif tiles[source.row-2][source.col].piece.piece == ChessPieceNode.PIECE.NONE \
		and source.piece.unmoved \
		and tiles[source.row-1][source.col].piece.piece == ChessPieceNode.PIECE.NONE:
		Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
		#Board.secret_board.print_board()
		Board.secret_board.secret_move(source,tiles[source.row-2][source.col])
		if !Board.secret_board.check_checks(source):
			tile_list.append(tiles[source.row-2][source.col])
	
	if source.row-1<0 \
		or source.col+1>7 :
		pass
	#taking
	elif tiles[source.row-1][source.col+1].piece.piece != ChessPieceNode.PIECE.NONE\
		and tiles[source.row-1][source.col+1].piece.colour != source.piece.colour:
		Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
		#Board.secret_board.print_board()
		Board.secret_board.secret_move(source,tiles[source.row-1][source.col+1])
		if !Board.secret_board.check_checks(source):
			tile_list.append(tiles[source.row-1][source.col+1])
		
	if source.row-1<0\
		or source.col-1<0 :
		pass
	elif tiles[source.row-1][source.col-1].piece.piece != ChessPieceNode.PIECE.NONE\
		and tiles[source.row-1][source.col-1].piece.colour != source.piece.colour:
		Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
		#Board.secret_board.print_board()
		Board.secret_board.secret_move(source,tiles[source.row-1][source.col-1])
		if !Board.secret_board.check_checks(source):
			tile_list.append(tiles[source.row-1][source.col-1])
		
	if source.row+-1<0 \
		or source.col+1>7 :
		pass
	#enpassant
	elif tiles[source.row-1][source.col+1].piece.piece == ChessPieceNode.PIECE.NONE\
		and tiles[source.row-1][source.col+1].piece.piece_object.enpassantable \
		and tiles[source.row-1][source.col+1].piece.colour != source.piece.colour:
		Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
		#Board.secret_board.print_board()
		Board.secret_board.secret_move(source,tiles[source.row-1][source.col+1])
		if !Board.secret_board.check_checks(source):
			tile_list.append(tiles[source.row-1][source.col+1])
	
	if source.row-1<0 \
		or source.col-1<0 :
		pass
	elif tiles[source.row-1][source.col-1].piece.piece == ChessPieceNode.PIECE.NONE\
		and tiles[source.row-1][source.col-1].piece.piece_object.enpassantable \
		and tiles[source.row-1][source.col-1].piece.colour != source.piece.colour:
		Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
		#Board.secret_board.print_board()
		Board.secret_board.secret_move(source,tiles[source.row-1][source.col-1])
		if !Board.secret_board.check_checks(source):
			tile_list.append(tiles[source.row-1][source.col-1])

	return tile_list

static func black_pawn_checks(source:Tile, tile_list: Array[Tile] = []) -> Array[Tile]:
	if source.row-1<0:
		pass
	
	if source.row-1<0 \
		or source.col+1>7 :
		pass
	#taking
	elif Board.secret_board.tiles[source.row-1][source.col+1].piece.piece != ChessPieceNode.PIECE.NONE\
		and Board.secret_board.tiles[source.row-1][source.col+1].piece.colour != source.piece.colour:
		tile_list.append(Board.secret_board.tiles[source.row-1][source.col+1])
		
	if source.row-1<0\
		or source.col-1<0 :
		pass
	elif Board.secret_board.tiles[source.row-1][source.col-1].piece.piece != ChessPieceNode.PIECE.NONE\
		and Board.secret_board.tiles[source.row-1][source.col-1].piece.colour != source.piece.colour:
		tile_list.append(Board.secret_board.tiles[source.row-1][source.col-1])
		
	if source.row+-1<0 \
		or source.col+1>7 :
		pass
	
	return tile_list

static func movements_rook(source:Tile, tile_list: Array[Tile] = [])-> Array [Tile]:
	
	for i in range(source.col+1,8):
		if tiles[source.row][i].piece.piece != ChessPieceNode.PIECE.NONE\
			and tiles[source.row][i].piece.colour != source.piece.colour:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[source.row][i])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[source.row][i])
			break
		elif tiles[source.row][i].piece.piece == ChessPieceNode.PIECE.NONE:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[source.row][i])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[source.row][i])
		else:
			break
	
	for i in range(source.col-1,-1,-1):
		if tiles[source.row][i].piece.piece != ChessPieceNode.PIECE.NONE\
			and tiles[source.row][i].piece.colour != source.piece.colour:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[source.row][i])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[source.row][i])
			break
		elif tiles[source.row][i].piece.piece == ChessPieceNode.PIECE.NONE:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[source.row][i])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[source.row][i])
		else:
			break
	
	for i in range(source.row+1,8):
		if tiles[i][source.col].piece.piece != ChessPieceNode.PIECE.NONE\
			and tiles[i][source.col].piece.colour != source.piece.colour:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[i][source.col])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[i][source.col])
			break
		elif tiles[i][source.col].piece.piece == ChessPieceNode.PIECE.NONE:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[i][source.col])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[i][source.col])
		else:
			break
			
	for i in range(source.row-1,-1,-1):
		if tiles[i][source.col].piece.piece != ChessPieceNode.PIECE.NONE\
			and tiles[i][source.col].piece.colour != source.piece.colour:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[i][source.col])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[i][source.col])
			break
		elif tiles[i][source.col].piece.piece == ChessPieceNode.PIECE.NONE:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[i][source.col])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[i][source.col])
		else:
			break
	
	return tile_list
	
static func rook_checks(source:Tile, tile_list: Array[Tile] = []) -> Array[Tile]:
	
	for i in range(source.col+1,8):
		if Board.secret_board.tiles[source.row][i].piece.piece != ChessPieceNode.PIECE.NONE\
			and Board.secret_board.tiles[source.row][i].piece.colour != source.piece.colour:
			tile_list.append(Board.secret_board.tiles[source.row][i])
			break
		elif Board.secret_board.tiles[source.row][i].piece.piece == ChessPieceNode.PIECE.NONE:
			tile_list.append(Board.secret_board.tiles[source.row][i])
		else:
			break
	
	for i in range(source.col-1,-1,-1):
		if Board.secret_board.tiles[source.row][i].piece.piece != ChessPieceNode.PIECE.NONE\
			and Board.secret_board.tiles[source.row][i].piece.colour != source.piece.colour:
			tile_list.append(Board.secret_board.tiles[source.row][i])
			break
		elif Board.secret_board.tiles[source.row][i].piece.piece == ChessPieceNode.PIECE.NONE:
			tile_list.append(Board.secret_board.tiles[source.row][i])
		else:
			break
	
	for i in range(source.row+1,8):
		if Board.secret_board.tiles[i][source.col].piece.piece != ChessPieceNode.PIECE.NONE\
			and Board.secret_board.tiles[i][source.col].piece.colour != source.piece.colour:
			tile_list.append(Board.secret_board.tiles[i][source.col])
			break
		elif Board.secret_board.tiles[i][source.col].piece.piece == ChessPieceNode.PIECE.NONE:
			tile_list.append(Board.secret_board.tiles[i][source.col])
		else:
			break
			
	for i in range(source.row-1,-1,-1):
		if Board.secret_board.tiles[i][source.col].piece.piece != ChessPieceNode.PIECE.NONE\
			and Board.secret_board.tiles[i][source.col].piece.colour != source.piece.colour:
			tile_list.append(Board.secret_board.tiles[i][source.col])
			break
		elif Board.secret_board.tiles[i][source.col].piece.piece == ChessPieceNode.PIECE.NONE:
			tile_list.append(Board.secret_board.tiles[i][source.col])
		else:
			break
	
	return tile_list
	
static func movements_bishop(source:Tile, tile_list: Array[Tile] = [])-> Array [Tile]:
	
	var max_i : int
	
	max_i = min(8-source.row,8-source.col)
	
	for i in range(1,max_i):
		if tiles[source.row+i][source.col+i].piece.piece != ChessPieceNode.PIECE.NONE\
			and tiles[source.row+i][source.col+i].piece.colour != source.piece.colour:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[source.row+i][source.col+i])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[source.row+i][source.col+i])
			break
		elif tiles[source.row+i][source.col+i].piece.piece == ChessPieceNode.PIECE.NONE:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[source.row+i][source.col+i])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[source.row+i][source.col+i])
		else:
			break
			
	
	max_i = min(source.row+1,8-source.col)
	
	for i in range(1,max_i):
		if tiles[source.row-i][source.col+i].piece.piece != ChessPieceNode.PIECE.NONE\
			and tiles[source.row-i][source.col+i].piece.colour != source.piece.colour:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[source.row-i][source.col+i])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[source.row-i][source.col+i])
			break
		elif tiles[source.row-i][source.col+i].piece.piece == ChessPieceNode.PIECE.NONE:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[source.row-i][source.col+i])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[source.row-i][source.col+i])
		else:
			break
			
	
	max_i = min(8-source.row,source.col+1)
	
	for i in range(1,max_i):
		if tiles[source.row+i][source.col-i].piece.piece != ChessPieceNode.PIECE.NONE\
			and tiles[source.row+i][source.col-i].piece.colour != source.piece.colour:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[source.row+i][source.col-i])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[source.row+i][source.col-i])
			break
		elif tiles[source.row+i][source.col-i].piece.piece == ChessPieceNode.PIECE.NONE:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[source.row+i][source.col-i])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[source.row+i][source.col-i])
		else:
			break

	max_i = min(source.row+1,source.col+1)
	
	for i in range(1,max_i):
		if tiles[source.row-i][source.col-i].piece.piece != ChessPieceNode.PIECE.NONE\
			and tiles[source.row-i][source.col-i].piece.colour != source.piece.colour:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[source.row-i][source.col-i])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[source.row-i][source.col-i])
			break
		elif tiles[source.row-i][source.col-i].piece.piece == ChessPieceNode.PIECE.NONE:
			Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
			#Board.secret_board.print_board()
			Board.secret_board.secret_move(source,tiles[source.row-i][source.col-i])
			if !Board.secret_board.check_checks(source):
				tile_list.append(tiles[source.row-i][source.col-i])
		else:
			break
	
	return tile_list

static func bishop_checks(source:Tile, tile_list: Array[Tile] = [])-> Array [Tile]:
		
	var max_i : int
	
	max_i = min(8-source.row,8-source.col)
	
	for i in range(1,max_i):
		if Board.secret_board.tiles[source.row+i][source.col+i].piece.piece != ChessPieceNode.PIECE.NONE\
			and Board.secret_board.tiles[source.row+i][source.col+i].piece.colour != source.piece.colour:
			tile_list.append(Board.secret_board.tiles[source.row+i][source.col+i])
			break
		elif Board.secret_board.tiles[source.row+i][source.col+i].piece.piece == ChessPieceNode.PIECE.NONE:
			tile_list.append(Board.secret_board.tiles[source.row+i][source.col+i])
		else:
			break
			
	
	max_i = min(source.row+1,8-source.col)
	
	for i in range(1,max_i):
		if Board.secret_board.tiles[source.row-i][source.col+i].piece.piece != ChessPieceNode.PIECE.NONE\
			and Board.secret_board.tiles[source.row-i][source.col+i].piece.colour != source.piece.colour:
			tile_list.append(Board.secret_board.tiles[source.row-i][source.col+i])
			break
		elif Board.secret_board.tiles[source.row-i][source.col+i].piece.piece == ChessPieceNode.PIECE.NONE:
			tile_list.append(Board.secret_board.tiles[source.row-i][source.col+i])
		else:
			break
			
	
	max_i = min(8-source.row,source.col+1)
	
	for i in range(1,max_i):
		if Board.secret_board.tiles[source.row+i][source.col-i].piece.piece != ChessPieceNode.PIECE.NONE\
			and Board.secret_board.tiles[source.row+i][source.col-i].piece.colour != source.piece.colour:
			tile_list.append(Board.secret_board.tiles[source.row+i][source.col-i])
			break
		elif Board.secret_board.tiles[source.row+i][source.col-i].piece.piece == ChessPieceNode.PIECE.NONE:
			tile_list.append(Board.secret_board.tiles[source.row+i][source.col-i])
		else:
			break

	max_i = min(source.row+1,source.col+1)
	
	for i in range(1,max_i):
		if Board.secret_board.tiles[source.row-i][source.col-i].piece.piece != ChessPieceNode.PIECE.NONE\
			and Board.secret_board.tiles[source.row-i][source.col-i].piece.colour != source.piece.colour:
			tile_list.append(Board.secret_board.tiles[source.row-i][source.col-i])
			break
		elif Board.secret_board.tiles[source.row-i][source.col-i].piece.piece == ChessPieceNode.PIECE.NONE:
			tile_list.append(Board.secret_board.tiles[source.row-i][source.col-i])
		else:
			break
	
	return tile_list
	
static func movements_knight(source:Tile, tile_list: Array[Tile] = [])-> Array [Tile]:
	
	var possible_row : Array[int] = []
	var possible_col: Array[int] = []
	
	for i in range(-2,3):
		if i == 0:
			pass
		elif source.row+i<8\
			and source.row+i>-1:
			possible_row.append(i)
	
	for i in range(-2,3):
		if i == 0:
			pass
		elif source.col+i<8\
			and source.col+i>-1:
			possible_col.append(i)
	
	for row in possible_row:
		for col in possible_col:
			if abs(col)+abs(row)!=3:
				pass
			else:
				if tiles[source.row+row][source.col+col].piece.colour != source.piece.colour:
					Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
					#Board.secret_board.print_board()
					Board.secret_board.secret_move(source,tiles[source.row+row][source.col+col])
					if !Board.secret_board.check_checks(source):
						tile_list.append(tiles[source.row+row][source.col+col])
	
	return tile_list
	
static func knight_checks(source:Tile, tile_list: Array[Tile] = [])-> Array [Tile]:
	
	var possible_row : Array[int] = []
	var possible_col: Array[int] = []
	
	for i in range(-2,3):
		if i == 0:
			pass
		elif source.row+i<8\
			and source.row+i>-1:
			possible_row.append(i)
	
	for i in range(-2,3):
		if i == 0:
			pass
		elif source.col+i<8\
			and source.col+i>-1:
			possible_col.append(i)
	
	for row in possible_row:
		for col in possible_col:
			if abs(col)+abs(row)!=3:
				pass
			else:
				if Board.secret_board.tiles[source.row+row][source.col+col].piece.colour != source.piece.colour:
					tile_list.append(Board.secret_board.tiles[source.row+row][source.col+col])
	return tile_list
	
static func movements_queen(source:Tile, tile_list: Array[Tile] = [])-> Array [Tile]:
	tile_list = movements_bishop(source,tile_list)
	tile_list = movements_rook(source,tile_list)
	return tile_list

static func queen_checks(source:Tile, tile_list: Array[Tile] = [])-> Array [Tile]:
	tile_list = bishop_checks(source,tile_list)
	tile_list = rook_checks(source,tile_list)
	return tile_list

static func movements_king(source:Tile, tile_list: Array[Tile] = [])-> Array [Tile]:
	
	var possible_row : Array[int] = []
	var possible_col: Array[int] = []
	
	for i in range(-1,2):
		if source.row+i<8\
			and source.row+i>-1:
			possible_row.append(i)
	
	for i in range(-1,2):
		if source.col+i<8\
			and source.col+i>-1:
			possible_col.append(i)
			
	for row in possible_row:
		for col in possible_col:
			if col == 0 \
				and row == 0:
				pass
			else:
				if tiles[source.row+row][source.col+col].piece.colour != source.piece.colour:
					Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
					#Board.secret_board.print_board()
					Board.secret_board.secret_move(source,tiles[source.row+row][source.col+col])
					if !Board.secret_board.check_checks(source):
						tile_list.append(tiles[source.row+row][source.col+col])
	
	if source.piece.unmoved\
		and tiles[source.row][7].piece.piece == ChessPieceNode.PIECE.ROOK\
		and tiles[source.row][7].piece.colour == source.piece.colour\
		and tiles[source.row][7].piece.unmoved:
			var flag: bool = false
			for col in range(source.col+1,7):
				if tiles[source.row][col].piece.piece != ChessPieceNode.PIECE.NONE:
					flag = true
					break
			if !flag:
				var check_1:bool
				var check_2:bool
				Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
				#Board.secret_board.print_board()
				Board.secret_board.secret_move(source,tiles[source.row][source.col+1])
				check_1 = !Board.secret_board.check_checks(source)
				
				Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
				#Board.secret_board.print_board()
				Board.secret_board.secret_move(source,tiles[source.row][source.col+2])
				check_2 = !Board.secret_board.check_checks(source)
				
				if check_1 and check_2:
					tile_list.append(tiles[source.row][source.col+2])
				
	if source.piece.unmoved\
		and tiles[source.row][0].piece.piece == ChessPieceNode.PIECE.ROOK\
		and tiles[source.row][0].piece.colour == source.piece.colour\
		and tiles[source.row][0].piece.unmoved:
			var flag: bool = false
			for col in range(source.col-1,0,-1):
				if tiles[source.row][col].piece.piece != ChessPieceNode.PIECE.NONE:
					flag = true
					break
			if !flag:
				var check_1:bool
				var check_2:bool
				Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
				#Board.secret_board.print_board()
				Board.secret_board.secret_move(source,tiles[source.row][source.col-1])
				check_1 = !Board.secret_board.check_checks(source)
				
				Board.secret_board.load_move_in_secret(Board.current.previous_moves[-1])
				#Board.secret_board.print_board()
				Board.secret_board.secret_move(source,tiles[source.row][source.col-2])
				check_2 = !Board.secret_board.check_checks(source)
				
				if check_1 and check_2:
					tile_list.append(tiles[source.row][source.col-2])
			
	
	return tile_list

static func king_checks(source:Tile, tile_list: Array[Tile] = [])-> Array [Tile]:
	
	var possible_row : Array[int] = []
	var possible_col: Array[int] = []
	
	for i in range(-1,2):
		if source.row+i<8\
			and source.row+i>-1:
			possible_row.append(i)
	
	for i in range(-1,2):
		if source.col+i<8\
			and source.col+i>-1:
			possible_col.append(i)
			
	for row in possible_row:
		for col in possible_col:
			if col == 0 \
				and row == 0:
				pass
			else:
				if Board.secret_board.tiles[source.row+row][source.col+col].piece.colour != source.piece.colour:
					tile_list.append(Board.secret_board.tiles[source.row+row][source.col+col])
	
	return tile_list
