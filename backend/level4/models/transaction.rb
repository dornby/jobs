# frozen_string_literal: true

# This class instantiates Transaction objects
class Transaction
  def initialize(attributes = {})
    @actor = attributes[:actor]
    @rental = attributes[:rental]
  end

  def type
    @actor == 'driver' ? 'debit' : 'credit'
  end

  def amount
    case @actor
    when 'driver'
      @rental.price
    when 'owner'
      @rental.owner_share
    when 'insurance'
      @rental.insurance_fee
    when 'assistance'
      @rental.assistance_fee
    when 'drivy'
      @rental.drivy_fee
    end
  end
end
