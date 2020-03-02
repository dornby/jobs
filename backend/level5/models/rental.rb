# frozen_string_literal: true

require 'date'

# This class instantiates Rental objects
class Rental
  attr_reader :id, :car_id, :distance
  attr_accessor :car

  def initialize(attributes = {})
    @id = attributes['id']
    @car_id = attributes['car_id']
    @start_date = DateTime.parse(attributes['start_date'])
    @end_date = DateTime.parse(attributes['end_date'])
    @distance = attributes['distance']
    @car = attributes['car']
    @owner_options_amount = 0
    @drivy_options_amount = 0
  end

  def price_before_options
    duration_price + distance_price
  end

  def price
    price_before_options + options_total_amount
  end

  def owner_share
    (price_before_options - commission + @owner_options_amount).to_i
  end

  def insurance_fee
    (commission * 0.5).to_i
  end

  def assistance_fee
    100 * duration.to_i
  end

  def drivy_fee
    (commission - insurance_fee - assistance_fee + @drivy_options_amount).to_i
  end

  def duration
    ((@end_date - @start_date).fdiv(1) + 1).to_i
  end

  def increment_options_amount(beneficiary, total_amount)
    if beneficiary == 'owner'
      @owner_options_amount += total_amount
    else
      @drivy_options_amount += total_amount
    end
  end

  def charge_options(options)
    options.each { |option| option.charge(self) }
  end

  private

  def duration_price
    duration_price = 0
    duration.to_i.times do |day|
      duration_price += (@car.price_per_day * degressivity(day)).to_i
    end
    duration_price
  end

  def distance_price
    distance * @car.price_per_km
  end

  def degressivity(day)
    case day
    when 0
      1
    when 1..3
      0.9
    when 4..9
      0.7
    else
      0.5
    end
  end

  def commission
    price_before_options * 0.3
  end

  def options_total_amount
    @owner_options_amount + @drivy_options_amount
  end
end
