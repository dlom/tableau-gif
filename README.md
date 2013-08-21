# `tableau-gif`

Turn gifs into csv files that tableau can read

## Download

[Here][dl] is a direct link to the most current version

## Install

`tableau-gif` is a [shell script][bin], so drop it somewhere in your `$PATH`

## Usage

Just run `tableau-gif file.gif` and two csv files will be created in your cwd
(One with unix line endings and one with windows line endings), as well as a zip
file that contains both of them.

    $ tableau-gif rickroll.gif
    ...
    $ ls
    rickroll.gif.csv
    rickroll.gif_win.csv
    rickroll.gif-csv.zip

## Using the output with tableau

Tableau is wizardry.  I've never used it.  I just generate these awesome csv files.

[bin]: https://github.com/Dlom/tableau-gif/blob/master/tableau-gif
[dl]:  https://raw.github.com/Dlom/tableau-gif/master/tableau-gif
