#!/bin/bash
#Author: Clark - clark@lotdf.com
#Compatible with bash version 4.x 

echo -e "Bugfix (B), Chore (C), Delivers (D), Feature (F), None (N)\nType in letter of selection, then press [ENTER]"

read commitType

case "${commitType,,}" in
	"b")	
		echo -e "[BUGFIX] was selected.\n"
		pivotalMessage="[BUGFIX]"
		;;
	"c")	
		echo -e "[CHORE] was selected.\n"
		pivotalMessage="[CHORE]"
		;;
	"d")	
		echo -e "[DELIVERS] was selected.\n"
		echo "Type the Pivotal Tracker ID, then press [ENTER]:"
		read pivotalId
		if [[ "${pivotalId}" != *#* ]]
		then
			pivotalId="#$pivotalId"
		fi
		pivotalMessage="[DELIVERS ${pivotalId}]"
		;;
	"f") 	
		echo -e "[FEATURE] was selected.\n"
		pivotalMessage="[FEATURE]"
		;;
	"n")
		echo -e "None! You're on your own!\n"
		pivotalMessage=" "
		;;
	*) 	
		echo -e "Beep bop boop. Didn't understand your input.\n Aborted!"
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
	
echo -e "\nCommit message preview: \n${commitMsg} \n\nGood to go? (Y/N), then press [ENTER]"

read approved 

if [ "${approved,,}" == "y" ]
then
	git commit -m "${commitMsg}"
else
	echo "Aborted!"
fi

exit 0