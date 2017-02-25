import AnimationFrame exposing (..)
import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Keyboard exposing (..)
import List exposing (..)
import Random exposing (..)
import Text
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

type Screen = Start | Play

type alias Game =
  { human : Human
  , enemies : List Enemy
  , earth : Earth
  , camera : Camera
  , lastEnemyTime : Time
  , screen : Screen
  }


-- Update

update : Msg -> Game -> (Game, Cmd Msg)
update msg model = case model.screen of
  Play ->
    let
      newEnemies = case msg of
        GenEnemy _ -> Enemy.initial :: model.enemies
        _ -> model.enemies

      generateEnemy =
        case msg of
          Clock t -> Random.generate
            (\i -> if t - model.lastEnemyTime > 500 && i % 3000 == 0 then GenEnemy t else NoOp)
            (Random.int minInt maxInt)
          _ -> Cmd.none
    in
      { model |
          human = Human.update msg model.earth model.human,
          enemies = List.map (Enemy.update msg model.earth) newEnemies,
          lastEnemyTime = case msg of
            GenEnemy t -> t
            _ -> model.lastEnemyTime
      } ! [
        generateEnemy
      ]
  Start -> case msg of
    Msg.Jump -> { model | screen = Play } ! []
    _ -> model ! []


-- View

view : Game -> Html Msg
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
        ] |>
        flip append (List.map Enemy.view model.enemies) |>
        flip append (if model.screen == Start then [toForm (centered (Text.fromString "All Yours"))] else []))
    ]
  ]


-- Main

main : Program Never Game Msg
main = program
  { init =
      { human = Human.initial
      , enemies = []
      , earth = Earth.initial
      , camera = Camera.initial
      , lastEnemyTime = 0
      , screen = Start
      } ! []
  , update = update
  , view = view
  , subscriptions = \_ ->
      Sub.batch
        [ Keyboard.downs (\code ->
            case code of
              32 -> Msg.Jump
              _ -> NoOp
            )
        , AnimationFrame.diffs (inSeconds >> Delta)
        , every millisecond Clock
        ]
  }
