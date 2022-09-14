module Elm.Parts.Helper exposing (suite)

import Expect
import Parts.Helper exposing (classListToString)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Parts.Helper module"
        [ describe "Parts.Helper.classListToString"
            [ test "CSS クラス名が格納された配列が空白で区切られた文字列に変換される" <|
                \_ ->
                    let
                        result : String
                        result =
                            classListToString [ "foo", "bar" ]
                    in
                    Expect.equal result "foo bar"
            , test "重複した文字列は含まれない" <|
                \_ ->
                    let
                        result : String
                        result =
                            classListToString [ "foo", "bar", "foo" ]
                    in
                    Expect.equal (List.sort (String.split " " result)) [ "bar", "foo" ]
            ]
        ]
