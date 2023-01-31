#!/bin/bash


clear

## ./delete-all $APPNAME
APPNAME=$1

# output=$(ls -ltr *$APPNAME*)
# echo "${efiles[@]}"

efiles=$( find  $HOME/.local/bin/ -name "*$APPNAME*" -type f -print  )
echo "${efiles[@]}"


if [[ -n "$efiles" ]]; then
   echo -e "\n"
   read -p 'Would you like to delete all $APPNAME executable files? (Y/n): ' GL

      ##if [ ("$GL" = "Y" ) && ("$printReq" -eq 1) ] || [ ("$GL" = "y") && ("$printReq" -eq 1) ] ; then
   if [ "$GL" = "Y" ] || [ "$GL" = "y" ] ; then
      find  $HOME/.local/bin/  \
         -name "*$APPNAME*" \
         -type f \
         -print | \
         xargs rm -f
   fi

fi

scfiles=$( find  $HOME/.local/share/applications/  -name "*$APPNAME*.desktop" -type f -print  )
echo "${scfiles[@]}"



if [[ -n "$scfiles" ]]; then
   echo -e "\n"
   read -p 'Would you like to delete all Desktops Shortcut? (Y/n): ' GL

   if [ "$GL" = "Y" ] || [ "$GL" = "y" ] ; then
      find  $HOME/.local/share/applications/ \
            -name "*$APPNAME*.desktop" \
            -type f \
            -print | \
            xargs rm -f
   fi

fi

echo "------ Completed Script file execution -----------"