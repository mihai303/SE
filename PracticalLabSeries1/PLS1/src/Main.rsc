module Main

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import Common;
import Volume;
import SIGReport;
import UnitSize;
import SIGRank;
import Complexity;
import Duplication;
import util::Benchmark;

/*
 * Module Purpose: The Main module is used to define the main logic of the application
 */

// Create M3 models for each project
//M3 PlayModel = createM3FromEclipseProject(|project://Play|);
M3 SmallSql = createM3FromEclipseProject(|project://smallsql0.21_src|);

/*
 * Purpose: The main function for the application;
 * Return: void;
 */
public void main()
{
	real startTime = realTime() * 1.0;
	ret = getTotalLinesOfCodeInProject(getAllJavaFilesLocation(SmallSql));
	printVolumeReport(ret);
	printUnitSizeReport(unitSizeRiskDistribution(getMethodsInModel(SmallSql)));
	printComplexitySizeReport(complexityRiskDistribution(getMethodsInModel(SmallSql), SmallSql));
	printDuplicationSizeReport(computeDuplication(getDuplicates(getClassesInM3Model(SmallSql))));
	real endTime = realTime() * 1.0;
	println("Execution time : <(endTime - startTime) / 1000> seconds");
}