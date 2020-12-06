# frozen_string_literal: true

module Api
  module V1
    class TokensController < ApplicationController
      def create
        unique_token = Token.create.value
        render json: { token: unique_token }
      end
    end
  end
end
