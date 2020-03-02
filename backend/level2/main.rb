# frozen_string_literal: true

require 'json'
require_relative 'controllers/rentals_controller'

rentals_controller = RentalsController.new

File.open('data/output.json', 'w') do |f|
  f << JSON.pretty_generate({ rentals: rentals_controller.all })
end
