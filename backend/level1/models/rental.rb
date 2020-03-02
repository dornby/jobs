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
    (duration * @car.price_per_day)
  end

  def distance_price
    distance * @car.price_per_km
  end
end
