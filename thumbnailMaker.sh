#!/bin/bash
# this shellscript requires a YouTube video URL as an argument
 
# prefix and suffix of thumbnail URL
prefix="http://img.youtube.com/vi/"
suffix="/maxresdefault.jpg"
vidprefix="https://www.youtube.com/watch?v="
 
# make thumbnail URL for argument YouTube video
#id=$(cut -d'=' -f 2 <<<$1)
id=`echo ${1} | rev | cut -c 1-11 | rev`
url=$prefix$id$suffix
 
# download thumnail image
curl -o ~/Downloads/image.jpg $url
 
# get video number
vidurl=$vidprefix$id
title=`curl $vidurl 2>&1 | grep -oP "(?<=<title>)(.+)(?=</title>)"`
number=`echo $title | grep -oP "(?<=Part )(.+)(?= -)"`
 
# edit SVG image
sed -i -e "s:>No. \?[0-9][0-9]\?[0-9]\?:>No. ${number}:g" ~/.np/svg.svg
inkscape -e ~/.np/png.png ~/.np/svg.svg
convert ~/Downloads/image.jpg ~/.np/png.png -composite ~/Downloads/${number}.jpg
rm ~/Downloads/image.jpg ~/.np/png.png
#mv *.jpg ~/Downloads/
 
 
exit 0
