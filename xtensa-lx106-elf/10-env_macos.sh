#!/bin/bash

## Disable root check, as brew doesn't need root. Xcode will ask for a sudo password though.
# if [ "$(id -u)" != "0" ]; then
#         echo "Sorry, you are not root."
#         exit 1
# fi

cd ~/
if [ -d $((xcode-select -p)) ]; then
  echo "Xcode is installed"
else
  echo "Installing Xcode"
  curl -L -o xcode-6.2-cmd-tools.pkg "https://www.dropbox.com/s/1t7ux39sccxqfwx/xcode-6.2-cmd-tools.pkg\?dl\=0"
  sudo installer -pkg ~/xcode-6.2-cmd-tools.pkg -target / && rm -rf xcode-6.2-cmd-tools.pkg
fi

echo "Installing additional tools"
brew install findutils --with-default-names

# brew install binutils
# brew install diffutils
# brew install ed --default-names
# brew install gawk
# brew install gnu-indent --with-default-names
# brew install gnu-sed --with-default-names
# brew install gnu-tar --with-default-names
# brew install gnu-which --with-default-names
# brew install gnutls
# brew install grep --with-default-names
# brew install gzip
# brew install screen
# brew install watch
# brew install wdiff --with-gettext
# brew install wget

# (For now assuming it is already there and doesn't need to be cleaned)
# ##### Create a case-sensitive partition if needed
# files=$(ls /Volumes/case-sensitive* 2> /dev/null | wc -l)
# if [ "$files" != "0" ]; then
#   echo "Unmounting /Volumes/case-sensitive*"
#   umount /Volumes/case-sensitive*
# fi

# if [ -f ~/case-sensitive.dmg ]; then
#   echo "Removing ~/case-sensitive.dmg"
#   rm -rf ~/case-sensitive.dmg
# fi

# echo "Creating new ~/case-sensitive.dmg"
# hdiutil create ~/case-sensitive.dmg -volname "case-sensitive" -size 10g -fs "Case-sensitive HFS+"

# echo "Mounting ~/case-sensitive.dmg"
# hdiutil mount ~/case-sensitive.dmg