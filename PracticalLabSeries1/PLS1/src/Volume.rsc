module Volume

import Prelude;

/*
 * This module contais the functionality for the Volume characteristic
 */
 
 /*
  *	Purpose: Compute the number of lines that contain code and the number of line that have comments;
  *          A a single java file location is processed;
  * Return: A map between a string and an integer;
  */
public map[str, int] getTotalLinesOfCodeInFile(loc file)
{
	int linesWithCode     = 0;	
	int linesWithComments = 0;
	
	for (line <- readFileLines(file))
	{
		/*
			TODO - Process each line - remve whitespace
			Divide by totalLinesWithCode and totalLinesWithComments
		*/
		linesWithCode += 1;
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