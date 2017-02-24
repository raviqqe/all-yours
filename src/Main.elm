import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (..)
import Keyboard exposing (..)

import Human exposing (Human)


-- Style

(gameWidth, gameHeight) = (600, 400)

skyColor : Color
skyColor = rgb 128 128 255


-- Model

type alias Model =
  { me : Human
  }

initialModel : Model
initialModel =
  { me = Human 0 0 0 0
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
    [ rect gameWidth gameHeight |> filled skyColor
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
