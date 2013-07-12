ShellScripts
============

A collection of helpful shell scripts. 


##gitcommit 

###Usage

Setup an alias e.g. gcommit

gcommit 

or

gcommit [options]

Valid options: b c d f n 

b: bugfix
c: chore
d: delivers
f: feature
n: none

Options can be used as many times as needed for the commit.

e.g. gcommit bbd 
	
	Produces: [BUGFIX] [BUGFIX] [DELIVERS]

Each option will prompt for a Pivotal Tracker ID. This is optional and can be left empty.

The hash in the Pivotal Tracker ID will be included automatically if it doesn't exist.

e.g. 12345

	Produces: #12345