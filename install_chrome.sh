#!/bin/bash

#Setting up temp location
mkdir /tmp/installer

#Chrome install
mkdir /tmp/installer/chrome
curl https://storgrid-s3-dev.aseit.com.au/ase-macpackages/GoogleChromeEnterprise.pkg -o /tmp/installer/chrome/Cinstaller.pkg
installer -pkg /tmp/installer/chrome/Cinstaller.pkg -target /Applications
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"; killall Dock
