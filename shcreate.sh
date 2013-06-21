#!/bin/bash
#Author: Clark - clark@lotdf.com
#Ver. 0.1.0
#Purpose: To be as lazy as possible when creating other scripts to accomplish tasks without too much effort.  

newsh="${1}.sh"

echo "Creating file: ${newsh}"

touch ${newsh}

echo "#!/bin/bash\n#Author: Clark - clark@lotdf.com\n#Ver. 0.1.0\n#Purpose:\n\n\n\necho \"All done.\"\nexit 0" >> ${newsh}

echo "Done."

echo "Making ${newsh} executable."

chmod +x ${newsh}

echo "All done."

exit 0
