module Earth exposing (..)

import Color exposing (..)
import Collage exposing (..)

import Camera exposing (..)


type alias Earth =
  { top : Float
  , height : Float
  , color : Color
  }


initialHeight : Float
initialHeight = 100


initial : Earth
initial =
  { top = initialHeight - toFloat (.height Camera.initial) / 2
  , height = initialHeight
  , color = rgb 128 255 128
  }


view : Earth -> Camera -> Form
view earth camera =
  rect (toFloat camera.width) earth.height |>
  filled earth.color |>
  moveY (earth.height / 2 - (toFloat camera.height) / 2)
