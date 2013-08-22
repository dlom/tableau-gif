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

Super complex steps: Follow these and don't miss anything.
1. Create a new sheet and connect it with the csv data (just use the defaults, everything should work)
2. Change `x` and `y` from `Measures` to `Dimension` (drag) and convert them both to continuous
3. Drag the `x` measure onto `Columns` and `y` onto `Rows`.
4. Make a calculated measure that is the sum of r, g, and b.  Drag this calculated measure onto `Color`
5. Edit the colors:
 * Click the little colored box, change it to pure black, and click OK.
 * Check `Reversed`
 * Under `Advanced`, change `Start` to `0` and `End` to `765`
6. Change `frame` from a Measure to a Dimension
7. Drag `frame` to `Pages`
8. Wait
9. Adjust the `Size` scale for best results
9. Done!  Change frames by changing `Pages` parameters.
10. If it didn't work, open a new [issue][issue] (with a screenshot preferably)

[bin]: https://github.com/Dlom/tableau-gif/blob/master/tableau-gif
[dl]:  https://raw.github.com/Dlom/tableau-gif/master/tableau-gif
[issue]: https://github.com/Dlom/tableau-gif/issues/new
