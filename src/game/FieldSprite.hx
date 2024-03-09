package game;

import data.FieldData;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class FieldSprite extends FlxSprite {
	public var col(default, null):Int;
	public var row(default, null):Int;

	final FIELD_SIZE:Int = 20;

	public function new(col:Int, row:Int, field:Field) {
		super(col * FIELD_SIZE, row * FIELD_SIZE);
		this.col = col;
		this.row = row;
		updateField(field);
		immovable = true;
	}

	public function updateField(field:Field) {
		makeGraphic(FIELD_SIZE, FIELD_SIZE, fieldColor(field));
	}

	function fieldColor(field:Field):FlxColor {
		return switch (field) {
			case Empty:
				FlxColor.TRANSPARENT;
			case Red:
				FlxColor.RED;
			case Blue:
				FlxColor.BLUE;
			case Green:
				FlxColor.GREEN;
			case Yellow:
				FlxColor.YELLOW;
		}
	}
}
