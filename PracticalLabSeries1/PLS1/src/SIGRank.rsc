module SIGRank

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