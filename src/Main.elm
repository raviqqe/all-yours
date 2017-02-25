import AnimationFrame exposing (..)
import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Keyboard exposing (..)
import Time exposing (..)

import Camera exposing (Camera)
import Earth exposing (Earth)
import Human exposing (Human)
import Msg exposing (..)


-- Style

skyColor : Color
skyColor = rgb 128 128 255


-- Model

type alias Model =
  { human : Human
  , earth : Earth
  , camera : Camera
  }

initialModel : Model
initialModel =
  { human = Human.initial
  , earth = Earth.initial
  , camera = Camera.initial
  }


-- Input

keyCodeToMsg : KeyCode -> Msg
keyCodeToMsg code = case code of
  32 -> Jump
  _ -> NoOp


-- Update

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = { model | human = Human.update msg model.earth model.human } ! []


-- View

view : Model -> Html Msg
view model =
  body [] [
    div [style [
      ("margin", "10px auto 0 auto"),
      ("width", toString model.camera.width ++ "px")
    ]] [
      toHtml <|
      container model.camera.width model.camera.height middle <|
      collage model.camera.width model.camera.height
        [ rect (toFloat model.camera.width) (toFloat model.camera.height) |>
            filled skyColor
        , Earth.view model.earth model.camera
        , Human.view model.human
        ]
    ]
  ]


-- Main

main : Program Never Model Msg
main = program
  { init = initialModel ! []
  , update = update
  , subscriptions = \_ ->
      Sub.batch
        [ Keyboard.downs keyCodeToMsg
        , AnimationFrame.diffs (inSeconds >> Delta)
        ]
  , view = view
  }
