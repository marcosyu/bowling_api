require 'rails_helper'

RSpec.describe Api::V1::MatchesController, type: :controller do



  describe "start match" do
    context "initiate without device_mac" do

      it "post call without params" do
        post :create, { format: :json }
        expect(response.body).to eql("param is missing or the value is empty: match")
      end
    end

    context "initiate with device_mac" do
      let(:device_mac){ FFaker::Internet.mac }

      it "post call to start match" do
        post :create, {format: :json, params: { match: {device_mac: device_mac }} }
        expect(response.body).to eql("Match Start")
      end

    end
  end

  describe "play match" do
    let(:match){ FactoryBot.create(:match) }
    let(:score){ rand(0..10)}
    context "send score" do
      it "post call to send score" do
        patch :update, {format: :json, params: { id: match.id, match: {score: score }  } }

        expect(JSON.parse(response.body)["score_sheet"]["score_card"][0]["score1"].to_i).to eql(score)
      end
    end
  end

  describe "show score" do
    let(:match){ FactoryBot.create(:match) }
    let(:score){ rand(0..10)}
    context "show score" do
      it "get call to show scores" do
        get :show, {format: :json, params: { id: match.id  } }
        expect(JSON.parse(response.body)["device_mac"]).to eql(match.device_mac)
      end
    end
  end
end
