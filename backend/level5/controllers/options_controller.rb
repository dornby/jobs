# frozen_string_literal: true

require 'json'
require_relative '../models/option'

# This class is the intermediary between our data & our main.rb for cars
class OptionsController
  def initialize
    file = File.read('data/input.json')
    @data_input = JSON.parse(file)
  end

  def all
    options = []
    @data_input['options'].map do |option_params|
      options << Option.new(option_params)
    end
    options
  end
end
