import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html exposing (..)


-- Style

(gameWidth, gameHeight) = (600, 400)
skyColor = rgb 128 128 255


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

type Msg = NoOp


-- Update

update : Msg -> Model -> Model
update _ model = model


-- View

view : Model -> Html Msg
view model =
  toHtml <|
  container gameWidth gameHeight middle <|
  collage gameWidth gameHeight
    [ rect gameWidth gameHeight |> filled skyColor
    ]


-- Main

main = beginnerProgram
  { model = initialModel
  , view = view
  , update = \msg model -> update msg model
  }
