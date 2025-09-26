#!/bin/bash

AREA=$(slurp -d)
echo $AREA
if [ uwu$AREA == "uwu" ]
then
  exit
fi

FILE_NAME=screenshot_$(date +'%Y-%m-%d_%H-%M-%S')
FILE=~/Pictures/Screenshots/$FILE_NAME.png
grim -g "$AREA" - | 
  tee $FILE | 
  wl-copy -t "image/png"

SIZE=150x150
magick $FILE -resize $SIZE^ -gravity center -extent $SIZE /tmp/$FILE_NAME-icon

ACTION=$(notify-send -i /tmp/$FILE_NAME-icon "Screenshot saved and copied ^w^" $FILE -A "Show" -A "Copy path")
if [ $ACTION == 0 ]    
then
  xdg-open $FILE
else
  wl-copy $FILE
fi
