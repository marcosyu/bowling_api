module Api::V1
  class MatchesController < BaseController

    before_action :set_match, only: [:show, :update]

    def show
      render json: @match
    end

    def create
      match = Match.new(match_params)
      if match.save
        render json: "Match Start"
      end
    end

    def update
      ScoreSheetService.new(@match, match_params["score"]).add_score
      render json: @match
    end

    private

    def set_match
      @match = Match.find(params[:id])
    end

    def match_params
      params.require(:match).permit(:device_mac, :score)
    end


  end
end
