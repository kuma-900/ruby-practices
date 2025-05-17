# frozen_string_literal: true

class Shot
  attr_reader :shot_index, :score

  def initialize(mark, shot_index)
    @shot_index = shot_index
    @score = mark == 'X' ? 10 : mark.to_i
  end
end
