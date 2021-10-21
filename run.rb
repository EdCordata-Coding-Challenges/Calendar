require 'date'

class PrintCalendar
  DAYS_OF_THE_WEEK = %w[Mon Tue Wed Thu Fri Sat Sun].freeze


  def initialize(date = nil)
    @date = date || Date.today
  end


  def build
    @res = build_result_hash
    fill_empty_start_days
    fill_calendar_days
    fill_empty_end_days
    print_output
  end


  private


  def build_result_hash
    Hash[DAYS_OF_THE_WEEK.map { |x| [x, []] }]
  end


  def fill_empty_start_days
    DAYS_OF_THE_WEEK
      .slice(0, DAYS_OF_THE_WEEK.find_index(get_day_name(1)))
      .each { |day_name| @res[day_name.to_s] << nil }
  end


  def fill_calendar_days
    (1..get_days_in_month).to_a.each do |date_nr|
      @res[get_day_name(date_nr)] << date_nr
    end
  end


  def fill_empty_end_days
    last_date_day_index = DAYS_OF_THE_WEEK.find_index(get_day_name(get_days_in_month))

    DAYS_OF_THE_WEEK
      .slice(last_date_day_index, DAYS_OF_THE_WEEK.length)
      .each { |day_name| @res[day_name] << nil }
  end


  def print_output
    weeks_in_month = @res[@res.keys.first].length

    puts [ @date.strftime('%B'), @date.strftime('%Y') ].join(' ').center(20)

    puts DAYS_OF_THE_WEEK.map { |val| val.slice(0, 2).center(3) }
                         .join('')

    (1..weeks_in_month).each do |week_nr|
      puts DAYS_OF_THE_WEEK.map { |day_name| @res[day_name][week_nr - 1] }
                           .map { |val|      val.to_s.center(3)          }
                           .join('')
    end
  end


  def get_day_name(day)
    Date.new(@date.year, @date.month, day).strftime('%a')
  end


  def get_days_in_month
    Date.new(@date.year, @date.month, -1).day
  end


end


PrintCalendar.new(Date.today).build
