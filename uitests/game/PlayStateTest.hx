package game;

import haxeium.Actions;
import haxeium.Wait;
import haxeium.test.TestBaseAllRestarts;

class PlayStateTest extends TestBaseAllRestarts {
	public function testSolve_12345() {
		Wait.untilElementBecomesVisible(ById("seed"));

		var seed = driver.findElement(ById("seed"));
		new Actions().doubleClick(seed).pause(0.2).sendKeys("12345").perform();
		Wait.untilPropertyEqualsValue(seed.locator, "text", "12345");

		var button = driver.findElement(ById("setseed"));
		button.click();
		Sys.sleep(0.02);

		clickField(11, 1);
		clickField(12, 1);
		clickField(12, 3);
		clickField(12, 4);
		clickField(14, 6);
		clickField(13, 7);
		clickField(12, 7);
		clickField(10, 7);
		clickField(10, 8);
		clickField(11, 8);
		clickField(12, 10);
		clickField(12, 10);
		clickField(8, 8);
		clickField(8, 7);
		clickField(7, 8);
		clickField(7, 8);
		clickField(4, 4);
		clickField(1, 4);
		clickField(3, 6);
		clickField(3, 8);
		clickField(3, 10);
		clickField(2, 7);
		clickField(6, 10);
		clickField(4, 10);
		clickField(0, 8);
		clickField(1, 9);

		var winLossLabel = driver.findElement(ById("winloss"));
		equals("VICTORY!", winLossLabel.text);
	}

	public function testFail_12345() {
		Wait.untilElementBecomesVisible(ById("seed"));

		var seed = driver.findElement(ById("seed"));
		new Actions().doubleClick(seed).pause(0.2).sendKeys("12345").perform();
		Wait.untilPropertyEqualsValue(seed.locator, "text", "12345");

		var button = driver.findElement(ById("setseed"));
		button.click();
		Sys.sleep(0.02);
		clickField(13, 1);
		clickField(13, 2);
		clickField(12, 4);
		clickField(14, 6);
		clickField(13, 7);
		clickField(12, 8);
		clickField(13, 9);
		clickField(12, 10);
		clickField(11, 9);
		clickField(10, 10);
		clickField(10, 10);
		clickField(9, 9);
		clickField(9, 9);
		clickField(7, 10);
		clickField(5, 6);
		clickField(3, 4);
		clickField(1, 2);
		clickField(0, 2);
		clickField(4, 6);
		clickField(3, 8);
		clickField(7, 9);
		clickField(7, 9);
		clickField(6, 10);
		clickField(5, 10);
		clickField(2, 9);
		clickField(0, 7);
		clickField(0, 8);
		clickField(1, 10);

		var winLossLabel = driver.findElement(ById("winloss"));
		equals("GAME OVER!", winLossLabel.text);
	}

	public function testUndo_Solve_12345() {
		Wait.untilElementBecomesVisible(ById("seed"));

		var seed = driver.findElement(ById("seed"));
		new Actions().doubleClick(seed).pause(0.2).sendKeys("12345").perform();
		Wait.untilPropertyEqualsValue(seed.locator, "text", "12345");

		var button = driver.findElement(ById("setseed"));
		button.click();
		Sys.sleep(0.02);

		clickField(11, 1);
		clickField(12, 1);
		clickField(12, 3);
		clickField(12, 4);
		clickField(14, 6);
		clickField(13, 7);
		clickField(12, 7);
		clickField(10, 7);
		clickField(10, 8);
		clickField(11, 8);
		clickField(12, 10);
		clickField(12, 10);
		clickField(8, 8);
		clickField(8, 7);
		clickField(7, 8);
		clickField(7, 8);
		clickField(4, 4);
		clickField(1, 4);
		clickField(3, 6);
		clickField(3, 8);
		clickField(3, 10);
		clickField(2, 7);
		clickField(6, 10);
		clickField(4, 10);
		clickField(0, 8);
		clickField(1, 9);

		var winLossLabel = driver.findElement(ById("winloss"));
		equals("VICTORY!", winLossLabel.text);

		var button = driver.findElement(ById("undo"));
		button.click();
		Sys.sleep(0.02);

		winLossLabel = driver.findElement(ById("winloss"));
		equals("", winLossLabel.text);
	}

	function clickField(col:Int, row:Int) {
		var flx = driver.findElement(ByPath(["flixel.group.FlxTypedGroup-1", 'game.FieldSprite-${col + row * 15}']));
		flx.click();
		Sys.sleep(0.02);
	}
}
