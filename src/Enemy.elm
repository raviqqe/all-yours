module Enemy exposing (..)

import Collage exposing (..)
import Element exposing (..)

import Camera
import Debugs
import Earth exposing (Earth)
import Msg exposing (..)
import Phisics


-- Model

type alias Enemy =
  { x : Float
  , y : Float
  , vx : Float
  , vy : Float
  }


initial : Enemy
initial =
  { x = toFloat (.width Camera.initial) / 2 + 100
  , y = .top Earth.initial
  , vx = -100
  , vy = 0
  }


-- Update

update : Msg -> Earth -> Enemy -> Enemy
update msg earth enemy = case msg of
  Delta dt -> Phisics.update dt earth enemy
  _ -> enemy


-- View

view : Enemy -> Form
view enemy =
  fittedImage 40 20 Debugs.dummyImageUrl |>
  toForm |>
  move (enemy.x, enemy.y)
