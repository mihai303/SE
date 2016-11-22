module SIGReport

import Volume;
import IO;
import SIGRank;

/*
* This module stores the report pretty printing methods.
*/

public void printVolumeReport(map[str, int] results)
{
	println("-------------------------------");
	println("SIG Volume Score    : <computeVolumeSIG(results["LinesWithCode"])> stars");
	println("Lines of Code       : <results["LinesWithCode"]>");
	println("Lines with comments : <results["LinesWithComments"]>");
	println("-------------------------------");
}

public void printUnitSizeReport(map[str, real] results)
{
	println("-------------------------------");
	println("SIG UnitScore Score    : <unitSizeSIGRank(results)> stars");
	println("Very-High: <results["very-high"]> %");
	println("High: <results["high"]> %");
	println("Moderate: <results["moderate"]> %");
	println("Low: <results["low"]> %");
	println("-------------------------------");
}

public void printComplexitySizeReport(map[str, real] results)
{
	println("-------------------------------");
	println("SIG Complexity Score    : <complexitySIGRank(results)> stars");
	println("Very-High: <results["very-high"]> %");
	println("High: <results["high"]> %");
	println("Moderate: <results["moderate"]> %");
	println("Low: <results["low"]> %");
	println("-------------------------------");
}

public void printDuplicationSizeReport(real result)
{
	println("-------------------------------");
	println("SIG Complexity Score    : <duplicationSIGRank(result)> stars");
	println("Percentage of duplicated lines  : <result> %");
	println("-------------------------------");
}