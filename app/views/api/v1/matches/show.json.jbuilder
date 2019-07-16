json.device_mac @match.device_mac
json.status @match.status
json.array! @match.score_card do |frame|
  json.score1 frame.score1
  json.score1 frame.score2
  json.total_score frame.frame_score
end