module Main

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

M3 model = createM3FromEclipseProject(|project://Play|);

public int returnNrMethods(M3 m)
{
	
}

public M3 retM3() {
	return model;
}