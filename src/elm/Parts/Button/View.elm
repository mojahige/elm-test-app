module Parts.Button.View exposing (view)

import Html exposing (Attribute, Html, button)
import Html.Attributes exposing (class)
import Parts.Helper exposing (classListToString)


classList : List String
classList =
    [ "inline-block"
    , "w-fit"
    , "px-4"
    , "py-3"
    , "text-sm"
    , "font-semibold"
    , "text-center"
    , "text-white"
    , "bg-blue-600"
    , "rounded-md"
    , "cursor-pointer"
    , "hover:bg-blue-700"
    ]


view : List (Attribute msg) -> List (Html msg) -> Html msg
view attributes childrens =
    button (List.append [ class (classListToString classList) ] attributes) childrens
