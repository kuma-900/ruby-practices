#!/usr/bin/env ruby
# frozen_string_literal: true

scores = ARGV[0].split(',')
shots = []
frame_count = 1
total_shots = 0

scores.each do |score|
  break if frame_count == 10 && total_shots >= 3

  if frame_count < 10
    if score == 'X'
      shots << 10
      shots << 0
      frame_count += 1
    else
      shots << s.to_i
      frame_count += 1 if shots.size.even?
    end
  elsif frame_count == 10
    shots << (score == 'X' ? 10 : score.to_i)
    total_shots += 1
  end
end

frames = shots.each_slice(2).to_a

point = 0

frames.each_with_index do |frame, index|
  next point += frame.sum if frame[0] != 10 && frame.sum != 10

  point += if index < 8
             if frame[0] == 10
               if frames[index + 1][0] == 10
                 20 + frames[index + 2][0]
               else
                 10 + frames[index + 1].sum
               end
             else
               10 + frames[index + 1][0]
             end
           elsif index == 8
             if frame[0] == 10
               10 + frames[9].sum
             else
               10 + frames[9][0]
             end
           else
             frame.sum
           end
end

puts point
