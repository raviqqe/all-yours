module Camera exposing (..)


type alias Camera =
  { width : Int
  , height : Int
  }


initial : Camera
initial = { width = 600, height = 400 }
