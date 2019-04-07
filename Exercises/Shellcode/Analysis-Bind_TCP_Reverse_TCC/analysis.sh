#!/bin/bash
if [[ -z $2 ]]; then
    echo 'Help:'
    echo '- Prerequisite: Put this script in /home/slae/libemu/tools/sctest/analysis.sh'
    echo '- Use: ./analyze.sh <payload_name> <output_image_name>'
    echo '- Example: ./analyze.sh linux/x86/shell_bind_tcp img'
    exit 1
fi

echo '[+] Please Wait...'
msfvenom -p $1 | sudo ./sctest -vvv -Ss 1000000 -G $2.dot > output.txt 
echo '[+] Opening Graph...'
dot $2.dot -Tpng -o $2.png && display $2.png
echo '[+] Done!'

