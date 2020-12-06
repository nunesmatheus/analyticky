# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventRepository, elasticsearch: true do
  let(:repository) { EventRepository.new }

  describe '#create' do
    let(:name) { 'My event' }

    it 'persists record on elasticsearch' do
      expect(
        repository.search(query: { match: { name: name } }).results.size
      ).to eq 0
      repository.save(Event.new(name: name))
      repository.refresh_index!
      expect(
        repository.search(query: { match: { name: name } }).results.size
      ).to eq 1
    end
  end
end
