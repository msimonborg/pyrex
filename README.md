# Pyrex
Phone Your Rep rewrite in Pheonix.

See it in production at https://phoneyourrep.org

## Stack

* Elixir 1.13.4
* Erlang/OTP 25.0.2
* Phoenix 1.6.10
* Phoenix LiveView 0.17.10
* Tailwind CSS 3.1.4
* Alpine.js 3.10.2
* GraphQL/Absinthe
* Postgres/PostGIS 14
* fly.io

## Roadmap

- [x] Setup PostGIS database
- [x] Load jurisdiction shapefiles
- [x] Enable location-based lookups of jurisdictions
- [x] Model reps and offices in database schema
- [x] Fetch reps and offices by jurisdiction
- [x] Geocode office locations
- [x] Sort offices by proximity to address
- [x] Modules/workers to fetch, load, and periodically update data from external source
- [x] [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view) UI
- [ ] VCard (.vcf) downloads for legislator office contacts
- [ ] QR Codes for VCard download URLs, or directly encoding .vcf file contents
- [ ] GraphQL API using [Absinthe](https://github.com/absinthe-graphql/absinthe)

## Development

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Add a valid Google Places API key to your environment as the environment variable `GOOGLE_PLACES_API_KEY`. I recommend using a special key just for development that is restricted to the HTTP referrer `localhost:4000/*` and is never checked into version control.
  * Setup your database with `mix ecto.setup`. This will attempt to enable a PostGIS geometric database, download Census Bureau shapefiles for U.S. Congressional and State districts, and load them into your database. If this fails it may be because you do not have PostGIS installed. I recommend Postgres >14.4, PostGIS >3.2. If you're on macOS, the easiest way to install this correctly so it Just Works is with [Postgres.app](https://postgresapp.com/). The database setup will also fetch and load legislator data. The total data size is about 500 MB.
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

If you'd like to view the Pheonix LiveDashboard in development it can be found at the relative path `/dashboard` i.e. `localhost:4000/dashboard` with the username `"username"` and password `"password"`. These credentials will not work in production deployments.

## Support

This is a free, open-source project made by one creator, hopefully with help from volunteer contributors. The cost of running the servers is directly related to how many people use this app. There is also a cost incurred for every usage of the Google Places Autocomplete widget that helps you look up your address. If you enjoy using this tool and want to see it succeed, your support helps fund those costs.

[https://www.patreon.com/we_dle](https://www.patreon.com/we_dle)

## [License](LICENSE)

Copyright 2022 Matthew Simon Borg

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.