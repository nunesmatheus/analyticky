# frozen_string_literal: true

require 'elasticsearch/persistence'

class EventRepository
  include Elasticsearch::Persistence::Repository
  include Elasticsearch::Persistence::Repository::DSL

  index_name "#{Rails.env.production? ? '' : "#{Rails.env}_"}events_#{Time.zone.today}"

  klass Event

  client Elasticsearch::Client.new(
    url: ENV['ELASTICSEARCH_URL'] || ENV['BONSAI_URL'] || 'http://elasticsearch:9200'
  )

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :name, type: 'keyword'
      indexes :properties, type: 'object'
      indexes :ocurred_at, type: 'date'
      indexes :user_id, type: 'keyword'
    end
  end
end
