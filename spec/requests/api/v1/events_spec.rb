# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/events', type: :request do
  path '/events' do
    post 'Creates event' do
      tags 'Events'
      consumes 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          properties: { type: :object },
          ocurred_at: { type: :string }
        },
        required: %w[name]
      }

      response '201', 'event created' do
        let(:payload) do
          {
            name: 'My Event', properties: {
              my_property: 3, another_property: true
            }
          }
        end

        run_test! do
          expect(Event.count).to eq 1
          expect(Event.first.name).to eq 'My Event'
          expect(Event.first.properties['my_property']).to eq 3
          expect(Event.first.properties['another_property']).to eq true
        end
      end
    end
  end
end
