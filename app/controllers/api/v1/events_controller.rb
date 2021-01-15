# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController
      def create
        Event.create(event_params)
        render json: {}, status: :created
      end

      private

      def event_params
        user_id = request.headers['X-User-Id']
        params.permit(:name, :ocurred_at, properties: {}).merge(user_id: user_id)
      end
    end
  end
end
