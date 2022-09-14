module Elm.Features.Counter.Module exposing (suite)

import Expect
import Features.Counter.Module exposing (Msg(..), update, view)
import Test exposing (Test, describe, test)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector exposing (containing, tag, text)


suite : Test
suite =
    describe "Features.Counter.Module"
        [ describe "view"
            [ test "0 が表示される" <|
                \_ ->
                    view { count = 0 }
                        |> Query.fromHtml
                        |> Query.has [ text "0" ]
            , test "5 が表示される" <|
                \_ ->
                    view { count = 5 }
                        |> Query.fromHtml
                        |> Query.has [ text "5" ]
            , test "+ ボタンをクリックすると Increment Msg を発行する" <|
                \_ ->
                    view { count = 0 }
                        |> Query.fromHtml
                        |> Query.find [ tag "button", containing [ text "+" ] ]
                        |> Event.simulate Event.click
                        |> Event.expect Increment
            , test "- ボタンをクリックすると Decrement Msg を発行する" <|
                \_ ->
                    view { count = 0 }
                        |> Query.fromHtml
                        |> Query.find [ tag "button", containing [ text "-" ] ]
                        |> Event.simulate Event.click
                        |> Event.expect Decrement
            ]
        , describe "update"
            [ describe "Increment Msg"
                [ test "0 の時は 1 になる" <| \_ -> update Increment { count = 0 } |> .count |> Expect.equal 1
                , test "5 の時は 6 になる" <| \_ -> update Increment { count = 5 } |> .count |> Expect.equal 6
                ]
            , describe "Decrement Msg"
                [ test "0 の時は -1 になる" <| \_ -> update Decrement { count = 0 } |> .count |> Expect.equal -1
                , test "5 の時は 4 になる" <| \_ -> update Decrement { count = 5 } |> .count |> Expect.equal 4
                ]
            ]
        ]
