#!/bin/bash
# for use with OS X only (on account of weird diskutil stuff and bs=1m instead
# of bs=1M)
# takes 2 parameters: # of disk to copy and name (preferably hostname) of the 
# device you want to image
diskutil unmountDisk /dev/disk$1;

RAW_SRC=/dev/rdisk$1
BASE_IMG_OUT=~/magzor/images/$(date +%F)-$2
EXT_IMG_OUT=img.gz 
SUFFIX_IMG_OUT=""
COUNT=0
IMG_OUT=$BASE_IMG_OUT$SUFFIX_IMG_OUT.$EXT_IMG_OUT

# there's probably a DRY-er and more idiomatic way of doing this, but I don't
# know it yet
# anyway, all I'm trying to do is append a number to the end of a script if
# there's an image file (or files) that already have the same base name
while [ -e $IMG_OUT ];
do
    COUNTER=$[COUNTER + 1]
    SUFFIX_IMG_OUT=-$COUNTER
    IMG_OUT=$BASE_IMG_OUT$SUFFIX_IMG_OUT.$EXT_IMG_OUT
done

echo "Copying $RAW_SRC to $IMG_OUT"
dd bs=1m if=/dev/rdisk$1 | gzip -c > $IMG_OUT;
chown $USER:staff $IMG_OUT;
echo "Process ended."
