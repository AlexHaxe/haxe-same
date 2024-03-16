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

		clickField(11, 2);
		clickField(12, 3);
		clickField(13, 4);
		clickField(12, 6);
		clickField(14, 5);
		clickField(12, 6);
		clickField(13, 6);
		clickField(13, 7);
		clickField(13, 9);
		clickField(11, 9);
		clickField(11, 10);
		clickField(10, 7);
		clickField(9, 5);
		clickField(9, 5);
		clickField(1, 4);
		clickField(1, 5);
		clickField(1, 6);
		clickField(2, 8);
		clickField(3, 9);
		clickField(4, 9);
		clickField(2, 10);
		clickField(3, 10);
		clickField(10, 10);
		clickField(8, 10);
		clickField(1, 10);
		clickField(1, 10);
		clickField(0, 10);
		clickField(0, 10);

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

		clickField(12, 4);
		clickField(10, 4);
		clickField(11, 5);
		clickField(11, 6);
		clickField(12, 8);
		clickField(10, 8);
		clickField(8, 7);
		clickField(8, 10);
		clickField(10, 10);
		clickField(11, 10);
		clickField(11, 10);
		clickField(11, 9);
		clickField(10, 10);
		clickField(10, 10);
		clickField(8, 10);
		clickField(8, 9);
		clickField(6, 9);
		clickField(3, 8);
		clickField(1, 6);
		clickField(1, 7);
		clickField(1, 7);
		clickField(1, 8);
		clickField(1, 10);
		clickField(2, 10);
		clickField(1, 10);
		clickField(0, 8);

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

		clickField(11, 2);
		clickField(12, 3);
		clickField(13, 4);
		clickField(12, 6);
		clickField(14, 5);
		clickField(12, 6);
		clickField(13, 6);
		clickField(13, 7);
		clickField(13, 9);
		clickField(11, 9);
		clickField(11, 10);
		clickField(10, 7);
		clickField(9, 5);
		clickField(9, 5);
		clickField(1, 4);
		clickField(1, 5);
		clickField(1, 6);
		clickField(2, 8);
		clickField(3, 9);
		clickField(4, 9);
		clickField(2, 10);
		clickField(3, 10);
		clickField(10, 10);
		clickField(8, 10);
		clickField(1, 10);
		clickField(1, 10);
		clickField(0, 10);
		clickField(0, 10);

		var winLossLabel = driver.findElement(ById("winloss"));
		equals("VICTORY!", winLossLabel.text);

		var button = driver.findElement(ById("undo"));
		button.click();
		Sys.sleep(0.02);

		equals("", winLossLabel.text);
	}

	function clickField(col:Int, row:Int) {
		var flx = driver.findElement(ByPath(["flixel.group.FlxTypedGroup-1", 'game.FieldSprite-${col + row * 15}']));
		flx.click();
		Sys.sleep(0.02);
	}
}
