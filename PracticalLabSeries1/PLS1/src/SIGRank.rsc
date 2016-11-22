module SIGRank
/*
* Purpose: Compute what percent of the lines of code fall within the threasholds
* Return: The SIG Rank
*/
public int unitSizeSIGRank(map[str, real] riskDistibution)
{
	rankDistribution =
	(
		5: ("very-high": 0.0,
		    "high":      0.0,
		    "moderate":  25.0),
		4: ("very-high": 0.0,
		    "high":      5.0,
		    "moderate":  30.0),
		3: ("very-high": 0.0,
		    "high":      10.0,
		    "moderate":  40.0),
		2: ("very-high": 5.0,
		    "high":      15.0,
		    "moderate":  50.0)
	);	
	int rank = 1;
	
	for (i <- [5,4,3,2])
	{
		if (riskDistibution["very-high"] <= rankDistribution[i]["very-high"] &&
	        riskDistibution["high"] <= rankDistribution[i]["high"] &&
	        riskDistibution["moderate"] <= rankDistribution[i]["moderate"])
		{
			rank = i;
			break;
		}	
	}
	
	return rank;
}

/*
* Purpose: Compute what percent of the lines of code fall within the threasholds
* Returns: The SIG Rank
*/
public int complexitySIGRank(map[str, real] riskDistibution)
{
	rankDistribution =
	(
		5: ("very-high": 0.0,
		    "high":      0.0,
		    "moderate":  25.0),
		4: ("very-high": 0.0,
		    "high":      5.0,
		    "moderate":  30.0),
		3: ("very-high": 0.0,
		    "high":      10.0,
		    "moderate":  40.0),
		2: ("very-high": 5.0,
		    "high":      15.0,
		    "moderate":  50.0)
	);	
	int rank = 1;
	
	for (i <- [5,4,3,2])
	{
		if (riskDistibution["very-high"] <= rankDistribution[i]["very-high"] &&
	        riskDistibution["high"] <= rankDistribution[i]["high"] &&
	        riskDistibution["moderate"] <= rankDistribution[i]["moderate"])
		{
			rank = i;
			break;
		}	
	}
	
	return rank;
}

/*
* Purpose: Compute the percent of the lines of code fall within the threasholds
* Returns: The SIG Rank 
*/

public int computeVolumeSIG(int linesOfCode)
{
	int fiveStarRiskMin   = 0;
	int fiveStarRiskMax   = 65999;
	int fourStarRiskMin   = 66000;
	int fourStarRiskMax   = 245999;
	int threeStarRiskMin  = 246000;
	int threeStarRiskMax  = 664999;
	int twoStarRiskMin    = 665000;
	int twoStarRiskMax    = 1310000;
	
	int ret = 0;
	
	if (linesOfCode >= fiveStarRiskMin && linesOfCode <= fiveStarRiskMax)
	{
		ret = 5;
	}
	else
	if (linesOfCode >= fourStarRiskMin && linesOfCode <= fourStarRiskMax)
	{
		ret = 4;
	}
	else
	if (linesOfCode >= threeStarRiskMin && linesOfCode <= threeStarRiskMax)
	{
		ret = 3;
	}
	else
	if (linesOfCode >= twoStarRiskMin && linesOfCode <= twoStarRiskMax)
	{
		ret = 2;
	}
	else
	if (linesOfCode > twoStarRiskMax)
	{
		ret = 1;
	}
	
	
	return ret;
}

/*
* Purpose: Computes the SIG rank for the duplication metric
* Returns: The SIG Rank
*/
public int duplicationSIGRank(real duplicationPercentage)
{
	real fiveStarRiskMin   = 0.0;
	real fiveStarRiskMax   = 3.0;
	real fourStarRiskMin   = 3.0;
	real fourStarRiskMax   = 5.0;
	real threeStarRiskMin  = 5.0;
	real threeStarRiskMax  = 10.0;
	real twoStarRiskMin    = 10.0;
	real twoStarRiskMax    = 20.0;
	
	int ret = 0;
	
	if (duplicationPercentage >= fiveStarRiskMin && duplicationPercentage <= fiveStarRiskMax)
	{
		ret = 5;
	}
	else
	if (duplicationPercentage > fourStarRiskMin && duplicationPercentage <= fourStarRiskMax)
	{
		ret = 4;
	}
	else
	if (duplicationPercentage > threeStarRiskMin && duplicationPercentage <= threeStarRiskMax)
	{
		ret = 3;
	}
	else
	if (duplicationPercentage > twoStarRiskMin && duplicationPercentage <= twoStarRiskMax)
	{
		ret = 2;
	}
	else
	if (duplicationPercentage > twoStarRiskMax)
	{
		ret = 1;
	}
	
	return ret;
}