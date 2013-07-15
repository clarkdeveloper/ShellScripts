#!/bin/bash
#Author: Clark - clark@lotdf.com
#Compatible with Bash 3.x

#Check for config; setup if not present
configFile='gitcommit.cfg'
commitMessageFile='gitcommit-message.txt'
if [ ! -e ${configFile} ] || [ ${1} == 'config' ]
then
	echo '\n***\n**\n* Hello. Quick setup required before using!\n**\n***\n'
	touch ${configFile}
	touch ${commitMessageFile}
	echo 'gitcommit.cfg has been created.\ngitcommit-message.txt has been created.\n'
	echo 'Use a editor for commit messages?\nAdd it here (subl, bbedit, etc.), or leave this blank to use the command line, then Press [Enter]'
	read userEditor
	editorSetting=''
	if [[ ${userEditor} != '' ]]
	then
		editorSetting=${userEditor}
	fi
	editorSetting="gitcommit_editor=${editorSetting}"
	messageSetting="gitcommit_message=${commitMessageFile}"
	echo "${editorSetting}\n${messageSetting}" > ${configFile}
	read -p "Setup is all done. If you want to make changes later, pass 'config' as an argument when calling the script. Press [ENTER] to use the script."
fi
source ${configFile}
useEditor=${gitcommit_editor}
messageFile=${gitcommit_message}

if [[ ${1} == '' ]] || [[ ${1} == 'config' ]] 
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

if [[ ${useEditor} != '' ]]
then
	echo '' > ${messageFile}
	${useEditor} ${messageFile}
	read -p "Press [ENTER] when you are finished with the commit message in your editor(${useEditor})."
	# tr -d "\n\r" < ${messageFile}
	commitComment=`cat -s ${messageFile} | tr "\n" " "`
else 
	echo "Type commit message, then press [ENTER]:"
	read commitComment
fi

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