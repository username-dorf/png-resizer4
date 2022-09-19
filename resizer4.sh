#!/bin/bash
OIFS="$IFS"
IFS=$'\n'
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
mkdir -p "output"
for filename in $parent_path/*.png; do
   width=`identify -format '%w' $filename`
   wIncrease=$(($width%4))
   if [[ $wIncrease -ne 0 ]]; then
    wCorrect=$(($width+4-$wIncrease))
    else
    wCorrect=$width
   fi   
   
   height=`identify -format '%h' $filename`
   hIncrease=$(($height%4))
   if [[ $hIncrease -ne 0 ]]; then
    hCorrect=$(($height+4-$hIncrease))
    else
    hCorrect=$height
   fi   

saveFolder=`dirname $filename`
file=`basename $filename`
`convert ${filename} -resize ${wCorrect}x${hCorrect}! ${saveFolder}/output/${file}`
echo "${file} was $width x $height; Become $wCorrect x $hCorrect"


done