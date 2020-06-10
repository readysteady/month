# month

![Gem Version](https://badge.fury.io/rb/month.svg)
![Build Status](https://github.com/readysteady/month/workflows/Test/badge.svg)


Ruby gem for working with months.


## Install

Using Bundler:

    $ bundle add month

Using RubyGems:

    $ gem install month


## Feature tour

You can create a new Month object with a year and month number:

```ruby
Month.new(2014, 1)  # January 2014
```

Alternatively you can use the Month method to cast various date/time
objects to Month objects:

```ruby
Month(Date.new(2014, 1, 31))  # January 2014

Month(Time.at(1234567890))  # February 2009
```

The method will idempotently return Month objects as-is:

```ruby
Month(Month.new(2014, 1))  # January 2014, same object
```

Use the Month.parse method to parse a YYYY-MM formatted string:

```ruby
Month.parse('2014-01')  # January 2014
```

The #year attribute will return the year of the month:

```ruby
Month.new(2014, 1).year  # 2014
```

The #number attribute will return the number of the month:

```ruby
Month.new(2014, 1).number  # 1
```

The #name method will return the name of the month as a symbol:

```ruby
Month.new(2014, 1).name  # :January
```

Alternatively you can use predicate methods to test for a given month:

```ruby
Month.new(2014, 1).january?  # true

Month.new(2014, 2).january?  # false
```

The #to_s method will return a YYYY-MM formatted string representation
of the month:

```ruby
Month.new(2014, 1).to_s  # "2014-01"
```

You can add/subtract an integer number of months:

```ruby
Month.new(2014, 1) + 1  # February 2014

Month.new(2014, 1) - 1  # December 2013
```

The #step method iterates between 2 months, similar to Date#step:

```ruby
Month.new(2014, 1).step(Month.new(2014, 12)) do |month|
  ...
end
```

The #include? method can be used to test if the month includes a date:

```ruby
Month.new(2014, 1).include?(Date.new(2014, 1, 31))  # true
```

The #dates method returns a range containing the dates in the month:

```ruby
Month.new(2014, 1).dates  # Range containing 31 Date objects
```

The #length method returns the number of days in the month:

```ruby
Month.new(2014, 1).length  # 31
```

Month objects can be used in case expressions.

Month objects can be used as hash keys.

Month objects can be used in ranges.

Month objects are comparable.


## Bonus extras

The Month::Methods module provides methods for constructing Month objects
and Date objects in a manner that closely resembles written english:

```ruby
include Month::Methods

month = January 2014

date = January 15, 2014
```

It is not included globally by default; you can either include it within
your own modules/classes or globally within your own application/script.


## Thanks

This current implementation is an accidental rewrite of an older library/gem
with the same name/purpose ([fhwang / month](https://github.com/fhwang/month)).
Thanks to Francis for kindly allowing me to re-use the same gem name.
