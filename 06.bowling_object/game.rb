# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(input_marks)
    @all_shots = input_marks.split(',').map { |mark| Shot.new(mark) }
    @frames = build_frames
  end

  def score
    base_total = @frames.sum(&:base_score)

    bonus_total = 0
    shot_index = 0
    frame_index = 0

    while frame_index < 9
      if @all_shots[shot_index].score == 10
        bonus_total += @all_shots[shot_index + 1, 2].sum(&:score)
        shot_index += 1
      else
        shots = @all_shots[shot_index, 2]
        bonus_total += @all_shots[shot_index + 2].score if shots.sum(&:score) == 10
        shot_index += 2
      end

      frame_index += 1
    end

    base_total + bonus_total
  end

  private

  # 入力された全投球(@all_shots)から10個のFrameオブジェクトを配列として生成する
  def build_frames
    frames = []
    shot_index = 0

    # 1〜9フレーム目はストライク(1投)か、2投でフレームを分割する
    while frames.size < 9
      if @all_shots[shot_index].score == 10
        frames << Frame.new([@all_shots[shot_index]])
        shot_index += 1
      else
        shots = @all_shots[shot_index, 2]
        frames << Frame.new(shots)
        shot_index += 2
      end
    end

    # 10フレーム目は残り全ての投球
    frames << Frame.new(@all_shots[shot_index..])

    frames
  end
end
