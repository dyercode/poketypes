module Table exposing (printTable, Types)

import Decoders exposing (pokeListDecoder)
import Http
import Html exposing (Html, text)
import Client
import PokeApiDataTypes exposing (RefValue, PokeList)


type TableMsg
    = GotTypes (Result Http.Error PokeList)


getTypes : Cmd TableMsg
getTypes =
    Http.get
        { url = Client.baseUrl ++ Client.typeEndpoint
        , expect = Http.expectJson GotTypes pokeListDecoder
        }

type alias Types = List String

printTable : Types -> Html msg
printTable types = 
    Html.table [] [
        Html.thead [] 
            (
                (Html.th [] [] ) :: 
                    (List.map (\name -> Html.th [] [text name]) types)
            )
            
        
        , Html.tbody [] [
            Html.tr [] []
        ]
    ]