import haxe.Timer;
import haxe.ui.Toolkit;
import flixel.FlxGame;
import game.PlayState;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		Toolkit.init();
		addChild(new FlxGame(420, 240, PlayState, true));

		#if uitests
		new haxeium.drivers.FlixelHaxeUIDriver("ws://127.0.0.1:9999");
		#end
	}
}
