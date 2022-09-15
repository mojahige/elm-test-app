port module Main exposing (Model, Msg, main)

import Browser
import Features.Counter.Module as Counter
import Html exposing (Html, div, h1, h2, main_, p, section, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Parts.Button.Module as Button


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
        [ h1 [ class "text-center text-6xl font-bold" ] [ text "Elm app" ]
        , div [ class "flex flex-col gap-6 mt-8" ]
            [ viewSection "Flags test" [ p [] [ text ("flags = " ++ model.message) ] ]
            , viewSection "Ports test" [ p [] [ text ("confirm result = " ++ confirmAnswerToString model.confirmAnswer) ], Button.view [ class "mt-6", onClick Confirm ] [ text "confirm" ] ]
            , viewSection "Other module test" [ Counter.view model.counter |> Html.map Counter ]
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


viewSection : String -> List (Html Msg) -> Html Msg
viewSection heading childrens =
    section []
        [ h2 [ class "text-center text-2xl font-bold" ]
            [ text heading ]
        , div
            [ class "text-center mt-2" ]
            childrens
        ]
