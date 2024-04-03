import haxe.ui.Toolkit;
import flixel.FlxGame;
import game.PlayState;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		Toolkit.init();
		Toolkit.scale = 1;
		addChild(new FlxGame(420, 240, PlayState, true));

		#if uitests
		new haxeium.drivers.FlixelHaxeUIDriver("ws://127.0.0.1:9999");
		#end
	}
}
