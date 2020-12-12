# Analyticky

This humble application provides an API that receives product analytics events and inserts them on elasticsearch to be queried on Kibana.

## Missing Features
- Identify event location from request IP
- Set geospacial data from event location
- Cache ip location to prevent additional calls to geolocation API (feature flag)
- Add swagger docs
- API to fetch unique ID
- API to alias anonymous user with user_id?
- Add events on background with Sidekiq
- User profiles?

## Setup

``` bash
docker-compose build
docker-compose run --rm bundle exec web bundle
docker-compose run --rm bundle exec web rails db:setup
docker-compose up
```

## Sending events
TBD
