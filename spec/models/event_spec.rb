# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe '#self.create', elasticsearch: true do
    let(:name) { 'New event' }
    let(:repository) { EventRepository.new }

    it 'inserts record on elasticsearch' do
      expect(
        repository.search(query: { match: { name: name } }).results.size
      ).to eq 0
      Event.create(name: name)
      repository.refresh_index!
      expect(
        repository.search(query: { match: { name: name } }).results.size
      ).to eq 1
    end

    it 'sets ocurred_at' do
      Event.create(name: name)
      repository.refresh_index!
      events = repository.search(query: { match: { name: name } }).results
      expect(events.size).to eq 1
      expect(events.first.ocurred_at).to be_present
    end
  end
end
