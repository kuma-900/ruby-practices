# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(frame_shots, frame_index)
    @frame_shots = frame_shots
    @frame_index = frame_index
  end

  def frame_score(all_shots)
    base_score + bonus_score(all_shots)
  end

  private

  def base_score
    @frame_shots.sum(&:score)
  end

  def bonus_score(all_shots)
    return 0 if final_frame?

    first_shot_index = @frame_shots[0].shot_index

    if strike?
      # ストライク: 次の2投分をボーナス加算
      all_shots[first_shot_index + 1].score + all_shots[first_shot_index + 2].score
    elsif spare?
      # スペア: 次の1投分をボーナス加算
      all_shots[first_shot_index + 2].score
    else
      0
    end
  end

  def strike?
    @frame_shots.size == 1 && base_score == 10
  end

  def spare?
    @frame_shots.size == 2 && base_score == 10
  end

  def final_frame?
    @frame_index == 9
  end
end
