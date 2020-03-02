# frozen_string_literal: true

require 'json'
require_relative 'cars_controller'
require_relative 'options_controller'
require_relative '../models/rental'
require_relative '../models/transaction'
require_relative '../models/option'

# This class is the intermediary between our data & our main.rb for rentals
class RentalsController
  def initialize
    @cars_controller = CarsController.new
    @options_controller = OptionsController.new
    file = File.read('data/input.json')
    @data_input = JSON.parse(file)
    @actors = %w[driver owner insurance assistance drivy]
  end

  def all
    rentals = []
    @data_input['rentals'].each do |rental_params|
      rental = Rental.new(rental_params)
      rental.car = @cars_controller.all.find { |car| rental.car_id == car.id }
      rental_options = options(rental)
      rental.charge_options(rental_options)
      rentals << {
        "id": rental.id,
        "options": options_to_json(rental),
        "actions": actions_to_json(rental)
      }
    end
    rentals
  end

  private

  def actions_to_json(rental)
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

  def options_to_json(rental)
    options(rental).map(&:type)
  end

  def options(rental)
    @options_controller.all.select do |option|
      option.rental_id == rental.id
    end
  end
end
