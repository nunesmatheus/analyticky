# Analyticky

This humble application provides an API that receives product analytics events and inserts them on elasticsearch to be qeried on Kibana.

## Missing Features
- Identify event location from request IP
- Set geospacial data from event location
- Add events on background with Sidekiq

## Setup

``` bash
docker-compose up
```

## Sending events
TBD
