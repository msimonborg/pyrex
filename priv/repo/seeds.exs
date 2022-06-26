# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PYREx.Repo.insert!(%PYREx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

PYREx.Loader.shapes_and_jurisdictions()
PYREx.Loader.us_legislators()
PYREx.Loader.us_legislators_district_offices()
