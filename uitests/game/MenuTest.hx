package game;

import haxeium.Actions;
import haxeium.Wait;
import haxeium.test.TestBaseAllRestarts;
import haxeium.test.TestBaseOneInstance;

class MenuTest extends TestBaseAllRestarts {
	public function testNewGameSeed() {
		Wait.untilElementBecomesVisible(ById("seed"));
		var seed = driver.findElement(ById("seed"));
		var oldSeed:String = seed.text;

		var button = driver.findElement(ById("newgame"));
		equals("New Game", button.text);
		button.click();
		Sys.sleep(0.05);

		var newSeed = seed.text;
		notEquals(oldSeed, newSeed);

		button.click();
		Sys.sleep(0.05);
		var newSeed2 = seed.text;
		notEquals(oldSeed, newSeed2);
		notEquals(newSeed, newSeed2);
	}

	public function testSeedRestart() {
		Wait.untilElementBecomesVisible(ById("seed"));
		var seed = driver.findElement(ById("seed"));
		var oldSeed:String = seed.text;

		var button = driver.findElement(ById("restart"));
		equals("Restart", button.text);
		button.click();
		Sys.sleep(0.05);

		equals(oldSeed, seed.text);
	}

	public function testSetSeed() {
		Wait.untilElementBecomesVisible(ById("seed"));

		var seed = driver.findElement(ById("seed"));
		new Actions().doubleClick(seed).pause(0.2).sendKeys("12345").perform();

		Wait.untilPropertyEqualsValue(seed.locator, "text", "12345");

		var button = driver.findElement(ById("setseed"));
		equals("Set Seed", button.text);
		button.click();
		equals("12345", seed.text);

		var buttonBar = driver.findElement(ById("colors"));
		equals(1, buttonBar.getProp("selectedIndex"));
		buttonBar.setProp("selectedIndex", 1);
		equals("12345", seed.text);
		buttonBar.setProp("selectedIndex", 2);
		equals("12345", seed.text);
		buttonBar.setProp("selectedIndex", 0);
		equals("12345", seed.text);
		buttonBar.setProp("selectedIndex", 1);
		equals("12345", seed.text);
	}
}
