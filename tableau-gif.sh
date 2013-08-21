#!/usr/bin/env bash

# you need imagemagick or graphicsmagick, also sed and zip

tmp_dir=$(mktemp -d)

convert $1 -flip $tmp_dir/flipped-$1 # tableau's origin is different than imagemagick's
echo "Splitting apart $1 into frames..."
convert $tmp_dir/flipped-$1 $tmp_dir/$1-frame-%06d.png # we wont ever have more than a million frames, will we?

real_count=$(ls -1 $tmp_dir | grep $1-frame- | wc -l)
count=$(($real_count - 1))
echo "Found $real_count frames in $1"
echo '"x","y","r","g","b","frame"' >> $1.csv
for FRAME in `seq -f %06g 0 $count`; do
    echo "Adding frame $FRAME to $1.csv..."
    convert $tmp_dir/$1-frame-$FRAME.png $tmp_dir/$1-frame-$FRAME.txt
    sed "s/^\([0-9]\{1,3\}\),\([0-9]\{1,3\}\): ([ ]*\([0-9]\{1,3\}\),[ ]*\([0-9]\{1,3\}\),[ ]*\([0-9]\{1,3\}\).*/\1,\2,\3,\4,\5,$FRAME/g" $tmp_dir/$1-frame-$FRAME.txt >> $1.csv # agh
done

echo "Converting $1.csv to use windows line-endings..."
sed 's/$'"/`echo \\\r`/" $1.csv > $1_win.csv # windows line-endings: why is this so hard

echo "Adding $1.csv and $1_win.csv to $1-csv.zip..."
rm -f ./$1-csv.zip
zip $1-csv.zip $1.csv $1_win.csv -q

echo "Cleaning up..."
rm -rf $tmp_dir

echo "All done!"
