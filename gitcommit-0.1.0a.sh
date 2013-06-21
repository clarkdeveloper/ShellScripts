#!/bin/bash
#Author: Clark - clark@lotdf.com
#Ver. 0.1.0a
#Compatible with Bash 3+

echo "Bugfix (B), Chore (C), Delivers (D), Feature (F), None (N)\nType in letter of selection, then press [ENTER]"

read commitType
commitType=`echo ${commitType} | awk '{print tolower($0)}'`

case "${commitType}" in
	"b")	
		echo "[BUGFIX] was selected.\n"
		pivotalMessage="[BUGFIX]"
		;;
	"c")	
		echo "[CHORE] was selected.\n"
		pivotalMessage="[CHORE]"
		;;
	"d")	
		echo "[DELIVERS] was selected.\n"
		echo "Type the Pivotal Tracker ID, then press [ENTER]:"
		read pivotalId
		if [[ "${pivotalId}" != *#* ]]
		then
			pivotalId="#$pivotalId"
		fi
		pivotalMessage="[DELIVERS ${pivotalId}]"
		;;
	"f") 	
		echo "[FEATURE] was selected.\n"
		pivotalMessage="[FEATURE]"
		;;
	"n")
		echo "None! You're on your own!\n"
		pivotalMessage=" "
		;;
	*) 	
		echo "Beep bop boop. Didn't understand your input.\n Aborted!"
		exit 0
		;;
esac

echo "Type commit message, then press [ENTER]:"

read commitComment

if [ "${pivotalMessage}" != " " ]
then
	commitMsg="${pivotalMessage} ${commitComment}"
else
	commitMsg="${commitComment}"
fi
	
echo "\nCommit message preview: \n${commitMsg} \n\nGood to go? (Y/N), then press [ENTER]"

read approved 
approved=`echo ${approved} | awk '{print tolower($0)}'`

if [ "${approved}" == "y" ]
then
	git commit -m "${commitMsg}"
else
	echo "Aborted!"
fi

exit 0