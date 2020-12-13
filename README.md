# Analyticky

This humble application provides an API that receives product analytics events and inserts them on elasticsearch to be queried on Kibana.

## Setup

``` bash
docker-compose build
docker-compose run --rm bundle exec web bundle
docker-compose run --rm bundle exec web rails db:setup
docker-compose up
```

## Sending events

Access `localhost:3002/api-docs` to interact with the application using the swagger docs.

## Deploy

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)
