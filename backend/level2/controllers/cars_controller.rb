# frozen_string_literal: true

require 'json'
require_relative '../models/car'

# This class is the intermediary between our data & our main.rb for cars
class CarsController
  def initialize
    file = File.read('data/input.json')
    @data_input = JSON.parse(file)
  end

  def all
    cars = []
    @data_input['cars'].each do |car_params|
      cars << Car.new(car_params)
    end
    cars
  end
end
