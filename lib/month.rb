# frozen_string_literal: true
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
    unless NAMES.key?(number)
      raise ArgumentError, 'invalid month number'
    end

    @year, @number = year, number

    freeze
  end

  attr_reader :year, :number

  alias_method :month, :number

  def to_s
    "#{@year}-#{@number.to_s.rjust(2, '0')}"
  end

  alias_method :iso8601, :to_s

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
    return unless month.class == self.class

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

  alias_method :next_month, :next

  def prev_month
    self - 1
  end

  def >>(n)
    self + n
  end

  def <<(n)
    self - n
  end

  def step(limit, step = 1)
    raise ArgumentError if step.zero?

    unless block_given?
      return enum_for(:step, limit, step)
    end

    month = self

    if step > 0
      until month > limit
        yield month

        month += step
      end
    else
      until month < limit
        yield month

        month += step
      end
    end
  end

  def upto(max, &block)
    step(max, 1, &block)
  end

  def downto(min, &block)
    step(min, -1, &block)
  end

  def +(number)
    a, b = (@number - 1 + number).divmod(12)

    self.class.new(@year + a, b + 1)
  end

  def -(object)
    if object.is_a?(Integer)
      self + (-object)
    else
      12 * (year - object.year) + (@number - object.number)
    end
  end

  def include?(time)
    @year == time.year && @number == time.month
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

class Month
  ABBREVIATIONS = {
    'JAN' => 1,
    'FEB' => 2,
    'MAR' => 3,
    'APR' => 4,
    'MAY' => 5,
    'JUN' => 6,
    'JUL' => 7,
    'AUG' => 8,
    'SEP' => 9,
    'OCT' => 10,
    'NOV' => 11,
    'DEC' => 12,
  }

  REGEXP1 = /\A(\d{4})-(\d{2})\z/
  REGEXP2 = /\A(\d{4}) (#{ABBREVIATIONS.keys.join('|')})\z/
  REGEXP3 = /\A(#{Date::MONTHNAMES.compact.join('|')}) (\d{4})\z/

  private_constant :ABBREVIATIONS
  private_constant :REGEXP1
  private_constant :REGEXP2
  private_constant :REGEXP3

  def self.parse(string)
    case string
    when REGEXP1
      Month.new($1.to_i, $2.to_i)
    when REGEXP2
      Month.new($1.to_i, ABBREVIATIONS.fetch($2))
    when REGEXP3
      Month.new($2.to_i, Date::MONTHNAMES.index($1))
    else
      raise ArgumentError, 'invalid month'
    end
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

def Month.now
  Month(Time.now)
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
