module Earth exposing (..)

import Color exposing (..)
import Collage exposing (..)

import Camera exposing (..)


type alias Earth =
  { top : Float
  , height : Float
  , color : Color
  }


initial : Earth
initial =
  { top = 100
  , height = 100
  , color = rgb 128 255 128
  }


view : Earth -> Camera -> Form
view earth camera =
  rect (toFloat camera.width) earth.height |>
  filled earth.color |>
  moveY (earth.height / 2 - (toFloat camera.height) / 2)
