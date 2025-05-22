# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(frame_shots)
    @frame_shots = frame_shots
  end

  def base_score
    @frame_shots.sum(&:score)
  end
end
