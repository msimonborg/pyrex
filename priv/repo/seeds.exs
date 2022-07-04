# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pyrex.Repo.insert!(%Pyrex.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Pyrex.Loader.shapes_and_jurisdictions()
Pyrex.Loader.us_legislators()
Pyrex.Loader.us_legislators_district_offices()
