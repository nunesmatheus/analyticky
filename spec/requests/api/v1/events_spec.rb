# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/events', type: :request, elasticsearch: true do
  path '/api/v1/events' do
    post 'Creates event' do
      tags 'Events'
      consumes 'application/json'
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
        let(:name) { Faker::Lorem.sentence[0..-2] }
        let(:payload) do
          {
            name: name, properties: {
              my_property: 3, another_property: true
            }
          }
        end

        run_test! do
          repository = EventRepository.new
          repository.refresh_index!
          events = repository.search(query: { match: { name: name } })
          expect(events.results.size).to eq 1
          event = events.first
          expect(event.name).to eq name
          expect(event.properties['my_property']).to eq 3
          expect(event.properties['another_property']).to eq true
        end
      end
    end
  end
end
