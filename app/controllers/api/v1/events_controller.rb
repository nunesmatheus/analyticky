# frozen_string_literal: true

module Api
  module V1
    class EventsController
      def create
        Event.create(event_params)
        render json: {}, status: :created
      end

      private

      def event_params
        params.permit(:name, :ocurred_at, properties: {})
      end
    end
  end
end
