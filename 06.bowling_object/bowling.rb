#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'game'

input_marks = ARGV[0]
game = Game.new(input_marks)
puts game.score
