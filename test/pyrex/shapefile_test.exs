defmodule Pyrex.ShapefileTest do
  use ExUnit.Case
  doctest Pyrex.Shapefile

  @shapes [
    {%Exshape.Shp.Header{},
     %Exshape.Dbf.Header{
       columns: [
         %Exshape.Dbf.Column{name: "STATEFP"},
         %Exshape.Dbf.Column{name: "CD115FP"},
         %Exshape.Dbf.Column{name: "AFFGEOID"},
         %Exshape.Dbf.Column{name: "GEOID"},
         %Exshape.Dbf.Column{name: "LSAD"},
         %Exshape.Dbf.Column{name: "CDSESSN"},
         %Exshape.Dbf.Column{name: "ALAND"},
         %Exshape.Dbf.Column{name: "AWATER"}
       ]
     }},
    {
      %Exshape.Shp.Polygon{
        points: [
          [
            [
              %Exshape.Shp.Point{x: -96.639704, y: 42.737071},
              %Exshape.Shp.Point{x: -96.635886, y: 42.741001999999995}
            ]
          ]
        ]
      },
      ["19", "04", "5001500US1904   ", "1904", "C2", "115", 58_937_921_470, 264_842_664]
    }
  ]

  @mapped_shapes [
    %{
      geom: %Geo.MultiPolygon{
        coordinates: [
          [
            [
              {42.737071, -96.639704},
              {42.741001999999995, -96.635886}
            ]
          ]
        ],
        srid: Pyrex.Shapefile.srid()
      },
      statefp: "19",
      cd115fp: "04",
      affgeoid: "5001500US1904",
      geoid: "1904",
      lsad: "C2",
      cdsessn: "115",
      aland: 58_937_921_470,
      awater: 264_842_664
    }
  ]

  test "maps shapefile data" do
    assert Pyrex.Shapefile.map_shapes(@shapes) == @mapped_shapes
  end
end
