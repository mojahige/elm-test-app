module Features.Counter.Module exposing (Model, Msg(..), update, view)

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Parts.Button.Module as PartsButton



-- MODEL


type alias Model =
    { count : Int }



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ p [ class "text-center text-4xl font-bold" ] [ text (String.fromInt model.count) ]
        , div [ class "flex justify-center gap-4" ]
            [ PartsButton.view [ onClick Decrement ] [ text "-" ]
            , PartsButton.view [ onClick Increment ] [ text "+" ]
            ]
        ]
