package data;

import utest.Assert;
import utest.ITest;
import data.FieldData.Field;

class FieldDataTest implements ITest {
	public function new() {}

	public function testClickEmpty() {
		var field = new TestFieldData();
		field.init(14, 7, ThreeColors, 12345);
		field.clicked(0, 0);
		field.makeBackup();
		field.clicked(0, 0);
		Assert.isFalse(field.hasWon());
		Assert.isFalse(field.isGameOver());
		Assert.isTrue(field.isUnchanged());
	}

	public function testClickOnSingleTwoColors() {
		var field = new TestFieldData();
		field.init(15, 11, TwoColors, 12345);
		field.makeBackup();
		field.clicked(4, 5);
		Assert.isFalse(field.hasWon());
		Assert.isFalse(field.isGameOver());
		Assert.isTrue(field.isUnchanged());
	}

	public function testClickOnSingleThreeColors() {
		var field = new TestFieldData();
		field.init(15, 11, ThreeColors, 12345);
		field.makeBackup();
		field.clicked(3, 3);
		Assert.isFalse(field.hasWon());
		Assert.isFalse(field.isGameOver());
		Assert.isTrue(field.isUnchanged());
	}

	public function testClickOnSingleFourColors() {
		var field = new TestFieldData();
		field.init(15, 11, FourColors, 12345);
		field.makeBackup();
		field.clicked(2, 1);
		Assert.isFalse(field.hasWon());
		Assert.isFalse(field.isGameOver());
		Assert.isTrue(field.isUnchanged());
	}

	public function testHashWon() {
		var field = new FieldData();
		field.init(15, 11, ThreeColors, 12345);

		field.clicked(11, 1);
		Assert.isFalse(field.hasWon());
		field.clicked(12, 1);
		Assert.isFalse(field.hasWon());
		field.clicked(12, 3);
		Assert.isFalse(field.hasWon());
		field.clicked(12, 4);
		Assert.isFalse(field.hasWon());
		field.clicked(14, 6);
		Assert.isFalse(field.hasWon());
		field.clicked(13, 7);
		Assert.isFalse(field.hasWon());
		field.clicked(12, 7);
		Assert.isFalse(field.hasWon());
		field.clicked(10, 7);
		Assert.isFalse(field.hasWon());
		field.clicked(10, 8);
		Assert.isFalse(field.hasWon());
		field.clicked(11, 8);
		Assert.isFalse(field.hasWon());
		field.clicked(12, 10);
		Assert.isFalse(field.hasWon());
		field.clicked(12, 10);
		Assert.isFalse(field.hasWon());
		field.clicked(8, 8);
		Assert.isFalse(field.hasWon());
		field.clicked(8, 7);
		Assert.isFalse(field.hasWon());
		field.clicked(7, 8);
		Assert.isFalse(field.hasWon());
		field.clicked(7, 8);
		Assert.isFalse(field.hasWon());
		field.clicked(4, 4);
		Assert.isFalse(field.hasWon());
		field.clicked(1, 4);
		Assert.isFalse(field.hasWon());
		field.clicked(3, 6);
		Assert.isFalse(field.hasWon());
		field.clicked(3, 8);
		Assert.isFalse(field.hasWon());
		field.clicked(3, 10);
		Assert.isFalse(field.hasWon());
		field.clicked(2, 7);
		Assert.isFalse(field.hasWon());
		field.clicked(6, 10);
		Assert.isFalse(field.hasWon());
		field.clicked(4, 10);
		Assert.isFalse(field.hasWon());
		field.clicked(0, 8);
		Assert.isFalse(field.hasWon());
		field.clicked(1, 9);

		Assert.isTrue(field.hasWon());
	}

	public function testIsGameOver() {
		var field = new FieldData();
		field.init(15, 11, ThreeColors, 12345);

		Assert.isFalse(field.isGameOver());
		field.clicked(13, 1);
		Assert.isFalse(field.isGameOver());
		field.clicked(13, 2);
		Assert.isFalse(field.isGameOver());
		field.clicked(12, 4);
		Assert.isFalse(field.isGameOver());
		field.clicked(14, 6);
		Assert.isFalse(field.isGameOver());
		field.clicked(13, 7);
		Assert.isFalse(field.isGameOver());
		field.clicked(12, 8);
		Assert.isFalse(field.isGameOver());
		field.clicked(13, 9);
		Assert.isFalse(field.isGameOver());
		field.clicked(12, 10);
		Assert.isFalse(field.isGameOver());
		field.clicked(11, 9);
		Assert.isFalse(field.isGameOver());
		field.clicked(10, 10);
		Assert.isFalse(field.isGameOver());
		field.clicked(10, 10);
		Assert.isFalse(field.isGameOver());
		field.clicked(9, 9);
		Assert.isFalse(field.isGameOver());
		field.clicked(9, 9);
		Assert.isFalse(field.isGameOver());
		field.clicked(7, 10);
		Assert.isFalse(field.isGameOver());
		field.clicked(5, 6);
		Assert.isFalse(field.isGameOver());
		field.clicked(3, 4);
		Assert.isFalse(field.isGameOver());
		field.clicked(1, 2);
		Assert.isFalse(field.isGameOver());
		field.clicked(0, 2);
		Assert.isFalse(field.isGameOver());
		field.clicked(4, 6);
		Assert.isFalse(field.isGameOver());
		field.clicked(3, 8);
		Assert.isFalse(field.isGameOver());
		field.clicked(7, 9);
		Assert.isFalse(field.isGameOver());
		field.clicked(7, 9);
		Assert.isFalse(field.isGameOver());
		field.clicked(6, 10);
		Assert.isFalse(field.isGameOver());
		field.clicked(5, 10);
		Assert.isFalse(field.isGameOver());
		field.clicked(2, 9);
		Assert.isFalse(field.isGameOver());
		field.clicked(0, 7);
		Assert.isFalse(field.isGameOver());
		field.clicked(0, 8);
		Assert.isFalse(field.isGameOver());
		field.clicked(1, 10);

		Assert.isTrue(field.isGameOver());
	}

	function testUndoNewGame() {
		var field = new TestFieldData();
		field.init(15, 11, ThreeColors, 12345);

		field.makeBackup();
		field.undo();
		Assert.isTrue(field.isUnchanged());
	}

	function testUndo() {
		var field = new TestFieldData();
		field.init(15, 11, ThreeColors, 12345);

		field.makeBackup();
		field.clicked(11, 2);
		Assert.isFalse(field.isUnchanged());
		field.undo();
		Assert.isTrue(field.isUnchanged());
	}

	function testUndoVictory() {
		var field = new FieldData();
		field.init(15, 11, ThreeColors, 12345);

		field.clicked(11, 1);
		field.clicked(12, 1);
		field.clicked(12, 3);
		field.clicked(12, 4);
		field.clicked(14, 6);
		field.clicked(13, 7);
		field.clicked(12, 7);
		field.clicked(10, 7);
		field.clicked(10, 8);
		field.clicked(11, 8);
		field.clicked(12, 10);
		field.clicked(12, 10);
		field.clicked(8, 8);
		field.clicked(8, 7);
		field.clicked(7, 8);
		field.clicked(7, 8);
		field.clicked(4, 4);
		field.clicked(1, 4);
		field.clicked(3, 6);
		field.clicked(3, 8);
		field.clicked(3, 10);
		field.clicked(2, 7);
		field.clicked(6, 10);
		field.clicked(4, 10);
		field.clicked(0, 8);
		field.clicked(1, 9);

		Assert.isTrue(field.hasWon());

		field.undo();
		Assert.isFalse(field.hasWon());
	}

	function testUndoGameOver() {
		var field = new FieldData();
		field.init(15, 11, ThreeColors, 12345);
		field.clicked(13, 1);
		field.clicked(13, 2);
		field.clicked(12, 4);
		field.clicked(14, 6);
		field.clicked(13, 7);
		field.clicked(12, 8);
		field.clicked(13, 9);
		field.clicked(12, 10);
		field.clicked(11, 9);
		field.clicked(10, 10);
		field.clicked(10, 10);
		field.clicked(9, 9);
		field.clicked(9, 9);
		field.clicked(7, 10);
		field.clicked(5, 6);
		field.clicked(3, 4);
		field.clicked(1, 2);
		field.clicked(0, 2);
		field.clicked(4, 6);
		field.clicked(3, 8);
		field.clicked(7, 9);
		field.clicked(7, 9);
		field.clicked(6, 10);
		field.clicked(5, 10);
		field.clicked(2, 9);
		field.clicked(0, 7);
		field.clicked(0, 8);
		field.clicked(1, 10);
		Assert.isTrue(field.isGameOver());

		field.undo();
		Assert.isFalse(field.isGameOver());
	}
}

class TestFieldData extends FieldData {
	var backupFields:Array<Field>;

	public function new() {
		super();
		backupFields = [];
	}

	public function makeBackup():Void {
		backupFields = fields.copy();
	}

	public function isUnchanged():Bool {
		if (fields.length != backupFields.length) {
			return false;
		}
		for (i in 0...fields.length) {
			if (fields[i] != backupFields[i]) {
				return false;
			}
		}
		return true;
	}
}
