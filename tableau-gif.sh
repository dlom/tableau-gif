#!/usr/bin/env bash
# you need imagemagick or graphicsmagick, also sed and perl
# this script will create LOTS of files in the cwd, but it should clean up after itself.  If it doesn't, run `rm ./(gif-filename)-frame*`

convert $1 $1-frame-%06d.png # we wont ever have more than a million frames, will we?
rm -f ./$1*.csv

count=$(($(ls -1 | grep frame | wc -l) - 1))
echo '"x","y","r","g","b","frame"' >> $1.csv
for FRAME in `seq -f %06g 0 $count`; do
    convert $1-frame-$FRAME.png $1-frame-$FRAME.txt
    sed "s/^\([0-9]\{1,3\}\),\([0-9]\{1,3\}\): ([ ]*\([0-9]\{1,3\}\),[ ]*\([0-9]\{1,3\}\),[ ]*\([0-9]\{1,3\}\).*/\1,\2,\3,\4,\5,$FRAME/g" $1-frame-$FRAME.txt >> $1.csv # agh
done
rm -f ./$1-frame*

perl -p -e 's/\n/\r\n/' < $1.csv > $1_win.csv # windows line-endings
