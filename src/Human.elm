module Human exposing (..)

import Collage exposing (..)
import Element exposing (..)

import Earth exposing (Earth)
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
  , y = .top Earth.initial
  , vx = 0
  , vy = 0
  }

-- Update

update : Msg -> Earth -> Human -> Human
update msg earth human = case msg of
  Jump -> { human | vy = if human.y <= earth.top then 300 else human.vy }
  Delta dt -> Phisics.update dt earth human
  NoOp -> human


-- View

view : Human -> Form
view human =
  fittedImage 10 20 dummyImageUrl |>
  toForm |>
  move (human.x, human.y)
