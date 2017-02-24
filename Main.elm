import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (..)
import Keyboard exposing (..)


-- Style

(gameWidth, gameHeight) = (600, 400)

skyColor = rgb 128 128 255

dummyImageUrl = "https://www.raviqqe.com/favicon.png"


-- Model

type alias Human =
  { x : Float
  , y : Float
  , vx : Float
  , vy : Float
  }

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
update _ model = model ! []


-- View

view : Model -> Html Msg
view model =
  toHtml <|
  container gameWidth gameHeight middle <|
  collage gameWidth gameHeight
    [ rect gameWidth gameHeight |> filled skyColor
    , viewHuman model.me
    ]

viewHuman : Human -> Form
viewHuman human =
  fittedImage 10 20 dummyImageUrl |>
  toForm |>
  move (human.x, human.y)


-- Main

main = program
  { init = initialModel ! []
  , update = update
  , subscriptions = \_ -> Keyboard.downs keyCodeToMsg
  , view = view
  }
