require 'date'

class Month
  NAMES = {
    1 => :January,
    2 => :February,
    3 => :March,
    4 => :April,
    5 => :May,
    6 => :June,
    7 => :July,
    8 => :August,
    9 => :September,
    10 => :October,
    11 => :November,
    12 => :December
  }

  def initialize(year, number)
    unless NAMES.has_key?(number)
      raise ArgumentError, 'invalid month number'
    end

    @year, @number = year, number
  end

  attr_reader :year, :number

  def to_s
    "#@year-#{@number.to_s.rjust(2, '0')}"
  end

  def name
    NAMES.fetch(@number)
  end

  NAMES.each do |number, name|
    define_method(:"#{name.downcase}?") do
      @number == number
    end
  end

  def hash
    [@year, @number].hash
  end

  def eql?(object)
    object.class == self.class && object.hash == self.hash
  end

  def <=>(month)
    if @year == month.year
      @number <=> month.number
    else
      @year <=> month.year
    end
  end

  include Comparable

  def next
    if @number == 12
      self.class.new(@year + 1, 1)
    else
      self.class.new(@year, @number + 1)
    end
  end

  alias_method :succ, :next

  def step(limit)
    unless block_given?
      return enum_for(:step, limit)
    end

    month = self

    until month > limit
      yield month

      month = month.succ
    end
  end

  def +(number)
    a, b = (@number - 1 + number).divmod(12)
    self.class.new(@year + a, b + 1)
  end

  def -(number)
    if @number > number
      self.class.new(@year, @number - number)
    elsif @number < number
      a, b = (@number - number).divmod(12)

      self.class.new(@year + a, b)
    else
      self.class.new(@year - 1, 12)
    end
  end

  def include?(date)
    @year == date.year && @number == date.month
  end

  alias_method :===, :include?

  def start_date
    Date.new(@year, @number, 1)
  end

  def end_date
    Date.new(@year, @number, -1)
  end

  def dates
    start_date .. end_date
  end

  def length
    end_date.mday
  end
end

def Month.parse(string)
  if string =~ /\A(\d{4})-(\d{2})\z/
    Month.new($1.to_i, $2.to_i)
  else
    raise ArgumentError, 'invalid month'
  end
end

def Month(object)
  case object
  when Month
    object
  when Integer
    Month(Time.at(object))
  else
    Month.new(object.year, object.month)
  end
end

class Month
  module Methods
    NAMES.each do |number, name|
      define_method(name) do |*args|
        case args.length
        when 1
          Month.new(args.first, number)
        when 2
          Date.new(args[1], number, args[0])
        else
          raise ArgumentError, 'too many arguments'
        end
      end
    end
  end
end
