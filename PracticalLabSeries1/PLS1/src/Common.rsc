module Common

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

/*
 * Module Purpose: The Common module stores functionality that is needed by multiple modules
 */

/* Note : model@declarations -> rel[loc name,loc src];
*  Purpose: Get the location of the Java files using the model declarations;
*  Return: A list of locations for each Java file in the model;
*/
public list[loc] getAllJavaFilesLocation(M3 model)
{
	return 	[ location | <location, source> <- model@declarations, location.scheme == "java+compilationUnit"];
}