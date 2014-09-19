require 'minitest/autorun'

require_relative '../lib/month'

describe 'Month' do
  it 'raises an exception when initialized with an invalid number' do
    proc { Month.new(2014, 0) }.must_raise(ArgumentError)
    proc { Month.new(2014, 100) }.must_raise(ArgumentError)
  end

  describe 'year method' do
    it 'returns the integer year of the month' do
      Month.new(2014, 1).year.must_equal(2014)
    end
  end

  describe 'number method' do
    it 'returns the integer number of the month' do
      Month.new(2014, 1).number.must_equal(1)
    end
  end

  describe 'to_s method' do
    it 'returns a string containing the year and zero padded number of the month' do
      Month.new(2014, 1).to_s.must_equal('2014-01')
    end
  end

  describe 'name method' do
    it 'returns the name of the month' do
      Month.new(2014, 1).name.must_equal(:January)
    end
  end

  describe 'january predicate method' do
    it 'returns true if the month is january' do
      Month.new(2014, 1).january?.must_equal(true)
    end

    it 'returns false otherwise' do
      Month.new(2014, 2).january?.must_equal(false)
    end
  end

  describe 'february predicate method' do
    it 'returns true if the month is february' do
      Month.new(2014, 2).february?.must_equal(true)
    end

    it 'returns false otherwise' do
      Month.new(2014, 1).february?.must_equal(false)
    end
  end

  it 'supports being used as a hash key' do
    hash, n = Hash.new(0), 10

    n.times { hash[Month.new(2014, 1)] += 1 }

    hash.count.must_equal(1)
    hash[Month.new(2014, 1)].must_equal(n)
  end

  it 'supports comparison between month objects' do
    Month.new(2014, 1).must_be_kind_of(Comparable)

    (Month.new(2014, 1) == Month.new(2014, 1)).must_equal(true)
    (Month.new(2014, 1) == Month.new(2014, 2)).must_equal(false)

    (Month.new(2014, 1) < Month.new(2014, 2)).must_equal(true)
    (Month.new(2014, 2) > Month.new(2014, 1)).must_equal(true)
  end

  it 'supports being used in a range' do
    range = Month.new(2014, 1) .. Month.new(2014, 4)

    range.map(&:number).must_equal([1, 2, 3, 4])
  end

  describe 'next method' do
    it 'returns a month object denoting the next month' do
      Month.new(2014, 1).next.must_equal(Month.new(2014, 2))
      Month.new(2014, 12).next.must_equal(Month.new(2015, 1))
    end
  end

  describe 'succ method' do
    it 'returns a month object denoting the next month' do
      Month.new(2014, 1).succ.must_equal(Month.new(2014, 2))
      Month.new(2014, 12).succ.must_equal(Month.new(2015, 1))
    end
  end

  describe 'step method' do
    it 'calls the block for every month until the given limit' do
      months = []

      Month.new(2014, 1).step(Month.new(2014, 3)) { |month| months << month }

      months.must_equal([Month.new(2014, 1), Month.new(2014, 2), Month.new(2014, 3)])
    end

    it 'returns an enumerator if no block was given' do
      months = Month.new(2014, 1).step(Month.new(2014, 3))

      months.must_be_instance_of(Enumerator)

      months.next.must_equal(Month.new(2014, 1))
      months.next.must_equal(Month.new(2014, 2))
      months.next.must_equal(Month.new(2014, 3))
    end
  end

  describe 'addition' do
    it 'returns a month object denoting the given number of months after self' do
      (Month.new(2014, 1) + 1).must_equal(Month.new(2014, 2))
      (Month.new(2014, 1) + 12).must_equal(Month.new(2015, 1))
      (Month.new(2014, 1) + 18).must_equal(Month.new(2015, 7))
      (Month.new(2013, 11) + 1).must_equal(Month.new(2013, 12))
      (Month.new(2013, 11) + 2).must_equal(Month.new(2014, 1))
    end
  end

  describe 'subtraction' do
    it 'returns a month object denoting the given number of months before self' do
      (Month.new(2014, 2) - 1).must_equal(Month.new(2014, 1))
      (Month.new(2014, 1) - 1).must_equal(Month.new(2013, 12))
      (Month.new(2014, 1) - 12).must_equal(Month.new(2013, 1))
      (Month.new(2014, 1) - 18).must_equal(Month.new(2012, 7))
      (Month.new(2013, 12) - 1).must_equal(Month.new(2013, 11))
      (Month.new(2014, 1) - 2).must_equal(Month.new(2013, 11))
    end

    it 'returns the number of months between the given month and self' do
      (Month.new(2014, 3) - Month.new(2014, 1)).must_equal(2)
      (Month.new(2015, 1) - Month.new(2014, 1)).must_equal(12)
      (Month.new(2077, 4) - Month.new(2070, 4)).must_equal(84)
    end
  end

  describe 'include predicate method' do
    it 'returns true if the month includes the given date' do
      Month.new(2014, 1).include?(Date.new(2014, 1, 1)).must_equal(true)
    end

    it 'returns false otherwise' do
      Month.new(2014, 1).include?(Date.new(2014, 2, 1)).must_equal(false)
    end
  end

  describe 'case equals method' do
    it 'returns true if the month includes the given date' do
      (Month.new(2014, 1) === Date.new(2014, 1, 1)).must_equal(true)
    end

    it 'returns false otherwise' do
      (Month.new(2014, 1) === Date.new(2014, 2, 1)).must_equal(false)
    end
  end

  describe 'start_date method' do
    it 'returns a date object denoting the first day of the month' do
      Month.new(2014, 1).start_date.must_equal(Date.new(2014, 1, 1))
    end
  end

  describe 'end_date method' do
    it 'returns a date object denoting the last day of the month' do
      Month.new(2014, 1).end_date.must_equal(Date.new(2014, 1, 31))
    end
  end

  describe 'dates method' do
    it 'returns the range of dates in the month' do
      dates = Month.new(2014, 1).dates
      dates.must_be_instance_of(Range)
      dates.count.must_equal(31)
      dates.all? { |date| Date === date }.must_equal(true)
      dates.first.must_equal(Date.new(2014, 1, 1))
      dates.last.must_equal(Date.new(2014, 1, 31))
    end
  end

  describe 'length method' do
    it 'returns the integer number of days in the month' do
      Month.new(2014, 1).length.must_equal(31)
      Month.new(2014, 2).length.must_equal(28)
    end
  end
end

describe 'Month parse method' do
  it 'returns the month corresponding to the given string representation' do
    Month.parse('2014-01').must_equal(Month.new(2014, 1))
  end

  it 'raises an exception if the format of the string is not as expected' do
    proc { Month.parse('January 2014') }.must_raise(ArgumentError)
  end
end

describe 'Month method' do
  it 'returns the month of the given date object' do
    Month(Date.new(2014, 1, 1)).must_equal(Month.new(2014, 1))
  end

  it 'returns the month of the given time object' do
    Month(Time.at(1234567890)).must_equal(Month.new(2009, 2))
  end

  it 'returns the month of the given datetime object' do
    Month(DateTime.parse('2001-02-03T04:05:06+07:00')).must_equal(Month.new(2001, 2))
  end

  it 'returns the month of the given integer unix timestamp' do
    Month(1234567890).must_equal(Month.new(2009, 2))
  end

  it 'idempotently returns the given month' do
    month = Month.new(2014, 1)

    Month(month).object_id.must_equal(month.object_id)
  end
end

describe 'A method defined in Month::Methods' do
  include Month::Methods

  it 'returns a month object denoting that month in the given year' do
    month = January 2014
    month.must_equal(Month.new(2014, 1))

    month = February 2014
    month.must_equal(Month.new(2014, 2))
  end

  it 'returns a date object when given two arguments' do
    date = January 31, 2014
    date.must_equal(Date.new(2014, 1, 31))

    date = February 28, 2014
    date.must_equal(Date.new(2014, 2, 28))
  end

  it 'raises an exception if given too many arguments' do
    proc { January 1, 2, 3 }.must_raise(ArgumentError)
  end
end
