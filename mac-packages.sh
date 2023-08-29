#!/bin/bash
#!/bin/bash

#ASE Mac Packages Script
#Written by Nick 
#nicholas.martin@ase.tech nickmartin141@hotmail.com
#Version 1.0 29/08/23
#Comments
#The purpose of this script is to install mac applications

#Variables
TIMESTAMP=$(date +"%T %d-%m-%y")
DIR=/tmp/ase
LOGFILE=/tmp/ase/mac-packages.log
#UN=aseadmin
PKGDIR=/tmp/ase/packages

#Functions
LOG (){
    cat <<EOT >> $LOGFILE
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

#Install applications
LOG "Creating package directory."
if [ ! -d $PKGDIR ]
then
    mkdir $PKGDIR
fi
LOG "Directory created."

#Chrome
LOG "Attempting to install chrome."
if [ ! -f "/Applications/Google Chrome.pkg" ]
then
    LOG "Downloading Chrome."
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/GoogleChromeEnterprise.pkg -o $PKGDIR/Chrome.pkg
    LOG "Downloaded Chrome."
    LOG "Installing Chrome."
    installer -pkg $PKGDIR/Chrome.pkg -target /Applications
    LOG "Google Chrome installed."
else
    LOG "Chrome already installed."
fi

#Cylance REQUIRES REVIEW
LOG "Attempting to install Cylance."
if [ ! -f "/Applications/TBA" ]
then
    LOG "Downloading Cylance."
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/ASEC3307-CylancePROTECT.dmg -o $PKGDIR/Cylance.dmg
    LOG "Mounting Cylance DMG."
    hdiutil attach $PKGDIR/Cylance.dmg
    LOG "Cylance DMG mounted to /Volumes."
    LOG "Installing Cylance package."
    installer -package /Volumes/Cylance.dmg/<image>.pkg -target /Applications
    LOG "Cylance installed."
    hdiutil detach /Volumes/Cylance.dmg
    LOG "Cylance DMG dismounted."
else
    LOG "Cylance already installed."
fi

#Amazon Chime REQUIRES REVIEW
LOG "Attempting to install Amazon Chime."
if [ ! -f "/Applications/TBA" ]
then
    LOG "Downloading Amazon Chime."
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/AmazonChime-5.21.22083.dmg -o $PKGDIR/AmazonChime.dmg
    LOG "Mounting Amazon Chime DMG."
    hdiutil attach $PKGDIR/AmazonChime.dmg
    LOG "Amazon Chime DMG mounted to /Volumes."
    LOG "Installing Amazon Chime package."
    installer -package /Volumes/AmazonChime.dmg/<image>.pkg -target /Applications
    LOG "Amazon Chime installed."
    hdiutil detach /Volumes/Cylance.dmg
    LOG "Amazon Chime DMG dismounted."
else
    LOG "Amazon Chime already installed."
fi

#Fonts
