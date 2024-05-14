#!/usr/bin/env ruby
# frozen_string_literal: true

scores = ARGV[0].split(',')
shots = []
frame_count = 1
shots_in_frame = []

scores.each do |score|
  score_number = score == 'X' ? 10 : score.to_i
  shots_in_frame << score_number
  shots_in_frame << 0 if score_number == 10 && frame_count < 10 && shots_in_frame.length < 2

  if shots_in_frame.length == 2
    shots << shots_in_frame.dup
    shots_in_frame.clear
    frame_count += 1
  end

  shots << shots_in_frame.dup if frame_count > 10
end

point = 0

shots.each_with_index do |frame, index|
  next point += frame.sum if frame[0] != 10 && frame.sum != 10

  point += if index < 8
             if frame[0] == 10
               if shots[index + 1][0] == 10
                 20 + shots[index + 2][0]
               else
                 10 + shots[index + 1].sum
               end
             else
               10 + shots[index + 1][0]
             end
           elsif index == 8
             if frame[0] == 10
               10 + shots[9].sum
             else
               10 + shots[9][0]
             end
           else
             frame.sum
           end
end

puts point
