module Phisics exposing (..)

import Earth exposing (Earth)


-- Model

type alias Object a = { a | x : Float, y : Float, vx : Float, vy : Float }


-- Update

update : Float -> Earth -> Object a -> Object a
update dt earth object =
  { object |
      x = object.x + object.vx * dt,
      y = max earth.top (object.y + object.vy * dt),
      vy =  object.vy - if object.y > earth.top then 400 * dt else 0
  }
