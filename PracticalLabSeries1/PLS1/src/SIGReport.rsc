module SIGReport

import Volume;
import IO;

private str computeVolumeSIG(int linesOfCode)
{
	str ret;
	if (linesOfCode >= 0 && linesOfCode <= 65999)
	{
		ret = "++";
	}
	else
	if (linesOfCode >= 66000 && linesOfCode <= 245999)
	{
		ret = "+";
	}
	else
	if (linesOfCode >= 246000 && linesOfCode <= 664999)
	{
		ret = "o";
	}
	else
	if (linesOfCode >= 665000 && linesOfCode <= 1310000)
	{
		ret = "-";
	}
	else
	if (linesOfCode > 1301000)
	{
		ret = "--";
	}
	
	return ret;
}

public void printVolumeReport(map[str, int] results)
{
	println("-------------------------------");
	println("SIG Volume Score    : <computeVolumeSIG(results["LinesWithCode"])>");
	println("Lines of Code       : <results["LinesWithCode"]>");
	println("Lines with comments : <results["LinesWithComments"]>");
	println("-------------------------------");
}