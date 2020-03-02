# frozen_string_literal: true

require 'json'
require_relative 'cars_controller'
require_relative '../models/rental'

# This class is the intermediary between our data & our main.rb for rentals
class RentalsController
  def initialize
    @cars_controller = CarsController.new
    file = File.read('data/input.json')
    @data_input = JSON.parse(file)
  end

  def all
    rentals = []
    @data_input['rentals'].each do |rental_params|
      rental = Rental.new(rental_params)
      rental.car = @cars_controller.all.find { |car| rental.car_id == car.id }
      rentals << { "id": rental.id, "price": rental.price }
    end
    rentals
  end
end
