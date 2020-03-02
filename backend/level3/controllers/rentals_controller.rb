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
      rentals << {
        "id": rental.id,
        "price": rental.price,
        "commission": commission(rental)
      }
    end
    rentals
  end

  private

  def commission(rental)
    {
      "insurance_fee": rental.insurance_fee,
      "assistance_fee": rental.assistance_fee,
      "drivy_fee": rental.drivy_fee
    }
  end
end
