#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
frame_count = 1

total_shots = 0

scores.each do |s|
  break if frame_count == 10 && total_shots >= 3

  if frame_count < 10
    if s == 'X'
      shots << 10
      shots << 0
      frame_count += 1
    else
      shots << s.to_i
      frame_count += 1 if shots.size.even?
    end
  elsif frame_count == 10
    shots << if s == 'X'
               10
             else
               s.to_i
             end
    total_shots += 1
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0

frames.each_with_index do |frame, index|
  if index < 8
    point += if frame[0] == 10
               if frames[index + 1][0] == 10
                 20 + frames[index + 2][0]
               else
                 10 + frames[index + 1].sum
               end
             elsif frame.sum == 10
               10 + frames[index + 1][0]
             else
               frame.sum
             end
  elsif index == 8
    point += if frame[0] == 10
               10 + frames[9].sum
             elsif frame.sum == 10
               10 + frames[9][0]
             else
               frame.sum
             end
  elsif index == 9
    point += frame.sum
  elsif index == 10
    point += frame[0] if frames[9][0] == 10 || frames[9].sum == 10
  end
end

puts point
