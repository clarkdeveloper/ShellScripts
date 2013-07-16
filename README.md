ShellScripts
============

A collection of helpful shell scripts. 


##pivcommit (git commit with some pivotal tracker goodness)

###Versions

pivcommit-osx: Works with bash 3.x; Specific to OS X

####Requirements

HomeBrew coreutils - in particular greadlink

pivcommit-bash4: Works with bash 4.x

###Usage

Setup an alias e.g. pivcommit to execute shell script

pivcommit 

or

pivcommit [options]

Valid options: b c d f n 

b: bugfix
c: chore
d: delivers
f: feature
n: none

Options can be used as many times as needed for the commit.

e.g. pivcommit bbd 
	
	Produces: [BUGFIX] [BUGFIX] [DELIVERS]

Each option will prompt for a Pivotal Tracker ID. This is optional and can be left empty.

The hash in the Pivotal Tracker ID will be included automatically if it doesn't exist.

e.g. 12345

	Produces: #12345