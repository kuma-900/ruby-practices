# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(frame_shots)
    @frame_shots = frame_shots
  end

  def shots_count
    @frame_shots.size
  end

  def base_score
    @frame_shots.sum(&:score)
  end

  def strike?
    shots_count == 1 && base_score == 10
  end

  def spare?
    shots_count == 2 && base_score == 10
  end

  def bonus_score(bonus_shots)
    bonus_shots.sum(&:score)
  end
end
