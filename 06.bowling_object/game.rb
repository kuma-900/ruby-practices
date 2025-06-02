# frozen_string_literal: true

require_relative 'frame'

class Game
  TOTAL_FRAMES = 10
  FINAL_FRAME_INDEX = TOTAL_FRAMES - 1
  STRIKE_BONUS_SHOTS = 2
  SPARE_BONUS_SHOTS = 1

  def initialize(input_marks)
    all_shots = input_marks.split(',').map { |mark| Shot.new(mark) }
    @frames = build_frames(all_shots)
  end

  def score
    points = 0

    @frames.each_with_index do |frame, frame_index|
      points += frame.shots.sum(&:score)

      next if frame_index == FINAL_FRAME_INDEX || frame.open?

      # ストライクは次の STRIKE_BONUS_SHOTS 投、スペアでは次の SPARE_BONUS_SHOTS 投がボーナス対象
      bonus_count = frame.strike? ? STRIKE_BONUS_SHOTS : SPARE_BONUS_SHOTS

      next_shots = @frames[(frame_index + 1)..(frame_index + 2)].flat_map(&:shots)
      bonus_shots = next_shots[0, bonus_count]
      points += frame.bonus_score(bonus_shots)
    end

    points
  end

  private

  # 入力された全投球(all_shots)からTOTAL_FRAMES個のFrameオブジェクトを配列として生成する
  def build_frames(all_shots)
    frames = []
    shot_index = 0

    # 最終フレーム以外はストライク(1投)か、2投でフレームを分割する
    while frames.size < FINAL_FRAME_INDEX
      if all_shots[shot_index].score == Frame::MAX_PIN
        frames << Frame.new([all_shots[shot_index]])
        shot_index += 1
      else
        shots = all_shots[shot_index, 2]
        frames << Frame.new(shots)
        shot_index += 2
      end
    end

    # 最終フレームは残り全ての投球
    frames << Frame.new(all_shots[shot_index..])

    frames
  end
end
