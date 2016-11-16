module UnitSize
import Volume;
import Prelude;
import IO;

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

private int lowRiskMin      = 1;
private int lowRiskMax      = 10;
private int moderateRiskMin = 11;
private int moderateRiskMax = 20;
private int highRiskMin     = 21;
private int highRiskMax     = 50;
private int veryHighRiskMin = 51;

public map[str, real] unitSizeRiskDistribution(list[loc] locations)
{
	results = ("veryHighRisk": 0,
	           "highRisk": 0,
	           "moderateRisk": 0,
	           "lowRisk": 0,
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
	
	return ("veryHigh"     : results["veryHighRisk"] * 100.0 / results["totalLinesOfCode"],
			"highRisk"     : results["highRisk"]     * 100.0 / results["totalLinesOfCode"],
			"moderateRisk" : results["moderateRisk"] * 100.0 / results["totalLinesOfCode"],
			"lowRisk"      : results["lowRisk"]      * 100.0 / results["totalLinesOfCode"]);
}

private int getMethodLinesOfCode(loc method)
{
	return getTotalLinesOfCodeInFile(method)["LinesWithCode"];
}

private str unitSizeRiskLevel(int linesOfCode)
{
	if (linesOfCode >= lowRiskMin && linesOfCode <= lowRiskMax)
	{
		return "lowRisk";
	}
	else
	if (linesOfCode >= moderateRiskMin && linesOfCode <= moderateRiskMax)
	{
		return "moderateRisk";
	}
	else
	if (linesOfCode >= highRiskMin && linesOfCode <= highRiskMax)
	{
		return "highRisk";
	}
	else
	if (linesOfCode >= veryHighRiskMin)
	{
		return "veryHighRisk";
	}
}