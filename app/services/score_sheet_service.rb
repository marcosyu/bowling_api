class ScoreSheetService

  def initialize(match_obj, score)
    @@match = match_obj
    @@score = score
  end

  def add_score
    return if @@match.status.eql? "Set"
    score_sheet = @@match.score_card || []

    if @@match.status.eql? "waiting"
      if (score_sheet.last[:score1] + @@score) == 10
        status = "spare"
      else
        status = score_sheet.length == 10 ? "Set" : "normal"
      end

      score_sheet.last[:score2] = @@score
      score_sheet.last[:frame_score] += @@score

      if score_sheet.length > 1
        score_sheet[-2][:frame_score] += @@score if score_sheet[-2][:score2].nil?
      end

    else
      if ["strike", "spare"].include? @@match.status
        score_sheet.last[:frame_score] += @@score

        score_sheet.last[:score2] += 1 if score_sheet.last[:score2].to_i < 0

        if score_sheet.length > 1
          score_sheet[-2][:frame_score] += @@score if score_sheet[-2][:score2] < 0
        end
      end

      if @@score == 10
        status = score_sheet.length == 10 ? "Set" : "strike"
        frame = { score2: -2 }
      elsif score_sheet.length == 10
        status = "Set"
        frame = { score2: 0 }
      else
        status = "waiting"
        frame = { score2: 0 }
      end

      frame.merge!({score1:  @@score, frame_score: @@score })
      score_sheet << frame
    end

    @@match.update_attributes({status: status, score_sheet: { score_card: score_sheet, total_score: score_sheet.sum{|score| score[:frame_score].to_i}}})

  end

end
