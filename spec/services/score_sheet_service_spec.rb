require "rails_helper"

RSpec.describe ScoreSheetService, :type => :job do
  describe "add score" do

    let(:score1){ rand(0..5)}
    let(:score2){ rand(0..5)}

    context "adding frame_score" do
      let(:match){FactoryBot.create(:match)}
      it "adds score inside frame" do
        ScoreSheetService.new(match, score1).add_score
        expect(match.score_sheet["score_card"].last["frame_score"]).to eql(score1)
        ScoreSheetService.new(match, score2).add_score
        expect(match.score_sheet["score_card"].last["frame_score"]).to eql(score1 + score2)
      end
    end

    context "strike" do
      let(:match_strike){ FactoryBot.create(:match_strike) }
      it "adds score for a strike" do
        expect(match_strike.status).to eql('strike')
        ScoreSheetService.new(match_strike, score1).add_score
        ScoreSheetService.new(match_strike, score2).add_score
        # byebug
        expect(match_strike.score_sheet["score_card"][-2]["frame_score"]).to eql(10 + score1 + score2)
      end
    end

    context "spare" do
      let(:match_spare){ FactoryBot.create(:match_spare) }
      it "adds score for a spare" do
        expect(match_spare.status).to eql('spare')
        ScoreSheetService.new(match_spare, score1).add_score
        ScoreSheetService.new(match_spare, score2).add_score
        expect(match_spare.score_sheet["score_card"][-2]["frame_score"]).to eql(10 + score1)
      end
    end

    context "normal" do
      let(:match_normal){ FactoryBot.create(:match_normal) }
      it "adds score normally" do
        expect(match_normal.status).to eql('normal')
        ScoreSheetService.new(match_normal, score1).add_score
        ScoreSheetService.new(match_normal, score2).add_score
        expect(match_normal.score_sheet["score_card"][-2]["frame_score"]).to eql(9)
      end
    end

    context "full strike until end game" do
      let(:match){ FactoryBot.create(:match) }
      it "adds score of the strikes only until 11 frames only" do
        13.times do
          ScoreSheetService.new(match, 10).add_score
        end
        expect(match.status).to eql('Set')

        expect(match.score_sheet["score_card"].length).to eql(11)

        expect(match.total_score).to eql(300)
      end
    end

    context "full spare last frame" do
      let(:match){ FactoryBot.create(:match) }

      it "adds score of the spare until 11 frames only" do
        23.times do
          ScoreSheetService.new(match, 5).add_score
        end

        expect(match.status).to eql('Set')
        expect(match.score_sheet["score_card"].length).to eql(11)
        expect(match.total_score).to eql(155)
      end
    end
  end

  context "full normal last frame" do
    let(:match){FactoryBot.create(:match)}

    it "stops at the last normal" do
      23.times do
        ScoreSheetService.new(match, 4).add_score
      end

      expect(match.status).to eql('Set')
      expect(match.score_sheet["score_card"].length).to eql(10)
      expect(match.total_score).to eql(80)
    end
  end


end
