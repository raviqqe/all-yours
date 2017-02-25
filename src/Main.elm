import AnimationFrame exposing (..)
import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Keyboard exposing (..)
import List exposing (..)
import Random exposing (..)
import Time exposing (..)

import Camera exposing (Camera)
import Earth exposing (Earth)
import Enemy exposing (Enemy)
import Human exposing (Human)
import Msg exposing (..)


-- Style

skyColor : Color
skyColor = rgb 128 128 255


-- Model

type alias Model =
  { human : Human
  , enemies : List Enemy
  , earth : Earth
  , camera : Camera
  }


-- Update

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  { model |
      human = Human.update msg model.earth model.human,
      enemies =
        List.map
          (Enemy.update msg model.earth)
          (if msg == GenEnemy then Enemy.initial :: model.enemies
                              else model.enemies)
  } ! [case msg of
    Clock _ -> Random.generate (\i -> if i % 3 == 0 then GenEnemy else NoOp)
                               (Random.int minInt maxInt)
    _ -> Cmd.none]


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
      collage model.camera.width model.camera.height (
        [ rect (toFloat model.camera.width) (toFloat model.camera.height) |>
            filled skyColor
        , Earth.view model.earth model.camera
        , Human.view model.human
        ] |> flip append (List.map Enemy.view model.enemies))
    ]
  ]


-- Main

main : Program Never Model Msg
main = program
  { init = Model Human.initial [] Earth.initial Camera.initial ! []
  , update = update
  , view = view
  , subscriptions = \_ ->
      Sub.batch
        [ Keyboard.downs (\code ->
            case code of
              32 -> Jump
              _ -> NoOp
            )
        , AnimationFrame.diffs (inSeconds >> Delta)
        , every second Clock
        ]
  }
