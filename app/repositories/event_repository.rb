# frozen_string_literal: true

require 'elasticsearch/persistence'

class EventRepository
  include Elasticsearch::Persistence::Repository
  include Elasticsearch::Persistence::Repository::DSL

  index_name "events_#{Time.zone.today}"
  klass Event

  client Elasticsearch::Client.new(
    url: ENV['ELASTICSEARCH_URL'] || 'http://elasticsearch:9200'
  )

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :name
      indexes :properties
      indexes :ocurred_at, type: 'date'
    end
  end
end
