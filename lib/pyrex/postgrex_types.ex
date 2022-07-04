Postgrex.Types.define(
  Pyrex.PostgrexTypes,
  [Geo.PostGIS.Extension | Ecto.Adapters.Postgres.extensions()],
  json: Jason
)
