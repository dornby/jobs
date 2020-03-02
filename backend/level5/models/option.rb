# frozen_string_literal: true

# This class instantiates Option objects
class Option
  attr_reader :rental_id, :type
  attr_writer :rental
  OPTIONS_DATA = {
    gps: {
      price: 500,
      beneficiary: 'owner'
    },
    baby_seat: {
      price: 200,
      beneficiary: 'owner'
    },
    additional_insurance: {
      price: 1000,
      beneficiary: 'drivy'
    }
  }.freeze

  def initialize(attributes = {})
    @id = attributes['id']
    @rental_id = attributes['rental_id']
    @type = attributes['type']
    @price = OPTIONS_DATA[@type.to_sym][:price]
    @beneficiary = OPTIONS_DATA[@type.to_sym][:beneficiary]
  end

  def charge(rental)
    rental.increment_options_amount(@beneficiary, total_amount(rental))
  end

  private

  def total_amount(rental)
    @price * rental.duration
  end
end
