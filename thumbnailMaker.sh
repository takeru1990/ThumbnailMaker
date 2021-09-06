#!/bin/bash
# this shellscript requires a YouTube video URL as an argument

# show message when no args
if [ $# -eq 0 ]; then
	echo "np [video url] [game code]"
	exit 0
fi

# change directory
cd ~/bin/res/np

# prefix and suffix of thumbnail URL
prefix="http://img.youtube.com/vi/"
suffix="/maxresdefault.jpg"
vidprefix="https://www.youtube.com/watch?v="

# make thumbnail URL for argument YouTube video
id=`echo $1 | rev | cut -c 1-11 | rev`
url=$prefix$id$suffix

# download thumnail image
wget -O ./image.jpg $url

# get video number
vidurl=$vidprefix$id
title=`wget $vidurl -O - | grep -oP "(?<=<title>)(.+)(?=</title>)"`
number=`echo $title | grep -oP "(?<=Part )(.+)(?= -)"`

# edit SVG image
cp $2.svg svg_.svg
sed -i -e "s:>No. \?[0-9][0-9]\?[0-9]\?:>No. $number:g" svg_.svg

# make png image from svg
inkscape -o png.png svg_.svg

# compose 2 images
convert image.jpg png.png -composite ~/Downloads/$number.jpg

# delete temp images
rm image.jpg png.png svg_.svg

exit 0
