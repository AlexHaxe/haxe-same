package;

import data.FieldDataTest;
import utest.ITest;
import utest.Runner;
import utest.ui.text.DiagnosticsReport;

class TestMain {
	static function main() {
		var tests:Array<ITest> = [new FieldDataTest(),];
		var runner:Runner = new Runner();

		#if instrument
		runner.onComplete.add(_ -> {
			instrument.coverage.Coverage.endCoverage();
		});
		#end

		new DiagnosticsReport(runner);
		for (test in tests) {
			runner.addCase(test);
		}
		runner.run();
	}
}
