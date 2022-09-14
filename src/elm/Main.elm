port module Main exposing (Model, Msg, main)

import Browser
import Html exposing (Html, div, main_, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Parts.Button.View as PartsButton


main : Program String Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { message : String
    , count : Int
    , confirmAnswer : Maybe Bool
    }


init : String -> ( Model, Cmd Msg )
init flagMessage =
    ( { message = flagMessage
      , count = 0
      , confirmAnswer = Nothing
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Increment
    | Decrement
    | Confirm
    | ReceiveConfirm Bool


port confirm : String -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

        Confirm ->
            ( model, confirm "答えて！" )

        ReceiveConfirm answer ->
            ( { model | confirmAnswer = Just answer }, Cmd.none )



-- SUBSCRIPTIONS


port receiveAnswer : (Bool -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveAnswer ReceiveConfirm



-- VIEW


view : Model -> Html Msg
view model =
    main_ []
        [ largeText ("flags " ++ model.message)
        , largeText (confirmAnswerToString model.confirmAnswer)
        , largeText (String.fromInt model.count)
        , div [ class "flex justify-center gap-4" ]
            [ countButton "-" Decrement
            , countButton "+" Increment
            , PartsButton.view [ onClick Confirm ] [ text "confirm" ]
            ]
        ]


confirmAnswerToString : Maybe Bool -> String
confirmAnswerToString maybeBool =
    case maybeBool of
        Just value ->
            if value then
                "True"

            else
                "False"

        Nothing ->
            "No answer"


largeText : String -> Html Msg
largeText textContent =
    p [ class "text-center text-4xl font-bold" ] [ text textContent ]


countButton : String -> Msg -> Html Msg
countButton textContent msg =
    PartsButton.view [ onClick msg ] [ text textContent ]
