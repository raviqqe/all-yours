module Camera exposing (..)


type alias Camera =
  { width : Int
  , height : Int
  }


camera : Camera
camera = { width = 600, height = 400 }
