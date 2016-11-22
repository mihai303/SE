module Complexity

import Common;
import IO;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import UnitSize;

private int lowRiskMin      = 1;
private int lowRiskMax      = 10;
private int moderateRiskMin = 11;
private int moderateRiskMax = 20;
private int highRiskMin     = 21;
private int highRiskMax     = 50;
private int veryHighRiskMin = 51;


/*
* Purpose: Compute the complexity risk distribution risk levels for the methods in relation to a model.
* Returns: A map of the risk distribution.
*/
public map[str, real] complexityRiskDistribution(list[loc] locations, M3 model)
{
	results = ("very-high": 0,
	           "high": 0,
	           "moderate": 0,
	           "low": 0,
	           "totalLinesOfCode": 0);
	           
	for (location <- locations)
	{
		Declaration methodAST = getMethodASTEclipse(location, model=model);
		int complexity = computeComplexity(methodAST);
		int linesOfCode = getMethodLinesOfCode(location);
		results[complexityRiskLevel(complexity)] += linesOfCode;
		results["totalLinesOfCode"] += linesOfCode;
	}
	
	return complexityAggregationByRank(results);
}
/*
* Purpose: Compute the aggregation by rank
**/
public map[str, real] complexityAggregationByRank (map[str, int] results)
{
	
	return ("very-high" : results["very-high"] * 100.0 / results["totalLinesOfCode"],
			    "high"      : results["high"]      * 100.0 / results["totalLinesOfCode"],
			    "moderate"  : results["moderate"]  * 100.0 / results["totalLinesOfCode"],
			    "low"       : results["low"]       * 100.0 / results["totalLinesOfCode"]);
}

/*
* Purpose: Generate a string of the risk level based on complexity
**/
private str complexityRiskLevel(int complexity)
{
	if (complexity >= lowRiskMin && complexity <= lowRiskMax)
	{
		return "low";
	}
	else
	if (complexity >= moderateRiskMin && complexity <= moderateRiskMax)
	{
		return "moderate";
	}
	else
	if (complexity >= highRiskMin && complexity <= highRiskMax)
	{
		return "high";
	}
	else
	if (complexity >= veryHighRiskMin)
	{
		return "very-high";
	}
}

/*
*
* As defined here http://stackoverflow.com/questions/40064886/obtaining-cyclomatic-complexity
* Purpose: Computes the cyclomactic complexity for a method.
*/
int computeComplexity(Declaration  impl) {
    int result = 1;
    visit (impl) {
        case \if(_,_) : result += 1;
        case \if(_,_,_) : result += 1;
        case \case(_) : result += 1;
        case \do(_,_) : result += 1;
        case \while(_,_) : result += 1;
        case \for(_,_,_) : result += 1;
        case \for(_,_,_,_) : result += 1;
        case foreach(_,_,_) : result += 1;
        case \catch(_,_): result += 1;
        case \conditional(_,_,_): result += 1;
        case infix(_,"&&",_) : result += 1;
        case infix(_,"||",_) : result += 1;
    }
    return result;
}