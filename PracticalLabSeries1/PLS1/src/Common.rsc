module Common

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import String;
import IO;
import Prelude;

/*
 * Module Purpose: The Common module stores functionality that is needed by multiple modules
 */

/* Note : classes(model) -> set[loc];
*  Purpose: Get the location of the Java classes in a model;
*  Return: A list of classes locations for Java files;
*/
public list[loc] getClassesInM3Model(M3 model)
{
	return [ location | location <- classes(model) ];
}

/* Note : methods(model) -> set[loc];
*  Purpose: Get the location of the Java methods in a model;
*  Return: A list of method locations for Java files;
*/
public list[loc] getMethodsInModel(M3 model)
{
	return [ location | location <- methods(model)];
}

/* Note : model@declarations -> rel[loc name,loc src];
*  Purpose: Get the location of the Java files using the model declarations;
*  Return: A list of locations for a sigle Java file in the model;
*/
public list[loc] getSingleJavaFileLocation(M3 model, str file)
{
	return 	[ location | <location, source> <- model@declarations,
	          location.scheme == "java+compilationUnit",
	          location.file == file];
}

/* Note : model@declarations -> rel[loc name,loc src];
*  Purpose: Get the location of the Java files using the model declarations;
*  Return: A list of locations for each Java file in the model;
*/
public list[loc] getAllJavaFilesLocation(M3 model)
{
	return 	[ location | <location, source> <- model@declarations, location.scheme == "java+compilationUnit"];
}

/* 
*  Purpose: Determine is a string is empty.
*  Return: a boolean value;
*/
public bool isEmptyLine(str line)
{
	return isEmpty(trim(line));
}

/* 
*  Purpose: Precesses each line and revoes inline and multiline comments;
*  Return: A string to string map containig :
*  		   1. The string without comment
*          2. A string that indicates if a multiline comment was still open on the line
*          3. A string that indicates that comments were present
*  * 
*/
public map[str, str] removeComments(str line, str openMultilineComment)
{
	bool betweenSingleQuotes =  false;
	bool betweenDoubleQuotes =  false;
	bool singleLineComment   =  false;
	bool multiLineComment    =  false;	
	bool skipElement         =  false;
	str increaseCommentCount = "false";
	
	if (openMultilineComment == "true")
	{
		multiLineComment = true;
		increaseCommentCount = "true";
	}
	
	str retStr = "";
	str prevElement = "";
	int len = size(line);
	
	for (i <- [0..len])
	{
		if (line[i] == "\'" && betweenSingleQuotes == false)
		{		
			betweenSingleQuotes = true;
		}
		else
		if ((line[i] == "\'" && betweenSingleQuotes == true))
		{
			betweenSingleQuotes = false;
		}
		
		if (line[i] == "\"" && betweenDoubleQuotes == false)
		{		
			betweenDoubleQuotes = true;
		}
		else
		if (line[i] == "\"" && betweenDoubleQuotes == true)
		{
			betweenDoubleQuotes = false;
		}
		
		if (!betweenSingleQuotes && !betweenDoubleQuotes)
		{
			if (prevElement != "")
			{
				if (prevElement == "/" && line[i] == "/")
				{
					singleLineComment = true;
					increaseCommentCount = "true";
					retStr = replaceLast(retStr, "/", "");
				}
				
				if (prevElement == "/" && line[i] == "*")
				{
					multiLineComment = true;
					increaseCommentCount = "true";
					retStr = replaceLast(retStr, "/", "");
				}
				else
				if (prevElement == "*" && line[i] == "/")
				{
					multiLineComment = false;
					skipElement = true;
				}
			}
		}
		
		if (!singleLineComment && !multiLineComment)
		{
			if (skipElement)
			{
				skipElement = false;
			}
			else
			{
				retStr += line[i];
			}
		}				
		
		prevElement = line[i];
	}
	
	if (multiLineComment){ openMultilineComment = "true"; } else { openMultilineComment = "false"; }
	
	return ("retStr"               : retStr,
	        "openMultilineComment" : openMultilineComment,
	        "increaseCommentCount" : increaseCommentCount);

}