class Match < ApplicationRecord

  validates :device_mac, presence:true, uniqueness: true

  store :score_sheet, accessors: [:total_score, :score_card]

end
