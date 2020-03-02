# frozen_string_literal: true

require 'json'
require_relative 'cars_controller'
require_relative '../models/rental'
require_relative '../models/transaction'

# This class is the intermediary between our data & our main.rb for rentals
class RentalsController
  def initialize
    @cars_controller = CarsController.new
    file = File.read('data/input.json')
    @data_input = JSON.parse(file)
    @actors = %w[driver owner insurance assistance drivy]
  end

  def all
    rentals = []
    @data_input['rentals'].each do |rental_params|
      rental = Rental.new(rental_params)
      rental.car = @cars_controller.all.find { |car| rental.car_id == car.id }
      rentals << {
        "id": rental.id,
        "actions": actions(rental)
      }
    end
    rentals
  end

  private

  def actions(rental)
    actions = []
    @actors.each do |actor|
      transaction = Transaction.new(rental: rental, actor: actor)
      actions << {
        "who": actor,
        "type": transaction.type,
        "amount": transaction.amount
      }
    end
    actions
  end
end
