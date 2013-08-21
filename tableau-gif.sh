#!/usr/bin/env bash

# you need imagemagick or graphicsmagick, also sed and zip
# this script will create LOTS of files in the cwd, but it should clean up after itself.  If it doesn't, run `rm ./(gif-filename)-frame*`

rm -f ./$1-frame* # just in case
convert $1 -flip flipped-$1 # tableau's origin is different than imagemagick's
echo "Splitting apart $1 into frames..."
convert flipped-$1 $1-frame-%06d.png # we wont ever have more than a million frames, will we?
rm flipped-$1
rm -f ./$1*.csv

real_count=$(ls -1 | grep $1-frame- | wc -l)
count=$(($real_count - 1))
echo "Found $real_count frames in $1"
echo '"x","y","r","g","b","frame"' >> $1.csv
for FRAME in `seq -f %06g 0 $count`; do
    echo "Adding frame $FRAME to $1.csv..."
    convert $1-frame-$FRAME.png $1-frame-$FRAME.txt
    sed "s/^\([0-9]\{1,3\}\),\([0-9]\{1,3\}\): ([ ]*\([0-9]\{1,3\}\),[ ]*\([0-9]\{1,3\}\),[ ]*\([0-9]\{1,3\}\).*/\1,\2,\3,\4,\5,$FRAME/g" $1-frame-$FRAME.txt >> $1.csv # agh
done
rm -f ./$1-frame*

echo "Converting $1.csv to use windows line endings"
sed 's/$'"/`echo \\\r`/" $1.csv > $1_win.csv # windows line-endings: why is this so hard

echo "Adding $1.csv and $1_win.csv to $1-csv.zip"
rm -f ./$1-csv.zip
zip $1-csv.zip $1.csv $1_win.csv -q
echo "All done!"
