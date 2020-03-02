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
  end

  def price
    duration_price + distance_price
  end

  private

  def duration
    ((@end_date - @start_date).fdiv(1) + 1).to_i
  end

  def duration_price
    duration_price = 0
    duration.times do |day|
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
end
