# oldness

Oldness is a library and shell command that places the age of a published work on a semi-arbitrary five-star scale.

## Installation

     gem install oldness

     require 'oldness'

## Usage

### CLI

     $ oldness list
     animation
     comic
     film
     history
     literature
     novel
     philosophy
     rpg
     scifi
     videogame
     $ oldness rate comic 1987-10
     ****
     $ oldness ranges movie
     *****: 1894-02-05..1972-09-14
     **** : 1972-09-14..1998-11-27
     ***  : 1998-11-27..2007-08-22
     **   : 2007-08-22..2010-07-21
     *    : 2010-07-21..2012-01-04
     $ oldness first philosophy
     Tale of Genji (1010), by Murasaki Shikibu

### Library

Declaring the existence of a medium is easy; you don't need a national reputation as a culture critic or scholar.

     class Rubies < Medium
       began Date.new(1979)
     end

Although of course it would be better if you could point to a particular work that you saw as kicking things off.

     class RockNRoll < Medium
       began Date.new(1944), :with => "Strange Things Happen Every Day", :by => "Sister Rosetta Tharpe"
     end

Mediums know how to rate by date.

    Rubies.rate(Date.new(2010, 8, 29)) # => 3
    Rubies.rate("2012-1-4") # => 1

They also know what dates fall under what ratings.

    Rubies.ranges[5] #=> #<Date: 1979-01-01>..#<Date: 2001-01-02>

And, if you've told them, they remember their roots.

    RockNRoll.first.title #=> "Strange Things Happen Every Day"
    Rubies.first.by #=> "Unknown"

Just a reminder: mediums are timeless, so they never need to be instantiated.