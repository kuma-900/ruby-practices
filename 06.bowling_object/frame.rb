# frozen_string_literal: true

require_relative 'shot'

class Frame
  MAX_PIN = 10

  attr_reader :shots

  def initialize(shots)
    @shots = shots
  end

  def strike?
    shots.size == 1 && shots.sum(&:score) == MAX_PIN
  end

  def spare?
    shots.size == 2 && shots.sum(&:score) == MAX_PIN
  end

  def bonus_score(bonus_shots)
    bonus_shots.sum(&:score)
  end
end
