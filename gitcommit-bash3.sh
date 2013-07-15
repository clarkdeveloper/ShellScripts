#!/bin/bash
#Author: Clark - clark@lotdf.com
#Compatible with Bash 3.x

if [[ ${1} == '' ]] 
then
	echo "\n*** Choose wisely.\n**\n* Bugfix (B), Chore (C), Delivers (D), Feature (F), None (N)\n**\n***\nType letter (case-insensitive) of selection, then press [ENTER]\nNote: Type letters with no spaces for more than one."

	read commitType
else 
	commitType=${1}
fi

commitType=`echo ${commitType} | awk '{print tolower($0)}'`

pivotalMessage=""

function pivotalTrackerId() {
	echo "Add the Pivotal Tracker ID or leave blank, then press [Enter]"
	read pivotalId
	if [[ ${#pivotalId} == 0 ]]
	then 
		pivotalId=''
		return 0
	fi
	if [[ "${pivotalId}" != *#* ]]
	then
		pivotalId=" #${pivotalId}"
	else
		pivotalId=" ${pivotalId}" 
	fi
	return 0
}

for (( i = 0; i < ${#commitType}; ++i)); do
    case "${commitType:$i:1}" in
			"b")	
				echo "[BUGFIX] was selected.\n"
				pivotalTrackerId
				pivotalMessage="${pivotalMessage} [BUGFIX${pivotalId}]"
				;;
			"c")	
				echo "[CHORE] was selected.\n"
				pivotalTrackerId
				pivotalMessage="${pivotalMessage} [CHORE$pivotalId]"
				;;
			"d")	
				echo "[DELIVERS] was selected.\n"
				pivotalTrackerId
				pivotalMessage="${pivotalMessage} [DELIVERS${pivotalId}]"
				;;
			"f") 	
				echo "[FEATURE] was selected.\n"
				pivotalTrackerId
				pivotalMessage="${pivotalMessage} [FEATURE${pivotalId}]"
				;;
			"n")
				echo "None! You're on your own!\n"
				;;
			*) 	
				echo "Beep bop boop. Didn't understand your input: ${commitType:$i:1}\n Acceptable input: b c d f n\n  Aborting!"
				exit 0
				;;
		esac 
done

echo ${pivotalMessage}


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