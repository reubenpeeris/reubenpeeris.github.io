---
title: Lombok Eclipse Compiler 4 Maven (lec4m)
subtitle: An implementation of the maven compiler API that uses the eclipse (JDT) compiler and can process Lombok files
includes: [lightbox]
---
## Introduction ##
It is common when developing code using maven and eclipse, for the compilers used in the eclipse to be different to the compiler used by the build script. The eclipse will be using the JDT compiler while the build script will be using the JDK (javac) compiler. I have encountered several problems when doing this:
* If the build script has a zero tolerance on compiler warnings, a passing build may still produce warnings in the IDE.
* Differences between the two compilers can sometimes hinder debugging problems.
* Bugs in the JDK compiler can cause code that works in the eclipse to fail in automated builds.

The JDT compiler can produce warnings or errors for more types of problem than the JDK compiler can. These warning ca be helpful in avoiding bugs. For each of the [>60 types of problem](https://help.eclipse.org/mars/index.jsp?topic=%2Forg.eclipse.jdt.doc.user%2Freference%2Fpreferences%2Fjava%2Fcompiler%2Fref-preferences-errors-warnings.htm) the compiler can be set to ignore, warning or error. For this reason I prefer to use the JDT compile even though it is a little slower than the JDK compiler.

To configure maven to use a different compiler, and implementation of the [maven compiler API](https://github.com/sonatype/plexus-compiler/blob/master/plexus-compiler-api/src/main/java/org/codehaus/plexus/compiler/AbstractCompiler.java) is used. There is an existing implementation that uses the JDT compiler, but it has several limitations:
* will not compile java files containing Lombok annotations
* is updated infrequently
* by default will not use the problem settings configured in eclipse

The Lombok Eclipse Compiler 4 Maven (lec4m) solves these problems.

## Setup ##
These setup instructions briefly explains how to use lec4m. It assumes you already have a basic knowledge of Eclipse, maven and Lombok.

### IDE setup ###
+ Download/install eclipse, e.g. from the [eclipse download page](https://www.eclipse.org/downloads/)
+ Add Lombok to the eclipse installation, the [projectlombok](https://projectlombok.org/setup/eclipse) website explains how 

### POM file ###



## lec4m version numbering ##
In order for your build script to use the same version of the JDT compiler that your IDE uses, choose lec4m release with the same version number as the version of eclipse you are using e.g.

| Eclipse Version | Eclipse Version Number | lec4m Version Number |
|-----------------|------------------------|----------------------|
| Mars.2          | 4.5.2                  | 4.5.2                |
| Neon            | 4.6                    | 4.6                  |
| Oxygen          | 4.7                    | 4.7                  |
