module Phisics exposing (..)


-- Model

type alias Object a = { a | x : Float, y : Float, vx : Float, vy : Float }


-- Update

update : Float -> Object a -> Object a
update dt object =
  { object |
      x = object.x + object.vx * dt,
      y = object.y + object.vy * dt,
      vy = object.vy - 1 * dt
  }
