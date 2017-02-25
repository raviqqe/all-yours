module Human exposing (..)

import Collage exposing (..)
import Element exposing (..)

import Camera
import Earth
import Msg exposing (..)
import Phisics


-- Style

dummyImageUrl : String
dummyImageUrl = "https://www.raviqqe.com/favicon.png"


-- Model

type alias Human =
  { x : Float
  , y : Float
  , vx : Float
  , vy : Float
  }


initial : Human
initial =
  { x = 0
  , y = ((.height Earth.initial) - (toFloat (.height Camera.initial)) / 2)
  , vx = 0
  , vy = 0
  }

-- Update

update : Msg -> Human -> Human
update msg human = case msg of
  Jump -> { human | vy = 10 }
  Delta dt -> Phisics.update dt human
  NoOp -> human


-- View

view : Human -> Form
view human =
  fittedImage 10 20 dummyImageUrl |>
  toForm |>
  move (human.x, human.y)
