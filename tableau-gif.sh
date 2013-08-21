#!/usr/bin/env bash
# you need imagemagick or graphicsmagick

convert $1 frame-%06d.png # we wont ever have more than a million frames, will we?
rm -f ./*.csv

count=$(($(ls -1 | grep frame | wc -l) - 1))
echo '"x","y","r","g","b","frame"' >> frames.csv
for FRAME in `seq -f %06g 0 $count`; do
    convert frame-$FRAME.png frame-$FRAME.txt
    sed "s/^\([0-9]\{1,3\}\),\([0-9]\{1,3\}\): ([ ]*\([0-9]\{1,3\}\),[ ]*\([0-9]\{1,3\}\),[ ]*\([0-9]\{1,3\}\).*/\1,\2,\3,\4,\5,$FRAME/g" frame-$FRAME.txt >> frames.csv
done
rm -f ./frame-*

perl -p -e 's/\n/\r\n/' < frames.csv > frames_win.csv
