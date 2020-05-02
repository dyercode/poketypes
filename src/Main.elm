module Main exposing (main)

import Browser
import Html exposing (Html, button, div, img, input, li, p, text, ul)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, field, int, list, map2, map3, string)


type alias Model =
    { monses : Maybe PokeList, errorMessage : Maybe String }


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


defaultList : PokeList
defaultList =
    { count = 0
    , next = ""
    , results = []
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { monses = Nothing
      , errorMessage = Nothing
      }
    , Cmd.none
    )


type Msg
    = SendHttpRequest
    | GotMons (Result Http.Error PokeList)


buildErrorMessage : Http.Error -> String
buildErrorMessage httpError =
    case httpError of
        Http.BadUrl message ->
            message

        Http.Timeout ->
            "Server is taking too long ot response. please try again later"

        Http.NetworkError ->
            "unable to reach server."

        Http.BadStatus sc ->
            "request failed with status code: " ++ String.fromInt sc

        Http.BadBody message ->
            message


update msg model =
    case msg of
        SendHttpRequest ->
            ( model, getPokemons )

        GotMons (Ok monses) ->
            ( { model | monses = Just monses }, Cmd.none )

        GotMons (Err errMessage) ->
            ( { model | monses = Nothing, errorMessage = Just (buildErrorMessage errMessage) }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ pokemon 0
        , button [ onClick SendHttpRequest ]
            [ text "get em all" ]
        , case model.monses of
            Nothing ->
                p [] [ text "ain't got none" ]

            Just m ->
                ul []
                    (List.map
                        (\n -> li [] [ text n.name ])
                        m.results
                    )

        --, button [ onClick Decrement ] [ text "-" ]
        --, div [] [ text (String.fromInt model) ]
        --, button [ onClick Increment ] [ text "+" ]
        ]


pokeApiBase =
    "https://pokeapi.co"


pokeApiSpecies =
    "/api/v2/pokemon-species/"



--type Response
--    = GotMon (Result Http.Error String)
--    | GotMons (Result Http.Error (List String))


getPokemons : Cmd Msg
getPokemons =
    Http.get
        { url = pokeApiBase ++ pokeApiSpecies
        , expect = Http.expectJson GotMons pokeListDecoder
        }


type alias PokeListResult =
    { name : String, url : String }


type alias PokeList =
    { count : Int
    , next : String
    , results : List PokeListResult
    }


pokeListResultDecoder : Decoder PokeListResult
pokeListResultDecoder =
    map2 PokeListResult
        (field "name" string)
        (field "url" string)


pokeListDecoder : Decoder PokeList
pokeListDecoder =
    map3 PokeList
        (field "count" int)
        (field "next" string)
        (field "results" (list pokeListResultDecoder))


pokemon id =
    div []
        [ img [ src "./media/pokemon/icons/0.png" ] []
        , input [] []
        ]
