#!/bin/bash
USER="USERNAME"
PASS="PASSWORD"
curl --ciphers 'DEFAULT:!DH' --silent -i -s -k -X $'POST' \
    -b $'PHPSESSID=bljrs1akfilbm0rnubvh1oht13' \
    --data-binary "userLogin=$USER&userPassword=$PASS&submit=" \
    $'https://netaccess.iitm.ac.in/account/login' >> /dev/null

curl --ciphers 'DEFAULT:!DH' -i -s -k -X $'POST' \
    -b $'PHPSESSID=bljrs1akfilbm0rnubvh1oht13' \
    --data-binary $'duration=2&approveBtn=' \
    $'https://netaccess.iitm.ac.in/account/approve' >> /dev/null

ping -c 1 google.com >> /dev/null
if [ $? -eq 0 ]
then
    echo "Approved..."
else
    echo "Network issue..."
fi
