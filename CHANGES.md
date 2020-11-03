# 1.7.1

* Added CHANGES.md to gem files

* Fixed outdated changelog_uri

# 1.7.0

* Added optional YAML integration

This makes it possible to dump/load month objects to/from YAML as scalar values. For example:

    require 'month/yaml'

    puts YAML.dump([Month.today])

This functionality is not enabled by default, due to the use of Module#prepend.

# 1.6.0

* Added Month#month alias for Month#number

* Added Month#iso8601 alias for Month#to_s

# 1.5.0

* Added Month#<< and Month#>> methods (@pboling)

* Added Month.today method

* Added Month.now method

# 1.4.0

* Fixed comparison with nil objects / ActiveRecord serialization

# 1.3.0

* Month objects are now frozen on initialization (@replaid, #4)

# 1.2.0

* Added step argument to Month#step and upto/downto methods (@jkr2255, #3)

# 1.1.0

* Fixed fence-post error with addition (@fhwang, #2)

* Added subtraction functionality for calculating number of months between two month objects (@aprikip, #1)

# 1.0.0

* New version!
