module Duplication

import IO;
import Prelude;
import Common;
import util::Math;

private str getMd5Hash(list[str] lines)
{
	writeFile(|project://PLS1/src/buffer|,lines);
	return md5HashFile(|project://PLS1/src/buffer|);
}

public list[str] getDuplicates(list[loc] classesLocation)
{
	/*
	map [str, str] results = ("retStr"    : "",
	        	              "openMultilineComment" : "false");
	*/
	        	              
	list[str] lines = [];
	list[str] hashes = [];
	int totalLinesOfCode = 0;
	for (location <- classesLocation)
	{
		for (line <-  readFileLines(location))
		{
			if (!isEmptyLine(line))
			{
				totalLinesOfCode += 1;
				// Maybe remove comments - results = removeComments(line,results["openMultilineComment"]);
				lines += trim(line);
				
				if ( size(lines) == 6)
				{
					hashes += getMd5Hash(lines);
					lines = lines[1..size(lines)];	
				}				
			}
		}
	}
	hashes = toString(totalLinesOfCode) + hashes;
	return hashes;
}

public void computeDupplication(list[str] hashes)
{
	int totalLinesOfCode = toInt(hashes[0]);
	hashes = hashes[1..size(hashes)];
	iprintln(hashes);
	list[list[int]] indexes = [[]];
	linesOfDuplicatedCode = 0;
	for (element <- hashes)
	{
		list[int] tmpList = [];
		for (i <- [0..size(hashes)])
		{
			if ( element == hashes[i])
				tmpList += i;
		}
		
		if (size(tmpList) > 1 && tmpList notin indexes)
			indexes += [tmpList];
	}
	indexes = indexes[1..size(indexes)];
	iprintln(indexes);
	for (i <- [0..size(indexes)])
	{
		if (i == 0)
		{
			linesOfDuplicatedCode += ( size(indexes[0]) - 1) * 6;
		}
		else
		{
			list[int] tmpList = [];
			for (j <- indexes[i])
			{
				if ( (j-1) in indexes[i-1] )
				{
					tmpList += 1;
				}
				else
				{
					linesOfDuplicatedCode += 6;
				}
			}
			linesOfDuplicatedCode += size(tmpList) - 1;
		}
	}
	
	iprintln( (linesOfDuplicatedCode * 100.0) / totalLinesOfCode);
}