FactoryBot.define do

  strike = { score1: 10, score2: nil, frame_score: 10 }

  score1 = rand(0..9)

  spare = { score1: score1, score2: 10 - score1, frame_score: 10 }
  normal ={ score1: score1, score2: 9 - score1, frame_score: score1 + ( 9-score1 ) }

  factory :match do
    device_mac { FFaker::Internet.mac }

    factory :match_strike do
      status {"strike"}
      score_sheet  { {score_card: [strike]} }
    end

    factory :match_spare do
      status {"spare"}
      score_sheet  { {score_card: [spare]} }
    end

    factory :match_normal do
      status {"normal"}
      score_sheet  { {score_card: [normal]} }
    end

    factory :match_full_strike do
      status {"strike"}
      score_sheet  {{ score_card: 10.times.map{strike} }}
    end
    factory :match_full_spare do
      status {"spare"}
      score_sheet  {{ score_card: 10.times.map{spare} }}
    end
    factory :match_full_normal do
      status {"normal"}
      score_sheet  {{ score_card: 10.times.map{normal} }}
    end
  end
end
