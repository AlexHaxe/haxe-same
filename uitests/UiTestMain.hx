import game.MenuTest;
import game.PlayStateTest;
import haxeium.AppDriver;
import haxeium.AppRestarter;
import utest.ITest;
import utest.Runner;
import utest.ui.text.DiagnosticsReport;

class UiTestMain {
	static function main() {
		#if html5_ui
		// lime test html5
		var driver = new AppDriver("localhost", 9999, null);
		#end

		#if linux_ui
		// lime build linux
		new AppDriver("localhost", 9999, new AppRestarter("./hxSame", [], "export/linux/bin"));
		#end

		#if hl_ui
		// lime build hl
		new AppDriver("localhost", 9999, new AppRestarter("./hxSame", [], "export/hl/bin"));
		#end

		#if windows_ui
		// lime build windows
		new AppDriver("localhost", 9999, new AppRestarter("./hxSame.exe", [], "export/windows/bin"));
		#end

		var tests:Array<ITest> = [new MenuTest(), new PlayStateTest()];
		var runner:Runner = new Runner();

		new DiagnosticsReport(runner);
		for (test in tests) {
			runner.addCase(test);
		}
		runner.run();
	}
}
