# PYREx
Phone Your Rep rewrite in Pheonix.

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
- [ ] Model reps and offices in database schema
- [ ] Fetch reps and offices by jurisdiction
- [ ] Geocode office locations
- [ ] Sort offices by proximity to address
- [ ] Modules/workers to fetch, load, and periodically update data from external source
- [ ] [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view) UI
- [ ] GraphQL API using [Absinthe](https://github.com/absinthe-graphql/absinthe)

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
