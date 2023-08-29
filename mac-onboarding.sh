#!/bin/bash

#ASE Mac Onboarding Script
#Written by Nick 
#nicholas.martin@ase.tech nickmartin141@hotmail.com
#Version 1.0 11/08/23
#Comments
#The purpose of this script is to run onboarding actions including:
#The creation of a local admin
#Allowing admin to use Apple Remote Desktop
#Configuration of security settings include Office Macros

#Variables
TIMESTAMP=$(date +"%T %d-%m-%y")
DIR=/tmp/ase
LOGFILE=/tmp/ase/mac-onboarding.log
UN=aseadmin
#PKGDIR=/tmp/ase/packages

#Functions
LOG (){
    cat <<EOT >> /tmp/ase/mac-onboarding.log
$TIMESTAMP $1
EOT
}

#Create temporary directories
if [ ! -d $DIR ]
then
    mkdir /tmp/ase
fi

#Create log file
if [ ! -f $LOGFILE ]
then
    touch $LOGFILE
fi

#Write header
LOG "Log File Created."
LOG "---------------------------------------------------------"
LOG "                       ASEIT                             "
LOG "               Mac deployment script.                    "
LOG "                   Written by Nick.                      "
LOG "               Dont ask him about it.                    "
LOG "---------------------------------------------------------"

#Create admin account
LOG "Attempting to create admin user."
if [ ! -e $UN ]
then
    dscl . -create /Users/$UN
    dscl . -create /Users/$UN UserShell /bin/bash
    dscl . -create /Users/$UN RealName "ASE Admin"
    dscl . -create /Users/$UN PrimaryGroupID 1000
    dscl . -create /Users/$UN NFSHomeDirectory /Local/Users/$UN
    dscl . -passwd /Users/$UN [ase1t=82338]
    dscl . -append /Groups/admin GroupMembership $UN
    LOG "ASE Admin created."
else
    LOG "ASE Admin already exists."
fi

#Configure Apple Remote desktop

#Network shares
smb://asec3307_vf01.ampersandsyd.local/DEC
smb://asec3307_vf01.ampersandsyd.local/ClientDrive

#Printers
