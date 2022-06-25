Postgrex.Types.define(
  PYREx.PostgrexTypes,
  [Geo.PostGIS.Extension | Ecto.Adapters.Postgres.extensions()],
  json: Jason
)
