#!/bin/bash
set -e
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
#DEC Cylance token, replace as needed.
TOKEN=g8HRErZ4B02MNUjWfxtKcdcZA

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
LOG "               Don't ask him about it.                   "
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
if [ ! -e "/Applications/Google Chrome.app" ]
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
if [ ! -e "/Applications/Cylance/CylanceUI.app" ]
then
    LOG "Downloading Cylance."
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/ASEC3307-CylancePROTECT.dmg -o $PKGDIR/Cylance.dmg
    LOG "Mounting Cylance DMG."
    hdiutil attach -nobrowse $PKGDIR/Cylance.dmg
    LOG "Cylance DMG mounted to /Volumes."
    LOG "Copying Cylance files to /tmp/ase/packages"
    cp -a /Volumes/CylancePROTECT/. /tmp/ase/packages
    LOG "Copying Cylance files to /tmp/ase/packages complete."
    LOG "Renaming pkg."
    mv "/tmp/ase/packages/ .pkg" /tmp/ase/packages/Cylance.pkg
    LOG "Setting Cylance token."
    echo $TOKEN > /tmp/ase/packages/cyagent_install_token
    LOG "Installing Cylance package."
    installer -package $PKGDIR/Cylance.pkg -target /
    LOG "Cylance installed."
    hdiutil detach /Volumes/CylancePROTECT
    LOG "Cylance DMG dismounted."
else
    LOG "Cylance already installed."
fi

# Amazon Chime REQUIRES REVIEW
LOG "Attempting to install Amazon Chime."
if [ ! -f "/Applications/Amazon Chime.app" ]
then
    LOG "Downloading Amazon Chime."
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/AmazonChime-5.21.22083.dmg -o $PKGDIR/chime.dmg
    LOG "Mounting Amazon Chime DMG."
    hdiutil attach -nobrowse $PKGDIR/chime.dmg
    LOG "Amazon Chime DMG mounted to /Volumes."
    LOG "Copying Amazon Chime files to /tmp/ase/packages"
    cp -a /Volumes/AmazonChime-5.21.22083/. /tmp/ase/packages
    LOG "Copying Amazon Chime files to /tmp/ase/packages complete."
    LOG "Installing Amazon Chime package."
    mv "/tmp.ase/packages/Amazon Chime.app" "/Applications/Amazon Chime.app"
    LOG "Amazon Chime installed."
    hdiutil detach /Volumes/AmazonChime-5.21.22083
    LOG "Amazon Chime DMG dismounted."
else
    LOG "Amazon Chime already installed."
fi

#Fonts
#Only checks for one of the Montserrat fonts
LOG "Attempting to install fonts."
if [ ! -f "/Library/Fonts/Montserrat-Black.ttf" ]
then
    LOG "Donwloading fonts."
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-Black.ttf -o /Library/Fonts/Montserrat-Black.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-BlackItalic.ttf -o /Library/Fonts/Montserrat-BlackItalic.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-Bold.ttf -o /Library/Fonts/Montserrat-Bold.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-BoldItalic.ttf -o /Library/Fonts/Montserrat-BoldItalic.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-ExtraBold.ttf -o /Library/Fonts/Montserrat-ExtraBold.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-ExtraBoldItalic.ttf -o /Library/Fonts/Montserrat-ExtraBoldItalic.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-ExtraLight.ttf -o /Library/Fonts/Montserrat-ExtraLight.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-Italic.ttf -o /Library/Fonts/Montserrat-Italic.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-Light.ttf -o /Library/Fonts/Montserrat-Light.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-LightItalic.ttf -o /Library/Fonts/Montserrat-LightItalic.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-Medium.ttf -o /Library/Fonts/Montserrat-Medium.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-MediumItalic.ttf -o /Library/Fonts/Montserrat-MediumItalic.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-Regular.ttf -o /Library/Fonts/Montserrat-Regular.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-SemiBold.ttf -o /Library/Fonts/Montserrat-SemiBold.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-SemiBoldItalic.ttf -o /Library/Fonts/Montserrat-SemiBoldItalic.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-Thin.ttf -o /Library/Fonts/Montserrat-Thin.ttf
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/DECFONTS/Montserrat-ThinItalic.ttf -o /Library/Fonts/Montserrat-ThinItalic.ttf    
    LOG "Fonts copied to /Library/Fonts."
 else
    LOG "Fonts already installed."
fi

#Printer driver.
LOG "Attempting to add printer driver."
if [ ! -e "/Library/Printers/Canon/CUPS_Printer/Utilities/Canon Office Printer Utility.app" ]
then
    LOG "Downloading printer drive."
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/UFRII-LIPSLX-v101914-10.dmg -o $PKGDIR/printer.dmg
    LOG "Print driver downloaded."
    LOG "Mounting printer dmg."
    hdiutil attach -nobrowse $PKGDIR/printer.dmg
    LOG "Printer DMG mounted."
    LOG "Copying package files."
    cp /Volumes/printer/. $PKGDIR/
    LOG "Printer package files copied."
    LOG "Installing driver package."
    installer -pkg $PKGDIR/UFRII_LT_LIPS_LX_Installer.pkg -target /
        if [ ! -e "/Library/Printers/Canon/CUPS_Printer/Utilities/Canon Office Printer Utility.app" ]
        then
            LOG "Print driver installed succesfully."
        else
            LOG "Print driver installation failed."
        fi
    LOG "Dismounting printer.dmg."
    hdiutil -detach /Volumes/printer.dmg
    LOG "Printer DMG dismounted."
fi
LOG "Attempting to unzip ppd."
unzip /Library/Printers/PPDs/Contents/Resources/CNPZUIRAC5840ZU.ppd.gz
if [ ]



#Printer installation.
LOG "Attempting to install printer."

lpadmin -p iR-ADV C5840 -E -v ipp://192.168.24.10/ipp/print -m driver drv:///sample.drv/laserjet.ppd -o department-id=1111




#Office installation
LOG "Attempting to install office."
if [ ! -e "/Applications/Office.pkg" ]
then
    LOG "Downloading Office package."
    curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/Microsoft_365_and_Office_16.76.23081101_BusinessPro_Installer.pkg -o $PKGDIR/Office.pkg
    LOG "Office package downloaded."
    LOG "Attempting to install office."
    installer -pkg $PKGDIR/Office.pkg -target /Applications.
        if [ ! -e "/Applications/Microsoft Excel.app" -a  ]
        then    
            LOG "Office installation failed."
        else
            LOG "Office installed succesfully."
        fi
fi



