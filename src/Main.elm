import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (..)
import Keyboard exposing (..)

import Human exposing (Human)


-- Style

(gameWidth, gameHeight) = (600, 400)

earthHeight : Float
earthHeight = 100

skyColor : Color
skyColor = rgb 128 128 255

earthColor : Color
earthColor = rgb 128 255 128


-- Model

type alias Model =
  { me : Human
  }

initialModel : Model
initialModel =
  { me = Human 0 (earthHeight - gameHeight/2) 0 0
  }


-- Input

type Msg = Jump | NoOp

keyCodeToMsg : KeyCode -> Msg
keyCodeToMsg code = case code of
  32 -> Jump
  _ -> NoOp


-- Update

update : Msg -> Model -> (Model, Cmd Msg)
update _ model = { model | me = Human.update model.me } ! []


-- View

view : Model -> Html Msg
view model =
  toHtml <|
  container gameWidth gameHeight middle <|
  collage gameWidth gameHeight
    [ rect gameWidth gameHeight |>
        filled skyColor
    , rect gameWidth earthHeight |>
        filled earthColor |>
        moveY (earthHeight/2 - gameHeight/2)
    , Human.view model.me
    ]


-- Main

main : Program Never Model Msg
main = program
  { init = initialModel ! []
  , update = update
  , subscriptions = \_ -> Keyboard.downs keyCodeToMsg
  , view = view
  }
