module Parts.Helper exposing (..)

import List.Unique as Unique


classListToString : List String -> String
classListToString classList =
    Unique.fromList classList |> Unique.toList |> String.join " "
