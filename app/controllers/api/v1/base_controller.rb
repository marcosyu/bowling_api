
module Api::V1
  class BaseController < ApplicationController

    rescue_from StandardError do |e|
      render json: e.to_s, status: :unprocessable_entity, code: 422
    end

  end
end
