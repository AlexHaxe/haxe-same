package data;

import utils.RandomLCG;
import data.FieldData.Field;
import data.FieldData.FieldType;

class FieldGenerator {
	var cols:Int;
	var rows:Int;
	var type:FieldType;
	var lcg:RandomLCG;
	var colHeight:Array<Array<Field>>;
	var allShapes:Array<Shape>;

	public function new(cols:Int, rows:Int, type:FieldType, seed:UInt) {
		this.cols = cols;
		this.rows = rows;
		this.type = type;
		lcg = new RandomLCG(seed);
		allShapes = Shape.makeAllShapes();
	}

	public function generate():Array<Field> {
		colHeight = [for (i in 0...cols) []];
		var mod = switch (type) {
			case TwoColors: 2;
			case ThreeColors: 3;
			case FourColors: 4;
		}

		while (!isFull()) {
			var columns:Array<Int> = availCols();
			var col:Int = columns[lcg.randMS() % columns.length];
			var freeSpace:Int = rows - colHeight[col].length;
			var color:Field = makeField(mod);
			var usableShapes:Array<Shape> = allShapes;

			if (isLeftFull(col) && isRightFull(col)) {
				if (freeSpace == 1) {
					var insertRow:Int = lcg.randMS() % colHeight[col].length;
					insert(colHeight[col][insertRow], col, insertRow);
					continue;
				}
				usableShapes = allShapes.filter(s -> s.getWidth() == 1);
			}
			switch (cols - col) {
				case 1:
					usableShapes = usableShapes.filter(s -> s.getWidth() == 1);
				case 2:
					usableShapes = usableShapes.filter(s -> s.getWidth() <= 2);
				case _:
			}

			var shape = usableShapes[lcg.randMS() % usableShapes.length];
			var maxHeight:Int = switch (shape.getWidth()) {
				case 1:
					colHeight[col].length;
				case 2:
					Math.floor(Math.min(colHeight[col].length, colHeight[col + 1].length));
				case 3:
					Math.floor(Math.min(Math.min(colHeight[col].length, colHeight[col + 1].length), colHeight[col + 2].length));
				case _:
					colHeight[col].length;
			}
			var insertRow:Int = lcg.randMS() % maxHeight;
			if (insertRow + shape.getHeight() > rows) {
				insertRow = rows - shape.getHeight() - 1;
			}
			tryInsertShape(shape, color, col, insertRow);
		}
		return generateFields();
	}

	function generateFields():Array<Field> {
		var fields:Array<Field> = [for (i in 0...cols * rows) Empty];
		for (c in 0...colHeight.length) {
			var column = colHeight[c];
			for (r in 0...column.length) {
				fields[xy(c, rows - r - 1, cols)] = column[r];
			}
		}
		return fields;
	}

	function isFull():Bool {
		for (i in 0...cols) {
			if (colHeight[i].length < rows) {
				return false;
			}
		}
		return true;
	}

	function availCols():Array<Int> {
		return [
			for (i in 0...cols)
				if (colHeight[i].length >= rows) {
					continue;
				} else {
					i;
				}
		];
	}

	function isLeftFull(col:Int):Bool {
		if (col == 0) {
			return true;
		}
		return (colHeight[col - 1].length == rows);
	}

	function isRightFull(col:Int):Bool {
		if (col == cols - 1) {
			return true;
		}
		return (colHeight[col + 1].length == rows);
	}

	function makeField(mod:Int):Field {
		var x = switch (lcg.randMS() % mod) {
			case 0:
				Red;
			case 1:
				Blue;
			case 2:
				Green;
			case 3:
				Yellow;
			case _:
				Empty;
		}
		return x;
	}

	function insert(color:Field, col:Int, row:Int) {
		var column:Array<Field> = colHeight[col];
		if (row > column.length) {
			return;
		}
		if (row == column.length) {
			column.push(color);
			return;
		}
		column.insert(row, color);
	}

	function tryInsertShape(shape:Shape, color:Field, col:Int, row:Int) {
		for (i in 0...3) {
			var sum:Int = shape.getColumnSum(i);
			if (sum == 0) {
				continue;
			}
			var freeSpace:Int = rows - colHeight[col + i].length;
			if (freeSpace < sum) {
				return;
			}
			var gap:Int = shape.getColumnGap(i);
			if (gap == 0) {
				continue;
			}
			if (row + gap > colHeight[col + i].length) {
				return;
			}
		}
		for (c in 0...3) {
			for (r in 0...3) {
				var pos:Int = c + (2 - r) * 3;
				if (shape[pos] == 0) {
					continue;
				}
				colHeight[col + c].insert(row + r, color);
			}
		}
	}

	static inline function xy(col:Int, row:Int, cols:Int):Int {
		return (col + row * cols);
	}
}

abstract Shape(Array<Int>) from Array<Int> to Array<Int> {
	public function getHeight():Int {
		for (i in 0...3) {
			if (this[i] != 0) {
				return 3;
			}
		}
		for (i in 3...6) {
			if (this[i] != 0) {
				return 2;
			}
		}
		return 1;
	}

	public function getWidth():Int {
		for (i in [2, 5, 8]) {
			if (this[i] != 0) {
				return 3;
			}
		}
		for (i in [1, 4, 7]) {
			if (this[i] != 0) {
				return 2;
			}
		}
		return 1;
	}

	public function getColumnSum(col:Int):Int {
		return switch (col) {
			case 0:
				this[0] + this[3] + this[6];
			case 1:
				this[1] + this[4] + this[7];
			case 2:
				this[2] + this[5] + this[8];
			case _:
				0;
		}
	}

	public function getColumnGap(col:Int):Int {
		switch (col) {
			case 0:
				if (this[6] != 0) {
					return 0;
				}
				if (this[3] != 0) {
					return 1;
				}
				if (this[0] != 0) {
					return 2;
				}
			case 1:
				if (this[7] != 0) {
					return 0;
				}
				if (this[4] != 0) {
					return 1;
				}
				if (this[1] != 0) {
					return 2;
				}
			case 2:
				if (this[8] != 0) {
					return 0;
				}
				if (this[5] != 0) {
					return 1;
				}
				if (this[2] != 0) {
					return 2;
				}
			case _:
		}
		return 0;
	}

	public static function makeAllShapes():Array<Shape> {
		var shapes:Array<Shape> = [
			[
				0, 0, 0,
				1, 0, 0,
				1, 0, 0
			],
			[
				1, 0, 0,
				1, 0, 0,
				1, 0, 0
			],
			[
				0, 0, 0,
				0, 0, 0,
				1, 1, 0
			],
			[
				0, 0, 0,
				0, 0, 0,
				1, 1, 1
			],
			[
				0, 0, 0,
				1, 0, 0,
				1, 1, 0
			],
			[
				0, 0, 0,
				0, 1, 0,
				1, 1, 0
			],
			[
				0, 0, 0,
				1, 1, 0,
				0, 1, 0
			],
			[
				0, 0, 0,
				1, 1, 0,
				1, 0, 0
			],
			[
				0, 0, 0,
				0, 1, 0,
				1, 1, 1
			],
			[
				1, 0, 0,
				1, 1, 0,
				1, 0, 0
			],
			[
				0, 1, 0,
				1, 1, 0,
				0, 1, 0
			],
			[
				0, 0, 0,
				1, 1, 1,
				0, 1, 0
			],
			[
				0, 0, 0,
				1, 0, 0,
				1, 1, 1
			],
			[
				0, 0, 0,
				1, 1, 1,
				1, 0, 0
			],
			[
				1, 0, 0,
				1, 0, 0,
				1, 1, 0
			],
			[
				0, 1, 0,
				0, 1, 0,
				1, 1, 0
			],
			[
				0, 1, 0,
				1, 1, 1,
				0, 1, 0
			]
		];
		// higher probability of 2x1 and 1x2 pieces
		for (i in 0...20) {
			shapes.push([
				0, 0, 0,
				1, 0, 0,
				1, 0, 0
			]);
			shapes.push([
				0, 0, 0,
				0, 0, 0,
				1, 1, 0
			]);
		}
		return shapes;
	}
}
