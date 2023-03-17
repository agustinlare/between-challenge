GitHub Actions
Develop a GitHub action for a repository containing Python code that does the
following:
• It is executed on every push
• It executes all tests, both in Python 2 and Python 3

You can set up a test repository, use an existing repository like NumPy, or use a fic-
titious repository (i.e. pretend there is a repository). Just send us the configuration file(s).
---
Jenkins
This roughly resembles our integration in Firmware. You have:
• A Git repository containing some code,

• A Subversion repository containing code, a build system (e.g. a set of Make-
files), and a (possibly outdated) copy of the Git code.

Write a Jenkins job (or a script or set of scripts to be executed by Jenkins) to
• Checkout the subversion repository in a temporary directory.
• Clone the Git repository and copy the code into the subversion working copy
in a subdirectory git-code.

• Build (you can just assume make install does it all for example)
• Test (you can assume make test executes all tests)
• If building and testing succeed, push the changes to Git
• Send an email to report on success or failure
• Clean up your temporary files.
---
Python package
You are given three files:
one.h:
1 #pragma once
2 int func();

one.cpp:
1 #include <one.h>
2 int func() {
3 return 1;
4 }

one.i:
1 %module one
2 %{
3 #include <one.h>
4 %}
5 int func();

The last one is a SWIG interface file to automatically generate Python bindings.
The task is to write a script (bash, Makefile, whatever) that does the following:
• Compile the C++ code into a shared library one.so
• Generate SWIG wrapper code for the library for Python using the command swig -python -c++ -I. one.i
• Compile the SWIG wrapper into a Python module _one.so. To compile this, you may want to use python-config --cflags to obtain the compiler flags.
• Bundle everything into a Python package that can be installed using pip.