module Main exposing (main)

import Browser
import Html exposing (Html, button, div, img, input, li, p, text, ul)
import Html.Attributes as Attrs exposing (src)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode exposing (Decoder, field, int, list, map2, map3, string)
import Menu


type alias Model =
    { monses : Maybe PokeList
    , errorMessage : Maybe String
    , autoState : Menu.State
    , query : String
    , howManyToShow : Int
    , pokemonList : List PokeListResult
    , showMenu : Bool
    }


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { monses = Nothing
      , errorMessage = Nothing
      , autoState = Menu.empty
      , query = ""
      , howManyToShow = 5
      , pokemonList = []
      , showMenu = False
      }
    , Cmd.none
    )


type Msg
    = SendHttpRequest
    | GotMons (Result Http.Error PokeList)
    | SetAutoCompleteState Menu.Msg
    | SetQuery String
    | SelectPokemon String


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


updateConfig : Menu.UpdateConfig Msg PokeListResult
updateConfig =
    Menu.updateConfig
        { toId = .name
        , onKeyDown =
            \code maybeId ->
                if code == 13 then
                    Maybe.map SelectPokemon maybeId

                else
                    Nothing
        , onTooLow = Nothing
        , onTooHigh = Nothing
        , onMouseEnter = \_ -> Nothing
        , onMouseLeave = \_ -> Nothing
        , onMouseClick = \id -> Just <| SelectPokemon id
        , separateSelections = False
        }


acceptablePokemon : String -> List PokeListResult -> List PokeListResult
acceptablePokemon query pokemon =
    let
        lowerQuery =
            String.toLower query
    in
    List.filter (String.contains lowerQuery << String.toLower << .name) pokemon


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendHttpRequest ->
            ( model, getPokemons )

        GotMons (Ok monses) ->
            ( { model
                | monses = Just monses
                , pokemonList = List.append model.pokemonList monses.results
              }
            , Cmd.none
            )

        GotMons (Err errMessage) ->
            ( { model | monses = Nothing, errorMessage = Just (buildErrorMessage errMessage) }, Cmd.none )

        SetAutoCompleteState autoMsg ->
            let
                ( newState, _ ) =
                    Menu.update updateConfig autoMsg model.howManyToShow model.autoState (acceptablePokemon model.query model.pokemonList)
            in
            ( { model | autoState = newState }, Cmd.none )

        SetQuery newQuery ->
            ( { model | query = newQuery, showMenu = True }
            , Cmd.none
            )

        SelectPokemon id ->
            ( { model
                | query =
                    List.filter (\poke -> poke.name == id) model.pokemonList
                        |> List.head
                        |> Maybe.withDefault (PokeListResult "unown" "nourl")
                        |> .name
                , autoState = Menu.empty
                , showMenu = False
              }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    div []
        [ pokemonSelect model
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


pokeApiBase : String
pokeApiBase =
    "https://pokeapi.co"


pokeApiSpecies : String
pokeApiSpecies =
    "/api/v2/pokemon-species/"



getPokemons : Cmd Msg
getPokemons =
    Http.get
        { url = pokeApiBase ++ pokeApiSpecies
        , expect = Http.expectJson GotMons pokeListDecoder
        }


type alias PokeListResult =
    { name : String
    , url : String
    }


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


pokemonSelect : Model -> Html Msg
pokemonSelect model =
    div []
        [ img [ src "./media/pokemon/icons/0.png" ] []
        , input
            [ onInput SetQuery
            , Attrs.class "autocomplete-input"
            , Attrs.value model.query
            ]
            []
        , if model.showMenu then
            viewMenu model

          else
            Html.div [] []
        ]


viewConfig : Menu.ViewConfig PokeListResult
viewConfig =
    let
        customizedLi keySelected mouseSelected pkmn =
            { attributes =
                [ Attrs.classList
                    [ ( "autocomplete-item", True )
                    , ( "key-selected", keySelected || mouseSelected )
                    ]
                , Attrs.id pkmn.name
                ]
            , children = [ Html.text pkmn.name ]
            }
    in
    Menu.viewConfig
        { toId = .name
        , ul = [ Attrs.class "autocomplete-list" ]
        , li = customizedLi
        }


viewMenu : Model -> Html.Html Msg
viewMenu model =
    Html.div [ Attrs.class "autocomplete-menu" ]
        [ Html.map SetAutoCompleteState <|
            Menu.view viewConfig
                model.howManyToShow
                model.autoState
                (acceptablePokemon model.query model.pokemonList)
        ]
