port module Main exposing (Model, Msg, main)

import Browser
import Features.Counter.Module as Counter
import Html exposing (Html, div, main_, p, text)
import Html.Attributes exposing (class)


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
    , confirmAnswer : Maybe Bool
    , counter : Counter.Model
    }


init : String -> ( Model, Cmd Msg )
init flagMessage =
    ( { message = flagMessage
      , confirmAnswer = Nothing
      , counter = { count = 0 }
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Confirm
    | ReceiveConfirm Bool
    | Counter Counter.Msg


port confirm : String -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Confirm ->
            ( model, confirm "答えて！" )

        ReceiveConfirm answer ->
            ( { model | confirmAnswer = Just answer }, Cmd.none )

        Counter counterMsg ->
            ( { model
                | counter = Counter.update counterMsg model.counter
              }
            , Cmd.none
            )



-- SUBSCRIPTIONS


port receiveAnswer : (Bool -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveAnswer ReceiveConfirm



-- VIEW


view : Model -> Html Msg
view model =
    main_ []
        [ div []
            [ largeText ("flags " ++ model.message)
            , largeText (confirmAnswerToString model.confirmAnswer)
            ]
        , Counter.view model.counter |> Html.map Counter
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
