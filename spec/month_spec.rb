require_relative '../lib/month'
require_relative '../lib/month/yaml'

RSpec.describe 'Month' do
  describe '#initialize' do
    it 'returns frozen instances' do
      month = Month.new(2017, 1)

      expect(month.frozen?).to eq(true)
    end

    context 'with an invalid number' do
      it 'raises an exception' do
        expect { Month.new(2014, 0) }.to raise_error(ArgumentError)
        expect { Month.new(2014, 100) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#year' do
    it 'returns the integer year of the month' do
      expect(Month.new(2014, 1).year).to eq(2014)
    end
  end

  describe '#number' do
    it 'returns the integer number of the month' do
      expect(Month.new(2014, 1).number).to eq(1)
    end
  end

  describe '#month' do
    it 'returns the integer number of the month' do
      expect(Month.new(2014, 1).month).to eq(1)
    end
  end

  describe '#to_s' do
    it 'returns a string containing the year and zero padded number of the month' do
      expect(Month.new(2014, 1).to_s).to eq('2014-01')
    end
  end

  describe '#iso8601' do
    it 'returns a string containing the year and zero padded number of the month' do
      expect(Month.new(2014, 1).iso8601).to eq('2014-01')
    end
  end

  describe '#name' do
    it 'returns the name of the month' do
      expect(Month.new(2014, 1).name).to eq(:January)
    end
  end

  describe '#january?' do
    it 'returns true if the month is january' do
      expect(Month.new(2014, 1).january?).to eq(true)
    end

    it 'returns false otherwise' do
      expect(Month.new(2014, 2).january?).to eq(false)
    end
  end

  describe '#february?' do
    it 'returns true if the month is february' do
      expect(Month.new(2014, 2).february?).to eq(true)
    end

    it 'returns false otherwise' do
      expect(Month.new(2014, 1).february?).to eq(false)
    end
  end

  describe '#hash and #eql?' do
    it 'supports being used as a hash key' do
      hash, n = Hash.new(0), 10

      n.times { hash[Month.new(2014, 1)] += 1 }

      expect(hash.count).to eq(1)
      expect(hash[Month.new(2014, 1)]).to eq(n)
    end
  end

  describe '#<=>' do
    it 'supports comparison between month objects' do
      expect(Month.new(2014, 1)).to be_kind_of(Comparable)

      expect(Month.new(2014, 1) == Month.new(2014, 1)).to eq(true)
      expect(Month.new(2014, 1) == Month.new(2014, 2)).to eq(false)

      expect(Month.new(2014, 1) < Month.new(2014, 2)).to eq(true)
      expect(Month.new(2014, 2) > Month.new(2014, 1)).to eq(true)
    end

    it 'supports comparison with nil' do
      expect(Month.new(2014, 1) == nil).to eq(false)
    end

    it 'supports being used in a range' do
      range = Month.new(2014, 1) .. Month.new(2014, 4)

      expect(range.map(&:number)).to eq([1, 2, 3, 4])
    end
  end

  describe '#next' do
    it 'returns a month object denoting the next month' do
      expect(Month.new(2014, 1).next).to eq(Month.new(2014, 2))
      expect(Month.new(2014, 12).next).to eq(Month.new(2015, 1))
    end
  end

  describe '#succ' do
    it 'returns a month object denoting the next month' do
      expect(Month.new(2014, 1).succ).to eq(Month.new(2014, 2))
      expect(Month.new(2014, 12).succ).to eq(Month.new(2015, 1))
    end
  end

  describe '#next_month' do
    it 'returns a month object denoting the next month' do
      expect(Month.new(2014, 1).next_month).to eq(Month.new(2014, 2))
      expect(Month.new(2014, 12).next_month).to eq(Month.new(2015, 1))
    end
  end

  describe '#prev_month' do
    it 'returns a month object denoting the previous month' do
      expect(Month.new(2014, 1).prev_month).to eq(Month.new(2013, 12))
      expect(Month.new(2014, 12).prev_month).to eq(Month.new(2014, 11))
    end
  end

  describe '#>>' do
    it 'returns a month object denoting n months after' do
      expect(Month.new(2014, 1) >> 5).to eq(Month.new(2014, 6))
      expect(Month.new(2014, 12) >> 5).to eq(Month.new(2015, 5))
      expect(Month.new(2014, 12) >> -5).to eq(Month.new(2014, 7))
    end
  end

  describe '#<<' do
    it 'returns a month object denoting n months before' do
      expect(Month.new(2014, 1) << 5).to eq(Month.new(2013, 8))
      expect(Month.new(2014, 12) << 5).to eq(Month.new(2014, 7))
      expect(Month.new(2014, 12) << -5).to eq(Month.new(2015, 5))
    end
  end

  describe '#step' do
    it 'calls the block for every month until the given limit' do
      months = []

      Month.new(2014, 1).step(Month.new(2014, 3)) { |month| months << month }

      expect(months).to eq([Month.new(2014, 1), Month.new(2014, 2), Month.new(2014, 3)])
    end

    context 'without a block' do
      it 'returns an enumerator' do
        months = Month.new(2014, 1).step(Month.new(2014, 3))

        expect(months).to be_instance_of(Enumerator)

        expect(months.next).to eq(Month.new(2014, 1))
        expect(months.next).to eq(Month.new(2014, 2))
        expect(months.next).to eq(Month.new(2014, 3))
      end
    end

    context 'with a zero step argument' do
      it 'raises an exception' do
        expect { Month.new(2014, 1).step(Month.new(2014, 3), 0) }.to raise_error(ArgumentError)
      end
    end

    context 'with a positive step argument' do
      it 'increases by the given number of months' do
        months = []

        Month.new(2014, 1).step(Month.new(2014, 3), 2) { |month| months << month }

        expect(months).to eq([Month.new(2014, 1), Month.new(2014, 3)])
      end
    end

    context 'with a negative step argument' do
      it 'decreases by the given number of months' do
        months = []

        Month.new(2014, 3).step(Month.new(2014, 1), -1) { |month| months << month }

        expect(months).to eq([Month.new(2014, 3), Month.new(2014, 2), Month.new(2014, 1)])
      end
    end
  end

  describe '#upto' do
    it 'calls the block for every month until the given limit' do
      months = []

      Month.new(2014, 1).upto(Month.new(2014, 3)) { |month| months << month }

      expect(months).to eq([Month.new(2014, 1), Month.new(2014, 2), Month.new(2014, 3)])
    end

    context 'without a block' do
      it 'returns an enumerator' do
        months = Month.new(2014, 1).upto(Month.new(2014, 3))

        expect(months).to be_instance_of(Enumerator)

        expect(months.next).to eq(Month.new(2014, 1))
        expect(months.next).to eq(Month.new(2014, 2))
        expect(months.next).to eq(Month.new(2014, 3))
      end
    end
  end

  describe '#downto' do
    it 'calls the block for every month until the given limit' do
      months = []

      Month.new(2014, 3).downto(Month.new(2014, 1)) { |month| months << month }

      expect(months).to eq([Month.new(2014, 3), Month.new(2014, 2), Month.new(2014, 1)])
    end

    context 'without a block' do
      it 'returns an enumerator' do
        months = Month.new(2014, 3).downto(Month.new(2014, 1))

        expect(months).to be_instance_of(Enumerator)

        expect(months.next).to eq(Month.new(2014, 3))
        expect(months.next).to eq(Month.new(2014, 2))
        expect(months.next).to eq(Month.new(2014, 1))
      end
    end
  end

  describe '#+' do
    it 'returns a month object denoting the given number of months after self' do
      expect(Month.new(2014, 1) + 1).to eq(Month.new(2014, 2))
      expect(Month.new(2014, 1) + 12).to eq(Month.new(2015, 1))
      expect(Month.new(2014, 1) + 18).to eq(Month.new(2015, 7))
      expect(Month.new(2013, 11) + 1).to eq(Month.new(2013, 12))
      expect(Month.new(2013, 11) + 2).to eq(Month.new(2014, 1))
    end
  end

  describe '#-' do
    it 'returns a month object denoting the given number of months before self' do
      expect(Month.new(2014, 2) - 1).to eq(Month.new(2014, 1))
      expect(Month.new(2014, 1) - 1).to eq(Month.new(2013, 12))
      expect(Month.new(2014, 1) - 12).to eq(Month.new(2013, 1))
      expect(Month.new(2014, 1) - 18).to eq(Month.new(2012, 7))
      expect(Month.new(2013, 12) - 1).to eq(Month.new(2013, 11))
      expect(Month.new(2014, 1) - 2).to eq(Month.new(2013, 11))
    end

    it 'returns the number of months between the given month and self' do
      expect(Month.new(2014, 3) - Month.new(2014, 1)).to eq(2)
      expect(Month.new(2015, 1) - Month.new(2014, 1)).to eq(12)
      expect(Month.new(2077, 4) - Month.new(2070, 4)).to eq(84)
    end
  end

  describe '#include?' do
    it 'returns true if the month includes the given time or date' do
      expect(Month.new(2014, 1).include?(Time.local(2014, 1, 1))).to eq(true)
      expect(Month.new(2014, 1).include?(Date.new(2014, 1, 1))).to eq(true)
    end

    it 'returns false otherwise' do
      expect(Month.new(2014, 1).include?(Date.new(2014, 2, 1))).to eq(false)
    end
  end

  describe '#===' do
    it 'returns true if the month includes the given date' do
      expect(Month.new(2014, 1) === Date.new(2014, 1, 1)).to eq(true)
    end

    it 'returns false otherwise' do
      expect(Month.new(2014, 1) === Date.new(2014, 2, 1)).to eq(false)
    end
  end

  describe '#start_date' do
    it 'returns a date object denoting the first day of the month' do
      expect(Month.new(2014, 1).start_date).to eq(Date.new(2014, 1, 1))
    end
  end

  describe '#end_date' do
    it 'returns a date object denoting the last day of the month' do
      expect(Month.new(2014, 1).end_date).to eq(Date.new(2014, 1, 31))
    end
  end

  describe '#dates' do
    it 'returns the range of dates in the month' do
      dates = Month.new(2014, 1).dates
      expect(dates).to be_instance_of(Range)
      expect(dates.count).to eq(31)
      expect(dates.all? { |date| Date === date }).to eq(true)
      expect(dates.first).to eq(Date.new(2014, 1, 1))
      expect(dates.last).to eq(Date.new(2014, 1, 31))
    end
  end

  describe '#length' do
    it 'returns the integer number of days in the month' do
      expect(Month.new(2014, 1).length).to eq(31)
      expect(Month.new(2014, 2).length).to eq(28)
    end
  end
end

RSpec.describe 'Month.parse method' do
  it 'returns the month corresponding to the given string representation' do
    expect(Month.parse('2014-01')).to eq(Month.new(2014, 1))
    expect(Month.parse('2014 JAN')).to eq(Month.new(2014, 1))
    expect(Month.parse('January 2014')).to eq(Month.new(2014, 1))
  end

  it 'raises an exception if the format of the string is not as expected' do
    expect { Month.parse('Other') }.to raise_error(ArgumentError)
  end
end

RSpec.describe 'Month method' do
  it 'returns the month of the given date object' do
    expect(Month(Date.new(2014, 1, 1))).to eq(Month.new(2014, 1))
  end

  it 'returns the month of the given time object' do
    expect(Month(Time.at(1234567890))).to eq(Month.new(2009, 2))
  end

  it 'returns the month of the given datetime object' do
    expect(Month(DateTime.parse('2001-02-03T04:05:06+07:00'))).to eq(Month.new(2001, 2))
  end

  it 'returns the month of the given integer unix timestamp' do
    expect(Month(1234567890)).to eq(Month.new(2009, 2))
  end

  it 'returns the given month idempotently' do
    month = Month.new(2014, 1)

    expect(Month(month).object_id).to eq(month.object_id)
  end
end

RSpec.describe 'Month.today method' do
  let(:current_date) { Date.today }
  let(:current_month) { Month.new(current_date.year, current_date.month) }

  it 'returns the current month' do
    expect(Month.today).to eq(current_month)
  end
end

RSpec.describe 'Month.now method' do
  let(:current_time) { Time.now }
  let(:current_month) { Month.new(current_time.year, current_time.month) }

  it 'returns the current month' do
    expect(Month.now).to eq(current_month)
  end
end

RSpec.describe 'A method defined in Month::Methods' do
  include Month::Methods

  context 'with one argument' do
    it 'returns a month object' do
      month = January 2014
      expect(month).to eq(Month.new(2014, 1))

      month = February 2014
      expect(month).to eq(Month.new(2014, 2))
    end
  end

  context 'with two arguments' do
    it 'returns a date object' do
      date = January 31, 2014
      expect(date).to eq(Date.new(2014, 1, 31))

      date = February 28, 2014
      expect(date).to eq(Date.new(2014, 2, 28))
    end
  end

  context 'with too many arguments' do
    it 'raises an exception' do
      expect { January 1, 2, 3 }.to raise_error(ArgumentError)
    end
  end
end

RSpec.describe 'YAML' do
  let(:month) { Month.new(2014, 1) }

  it 'dumps month objects' do
    expect(YAML.dump([month])).to eq("---\n- 2014-01\n")
  end

  it 'loads month objects' do
    expect(YAML.load("---\n- 2014-01\n")).to eq([month])
  end
end
