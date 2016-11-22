module Volume
import Common;
import Prelude;

/*
 * This module contais the functionality for the Volume characteristic
 */
 
 /*
  *	Purpose: Compute the number of lines that contain code and the number of line that have comments;
  *          A a single java file location is processed;
  * Return:  A map between a string and an integer;
  */
public map[str, int] getTotalLinesOfCodeInFile(loc file)
{
	int linesWithCode     = 0;	
	int linesWithComments = 0;
	
	map [str, str] results = ("retStr"    : "",
	        	   "openMultilineComment" : "false",
	        	   "increaseCommentCount" : "false");
	        	   
	for (line <- readFileLines(file))
	{
		if (!isEmptyLine(line))
		{
			results = removeComments(line,results["openMultilineComment"]);

			if (!isEmptyLine(results["retStr"]))
				linesWithCode += 1;

			if (results["increaseCommentCount"] == "true")
			{
				linesWithComments += 1;
			}	
		}			
	}
	
	return ("LinesWithCode"     : linesWithCode ,
	        "LinesWithComments" : linesWithComments );
}

 /*
  *	Purpose: Compute the number of lines that contain code and the number of line that have comments;
  *          Multiple java file location are processed;
  * Return: A map between a string and an integer;
  */
public map[str, int] getTotalLinesOfCodeInProject(list[loc] locations)
{
	int linesWithCode = 0;
	int linesWithComments = 0;
	
	for (file <- locations)
	{
		results = getTotalLinesOfCodeInFile(file);
		linesWithCode += results["LinesWithCode"];
		linesWithComments += results["LinesWithComments"];
	}
	
	return ("LinesWithCode"     : linesWithCode,
	        "LinesWithComments" : linesWithComments);
}