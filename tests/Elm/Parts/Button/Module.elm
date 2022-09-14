module Elm.Parts.Button.Module exposing (suite)

import Html
import Html.Attributes as Attr
import Html.Events as Events
import Parts.Button.Module exposing (view)
import Test exposing (Test, describe, test)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector


type Msg
    = Click


suite : Test
suite =
    describe "Parts.Button.Module"
        [ describe "Parts.Button.Module view"
            [ test "指定したテキストが表示される" <|
                \_ ->
                    view [] [ Html.text "foo" ]
                        |> Query.fromHtml
                        |> Query.has [ Selector.text "foo" ]
            , test "指定したクラス名が追加される" <|
                \_ ->
                    view [ Attr.class "test1 test2" ] [ Html.text "foo" ]
                        |> Query.fromHtml
                        |> Query.has [ Selector.classes [ "test1", "test2" ] ]
            , test "クリックイベントが実行される" <|
                \_ ->
                    view [ Events.onClick Click ] [ Html.text "foo" ]
                        |> Query.fromHtml
                        |> Event.simulate Event.click
                        |> Event.expect Click
            ]
        ]
