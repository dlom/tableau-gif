# `tableau-gif`

Turn gifs into csv files that tableau can read

## Download

[Here][dl] is a direct link to the most current version

## Install

`tableau-gif` is a [shell script][bin], so drop it somewhere in your `$PATH`

## Usage

Just run `tableau-gif file.gif` and a csv file will be created in your cwd.
There will be a zipped copy too because the raw csv files are usually very large.

    $ tableau-gif rickroll.gif
    ...
    $ ls
    rickroll.csv
    rickroll.zip

Here's a warning though: The csv file has unix line endings.  Tableau appears to
handle this just fine, but opening the csv file in notepad or similar text editors
could be disastrous.

## Using the output with tableau

Tableau is wizardry.  I've never used it.  I just generate these awesome csv files.

[bin]: https://github.com/Dlom/tableau-gif/blob/master/tableau-gif
[dl]:  https://raw.github.com/Dlom/tableau-gif/master/tableau-gif
