module Main

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import Common;
import Volume;

/*
 * Module Purpose: The Main module is used to define the main logic of the application
 */

// Create M3 models for each project
M3 model = createM3FromEclipseProject(|project://Play|);

/*
 * Purpose: The main function for the application;
 * Return: void;
 */
public void main()
{
	ret = getTotalLinesOfCodeInProject(getAllJavaFilesLocation(model));
	println("Lines with code :: <ret["LinesWithCode"]>");
	println("Lines with comments :: <ret["LinesWithComments"]>");
}