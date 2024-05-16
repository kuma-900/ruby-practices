#!/usr/bin/env ruby
# frozen_string_literal: true

scores = ARGV[0].split(',')
shots = []
shots_in_frame = []

scores.each do |score|
  score_number = score == 'X' ? 10 : score.to_i
  shots_in_frame << score_number
  shots_in_frame << 0 if score_number == 10 && shots.length < 9 && shots_in_frame.length < 2

  if shots_in_frame.length == 2
    shots << shots_in_frame.dup
    shots_in_frame.clear
  end

  shots << shots_in_frame.dup if shots.length >= 10 && shots_in_frame.length.positive?
end

point = 0

shots.each_with_index do |frame, index|
  point += frame.sum
  next if (frame[0] != 10 && frame.sum != 10) || index > 8

  if frame[0] == 10
    point += shots[index + 1].sum
    point += shots[index + 2][0] if index < 8 && shots[index + 1][0] == 10
  else
    point += shots[index + 1][0]
  end
end

puts point
