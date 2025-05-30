# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(input_marks)
    @all_shots = input_marks.split(',').map { |mark| Shot.new(mark) }
    @frames = build_frames
  end

  def score
    points = 0
    shot_index = 0

    @frames.each_with_index do |frame, frame_index|
      points += frame.base_score
      shot_index += frame.shots_count

      next if frame_index == 9 || (!frame.strike? && !frame.spare?)

      # ストライクは次の2投、スペアは次の1投がボーナス対象
      bonus_count = frame.strike? ? 2 : 1
      bonus_shots = @all_shots[shot_index, bonus_count]
      points += frame.bonus_score(bonus_shots)
    end

    points
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
