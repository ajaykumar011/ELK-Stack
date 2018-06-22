#!/bin/bash

yum update –y
yum clean all 
cat /etc/Redhat-release
timedatectl set-timezone ‘Asia/Kolkata’
yum -y install sudo wget curl openssl git
read -p "Enter your new user for elkclient: " USERNAME
read -p "Enter your new user password: " PASSWORD

if [ $(getent passwd $USERNAME) ] ; then
        echo user $USERNAME exists, quiting the program
        exit 1
else
        echo user $USERNAME doesn\'t exists, creating a sudo user for you..
        sudo /usr/sbin/useradd -m -p $(openssl passwd -1 ${PASSWORD}) -s /bin/bash -G wheel ${USERNAME}
        echo "user successfully created"

fi
echo " Great you're ready to go with new user"
cat /etc/passwd | grep $USERNAME
