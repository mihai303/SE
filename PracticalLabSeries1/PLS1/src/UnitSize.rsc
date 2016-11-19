module UnitSize
import Volume;
import Prelude;
import IO;

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

private int lowRiskMin      = 1;
private int lowRiskMax      = 15;
private int moderateRiskMin = 16;
private int moderateRiskMax = 30;
private int highRiskMin     = 31;
private int highRiskMax     = 60;
private int veryHighRiskMin = 61;

public map[str, real] unitSizeRiskDistribution(list[loc] locations)
{
	results = ("very-high": 0,
	           "high": 0,
	           "moderate": 0,
	           "low": 0,
	           "totalLinesOfCode": 0);
	           		
	for (location <- locations)
	{
		linesOfCode = getMethodLinesOfCode(location);
		results[unitSizeRiskLevel(linesOfCode)] += linesOfCode;
		results["totalLinesOfCode"] += linesOfCode;
	}
	iprintln(results);
	return unitSizeAggregationByRank(results);
}

public map[str, real] unitSizeAggregationByRank (map[str, int] results)
{
	
	return ("very-high" : results["very-high"] * 100.0 / results["totalLinesOfCode"],
			"high"      : results["high"]      * 100.0 / results["totalLinesOfCode"],
			"moderate"  : results["moderate"]  * 100.0 / results["totalLinesOfCode"],
			"low"       : results["low"]       * 100.0 / results["totalLinesOfCode"]);
}

private int getMethodLinesOfCode(loc method)
{
	return getTotalLinesOfCodeInFile(method)["LinesWithCode"];
}

private str unitSizeRiskLevel(int linesOfCode)
{
	if (linesOfCode >= lowRiskMin && linesOfCode <= lowRiskMax)
	{
		return "low";
	}
	else
	if (linesOfCode >= moderateRiskMin && linesOfCode <= moderateRiskMax)
	{
		return "moderate";
	}
	else
	if (linesOfCode >= highRiskMin && linesOfCode <= highRiskMax)
	{
		return "high";
	}
	else
	if (linesOfCode >= veryHighRiskMin)
	{
		return "very-high";
	}
}