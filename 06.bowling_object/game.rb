# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(input_marks)
    @all_shots = input_marks.split(',').map.with_index { |mark, shot_index| Shot.new(mark, shot_index) }
    @frames = build_frames
  end

  def score
    @frames.sum { |frame| frame.frame_score(@all_shots) }
  end

  private

  # 入力された全投球(@all_shots)から10個のFrameオブジェクトを配列として生成する
  def build_frames
    frames = []
    frame_index = 0
    shot_index = 0

    # 1〜9フレーム目はストライク(1投)か、2投でフレームを分割する
    while frame_index < 9
      if @all_shots[shot_index].score == 10
        frames << Frame.new([@all_shots[shot_index]], frame_index)
        shot_index += 1
      else
        frames << Frame.new(@all_shots[shot_index, 2], frame_index)
        shot_index += 2
      end
      frame_index += 1
    end

    # 10フレーム目は残り全ての投球
    frames << Frame.new(@all_shots[shot_index..], 9)

    frames
  end
end
