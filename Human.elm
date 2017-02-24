module Human exposing (..)

import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (..)
import Keyboard exposing (..)


-- Style

dummyImageUrl = "https://www.raviqqe.com/favicon.png"


-- Model

type alias Human =
  { x : Float
  , y : Float
  , vx : Float
  , vy : Float
  }


-- Update

update : Human -> Human
update human = human


-- View

view : Human -> Form
view human =
  fittedImage 10 20 dummyImageUrl |>
  toForm |>
  move (human.x, human.y)
