##!/bin/bash

leaf01=172.20.20.2
leaf02=172.20.20.4
spine01=172.20.20.3

sudo apt-get install sshpass netcat -y

#Generate SSH key

FILE=~/.ssh/id_rsa

if ! [ -f "$FILE" ]; then
   echo " Generating new SSH keys"
ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa <<< y
else 
echo "      "
echo  "Private SSH key exists. Skip generation"
echo "      "
fi


#Copy ssh key to ansible managed hosts

echo "Waiting until remote ssh will accept connections..."
echo "      "

while ! nc -z $leaf01 22; do
  sleep 1
done

sshpass -p root ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@$leaf01

echo "Waiting until remote ssh will accept connections..."
echo "      "

while ! nc -z $spine01 22; do
  sleep 1
done

sshpass -p root ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@$spine01

echo "Waiting until remote ssh will accept connections..."
echo "      "

while ! nc -z $leaf02 22; do
  sleep 1
done

sshpass -p root ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@$leaf02
