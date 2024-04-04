package data;

import utils.RandomLCG;

class FieldData {
	var fields:Array<Field>;

	public var cols(default, null):Int;
	public var rows(default, null):Int;
	public var seed(default, null):UInt;
	public var type(default, null):FieldType;

	var moves:Array<Move>;

	public function new() {
		fields = [];
		moves = [];
		cols = 7;
		rows = 7;
	}

	public function init(cols:Int = 7, rows:Int = 7, type:FieldType = ThreeColors, seed:UInt):Void {
		this.cols = cols;
		this.rows = rows;
		this.seed = seed;
		this.type = type;
		moves = [];
		#if debug
		trace('init $type field with ${cols}x${rows} with seed $seed');
		#end
		var generator:FieldGenerator = new FieldGenerator(cols, rows, type, seed);

		fields = generator.generate();
	}

	#if (sys || nodejs)
	public function dumpField():Void {
		for (row in 0...rows) {
			for (col in 0...cols) {
				Sys.print(switch (fields[xy(col, row)]) {
					case Empty: " ";
					case Red: "R";
					case Blue: "B";
					case Green: "G";
					case Yellow: "Y";
				});
			}
			Sys.println("");
		}
	}
	#end

	public function applyGravity():Void {
		for (c in 0...cols) {
			var col:Int = cols - c - 1;
			var emptyCount:Int = 0;
			for (row in 0...rows) {
				var r:Int = rows - row - 1;
				var field = getFieldAt(col, r);
				switch (field) {
					case Empty:
						emptyCount++;
					case Red | Blue | Green | Yellow if (emptyCount > 0):
						fields[xy(col, r + emptyCount)] = field;
						fields[xy(col, r)] = Empty;
					case Red | Blue | Green | Yellow:
				}
			}
			if (emptyCount == rows) {
				compress(col);
			}
		}
	}

	function compress(emptyCol:Int):Void {
		if (emptyCol == cols - 1) {
			return;
		}
		for (row in 0...rows) {
			for (col in emptyCol + 1...cols) {
				fields[xy(col - 1, row)] = getFieldAt(col, row);
				fields[xy(col, row)] = Empty;
			}
		}
	}

	public function clicked(col:Int, row:Int):Bool {
		trace("click " + col + "x" + row);
		var color:Field = getFieldAt(col, row);
		var count:Int = 0;
		if (color == Empty) {
			return false;
		}

		count = lookLeft(col, row, color) + lookRight(col, row, color) + lookUp(col, row, color) + lookDown(col, row, color);
		if (count <= 0) {
			return false;
		}
		moves.push({col: col, row: row});
		fields[xy(col, row)] = Empty;
		applyGravity();
		return true;
	}

	function lookUp(currentCol:Int, currentRow:Int, color:Field):Int {
		var count:Int = 0;
		for (r in 0...currentRow) {
			var row = currentRow - r - 1;
			if (getFieldAt(currentCol, row) == color) {
				fields[xy(currentCol, row)] = Empty;
				count++;
				count += lookLeft(currentCol, row, color) + lookRight(currentCol, row, color);
				continue;
			}
			break;
		}
		return count;
	}

	function lookDown(currentCol:Int, currentRow:Int, color:Field):Int {
		var count:Int = 0;
		for (row in currentRow + 1...rows) {
			if (getFieldAt(currentCol, row) == color) {
				fields[xy(currentCol, row)] = Empty;
				count++;
				count += lookLeft(currentCol, row, color) + lookRight(currentCol, row, color);
				continue;
			}
			break;
		}
		return count;
	}

	function lookLeft(currentCol:Int, currentRow:Int, color:Field):Int {
		var count:Int = 0;
		for (c in 0...currentCol) {
			var col = currentCol - c - 1;
			if (getFieldAt(col, currentRow) == color) {
				fields[xy(col, currentRow)] = Empty;
				count++;
				count += lookUp(col, currentRow, color) + lookDown(col, currentRow, color);
				continue;
			}
			break;
		}
		return count;
	}

	function lookRight(currentCol:Int, currentRow:Int, color:Field):Int {
		var count:Int = 0;
		for (col in currentCol + 1...cols) {
			if (getFieldAt(col, currentRow) == color) {
				fields[xy(col, currentRow)] = Empty;
				count++;
				count += lookUp(col, currentRow, color) + lookDown(col, currentRow, color);
				continue;
			}
			break;
		}
		return count;
	}

	public function hasWon():Bool {
		for (i in 0...cols * rows) {
			if (fields[i] != Empty) {
				return false;
			}
		}
		return true;
	}

	public function isGameOver():Bool {
		for (row in 0...rows) {
			var prevColor = getFieldAt(0, row);
			for (col in 1...cols) {
				var color = getFieldAt(col, row);
				if (prevColor == Empty) {
					prevColor = color;
					continue;
				}
				if (color == prevColor) {
					return false;
				}
				prevColor = color;
			}
		}
		for (col in 0...cols) {
			var prevColor = getFieldAt(col, 0);
			for (row in 1...rows) {
				var color = getFieldAt(col, row);
				if (prevColor == Empty) {
					prevColor = color;
					continue;
				}
				if (color == prevColor) {
					return false;
				}
				prevColor = color;
			}
		}
		return true;
	}

	inline function xy(col:Int, row:Int):Int {
		return (col + row * cols);
	}

	public inline function getFieldAt(col:Int, row:Int):Field {
		return fields[xy(col, row)];
	}

	public function undo():Bool {
		if (moves.length <= 0) {
			return false;
		}
		var oldMoves = moves;
		init(this.cols, this.rows, this.type, this.seed);
		var lastMove:Move = oldMoves.pop();
		trace('undo ${lastMove.col}x${lastMove.row}');
		for (move in oldMoves) {
			clicked(move.col, move.row);
		}
		return true;
	}
}

enum Field {
	Empty;
	Red;
	Blue;
	Green;
	Yellow;
}

enum FieldType {
	TwoColors;
	ThreeColors;
	FourColors;
}

typedef Move = {
	var col:Int;
	var row:Int;
}
