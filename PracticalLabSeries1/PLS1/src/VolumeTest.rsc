module VolumeTest

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import Common;
import Volume;

/*
 * This module contais the test cases for the Volume characteristic
 */
 
M3 PlayModel = createM3FromEclipseProject(|project://Play|);

/* Tests for Files */

test bool testFile1() 
= getTotalLinesOfCodeInProject(getSingleJavaFileLocation(PlayModel,"main.java"))
== ("LinesWithCode": 370, "LinesWithComments": 36);

/* Tests for removeComments */

test bool removeComment1()
= removeComments("code // comment","false")
== ("retStr": "code ",
    "openMultilineComment" : "false",
    "increaseCommentCount" : "true");

//TODO - Add more tests