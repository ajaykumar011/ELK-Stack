#!/bin/bash

#yum update –y
#yum clean all 
cat /etc/Redhat-release
timedatectl set-timezone ‘Asia/Kolkata’
yum -y install sudo wget curl openssl git finger
clear
echo "########################################################################"
read -p "Enter your new user for elkclient: " USERNAME
read -p "Enter your new user password: " PASSWORD
echo "########################################################################"
if [ $(getent passwd $USERNAME) ] ; then
        echo user $USERNAME exists, quiting the program
        sleep 3s
        exit 1
else
        echo user $USERNAME doesn\'t exists, creating a sudo user for you..
        sudo /usr/sbin/useradd -m -p $(openssl passwd -1 ${PASSWORD}) -s /bin/bash -G wheel ${USERNAME}
        echo "user successfully created"

fi
echo "Great you're ready to go with new user"
echo "Here is the passwd string for you"
echo "-----------------------------------------------------------------------------"
cat /etc/passwd | grep $USERNAME
echo "-----------------------------------------------------------------------------"
id $USERNAME
ehco "-----------------------------------------------------------------------------"
finger $USERNAME
echo "Thank you............................."
