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

/* Tests the number of lines of code and comment is a test java file */

test bool testFile1() 
= getTotalLinesOfCodeInProject(getSingleJavaFileLocation(PlayModel,"CommentTest.java"),false)
== ("LinesWithCode": 370, "LinesWithComments": 36);

/* Tests for removeComments */

test bool removeCommentTest1()
= removeComments("code // comment","false")
== ("retStr": "code ",
    "openMultilineComment" : "false",
    "increaseCommentCount" : "true");

test bool removeCommentTest2()
= removeComments("// comment","false")
== ("retStr": "",
    "openMultilineComment" : "false",
    "increaseCommentCount" : "true");
    
test bool removeCommentTest3()
= removeComments("code /* comment */","false")
== ("retStr": "code ",
    "openMultilineComment" : "false",
    "increaseCommentCount" : "true");
    
test bool removeCommentTest4()
= removeComments("code /* comment","false")
== ("retStr": "code ",
    "openMultilineComment" : "true",
    "increaseCommentCount" : "true");
    
test bool removeCommentTest5()
= removeComments("System.out.println(\" bad comment end */\")","true")
== ("retStr": "",
    "openMultilineComment" : "true",
    "increaseCommentCount" : "true");
    
test bool removeCommentTest6()
= removeComments("*/ code","true")
== ("retStr": " code",
    "openMultilineComment" : "false",
    "increaseCommentCount" : "true");

test bool removeCommentTest7()
= removeComments("code","false")
== ("retStr": "code",
    "openMultilineComment" : "false",
    "increaseCommentCount" : "false");
    
/* Test for isEmpty() */

//test bool isEmptyTest1() = isEmptyLine("   ") == true;
//test bool isEmptyTest2() = isEmptyLine("code") == false;