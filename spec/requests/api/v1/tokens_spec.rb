# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/api/v1/tokens', type: :request do
  path '/api/v1/tokens' do
    post 'Get unique token' do
      tags 'Tokens'
      consumes 'application/json'

      response '200', 'returns unique token' do
        run_test! do
          expect(JSON.parse(response.body)['token']).to be_present
        end
      end
    end
  end
end
