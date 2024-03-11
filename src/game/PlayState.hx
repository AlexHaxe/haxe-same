package game;

import haxe.ui.ComponentBuilder;
import haxe.ui.components.Button;
import haxe.ui.components.Label;
import haxe.ui.components.TextField;
import haxe.ui.containers.ButtonBar;
import haxe.ui.containers.VBox;
import data.FieldData;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouseEvent;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;
import utils.RandomLCG;

class PlayState extends FlxState {
	var walls:FlxGroup;
	var leftWall:FlxSprite;
	var rightWall:FlxSprite;
	var topWall:FlxSprite;
	var bottomWall:FlxSprite;

	var bricks:FlxTypedGroup<FieldSprite>;

	var fieldData:FieldData;

	var winLoss:VBox;
	var menu:VBox;

	override public function create():Void {
		fieldData = new FieldData();

		fieldData.init(15, 11, ThreeColors, RandomLCG.randomizedSeed());

		walls = new FlxGroup();

		leftWall = new FlxSprite(0, 0);
		leftWall.makeGraphic(10, 240, FlxColor.GRAY);
		leftWall.immovable = true;
		walls.add(leftWall);

		rightWall = new FlxSprite(310, 0);
		rightWall.makeGraphic(10, 240, FlxColor.GRAY);
		rightWall.immovable = true;
		walls.add(rightWall);

		topWall = new FlxSprite(0, 0);
		topWall.makeGraphic(320, 10, FlxColor.GRAY);
		topWall.immovable = true;
		walls.add(topWall);

		bottomWall = new FlxSprite(0, 230);
		bottomWall.makeGraphic(320, 10, FlxColor.GRAY);
		bottomWall.immovable = true;
		walls.add(bottomWall);

		bricks = new FlxTypedGroup<FieldSprite>();

		for (row in 0...fieldData.rows) {
			for (col in 0...fieldData.cols) {
				var tempBrick:FieldSprite = new FieldSprite(col, row, fieldData.getFieldAt(col, row));
				tempBrick.x += 10;
				tempBrick.y += 10;
				FlxMouseEvent.add(tempBrick, onDown, null, null, null);
				bricks.add(tempBrick);
			}
		}

		add(walls);
		add(bricks);

		initWinLoss();
		initMenu();
	}

	function initWinLoss() {
		winLoss = ComponentBuilder.fromFile("assets/ui/winloss.xml");
		add(winLoss);

		var label:Label = winLoss.findComponent("winloss", Label);
		label.text = "";
	}

	function initMenu() {
		menu = ComponentBuilder.fromFile("assets/ui/menu.xml");

		menu.x = 320;
		add(menu);

		var input:TextField = menu.findComponent("seed", TextField);
		input.text = '${fieldData.seed}';
		var buttonNew:Button = menu.findComponent("newgame", Button);
		buttonNew.onClick = function(e) {
			trace("new game clicked!!");
			fieldData.init(fieldData.cols, fieldData.rows, fieldData.type, RandomLCG.randomizedSeed());
			input.text = '${fieldData.seed}';
			updateWinLoss("");
			updateField();
		}
		var buttonRestart:Button = menu.findComponent("restart", Button);
		buttonRestart.onClick = function(e) {
			trace("restart clicked!!");
			fieldData.init(fieldData.cols, fieldData.rows, fieldData.type, fieldData.seed);
			updateWinLoss("");
			updateField();
		}
		var buttonSeed:Button = menu.findComponent("setseed", Button);
		buttonSeed.onClick = function(e) {
			trace("setseed clicked!!");
			var seed:Null<UInt> = Std.parseInt(input.text);
			if (seed == null) {
				seed = 0;
			}

			fieldData.init(fieldData.cols, fieldData.rows, fieldData.type, seed);
			input.text = '${fieldData.seed}';
			updateWinLoss("");
			updateField();
		}

		var buttonColors:ButtonBar = menu.findComponent("colors", ButtonBar);
		buttonColors.selectedIndex = 1;
		buttonColors.onChange = function(e) {
			trace("colors clicked!!");
			var type:FieldType = switch (buttonColors.selectedIndex) {
				case 0:
					TwoColors;
				case 1:
					ThreeColors;
				case 2:
					FourColors;
				default:
					ThreeColors;
			}
			fieldData.init(fieldData.cols, fieldData.rows, type, fieldData.seed);
			updateWinLoss("");
			updateField();
		}
	}

	function updateField() {
		for (brick in bricks) {
			brick.updateField(fieldData.getFieldAt(brick.col, brick.row));
		}
	}

	function onDown(field:FieldSprite) {
		if (!fieldData.clicked(field.col, field.row)) {
			return;
		}

		updateField();

		if (fieldData.hasWon()) {
			updateWinLoss("VICTORY!");
			return;
		}
		if (fieldData.isGameOver()) {
			updateWinLoss("GAME OVER!");
			return;
		}
	}

	function updateWinLoss(text:String) {
		var label:Label = winLoss.findComponent("winloss", Label);
		label.text = text;
	}
}
