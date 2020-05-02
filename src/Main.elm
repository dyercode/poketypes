module Main exposing (main)

import Browser
import Decoders exposing (pokeListDecoder, pokemonDecoder)
import Html exposing (Html, button, div, img, input, li, p, text, ul)
import Html.Attributes as Attrs exposing (src)
import Html.Events exposing (onClick, onInput)
import Http
import Menu
import PokeApiDataTypes exposing (PokeList, Pokemon, RefValue)


type alias Model =
    { pokedex : Maybe PokeList
    , errorMessage : Maybe String
    , autoState : Menu.State
    , query : String
    , howManyToShow : Int
    , pokemonList : List RefValue
    , showMenu : Bool
    , selectedMon : Maybe Pokemon
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
    ( { pokedex = Nothing
      , errorMessage = Nothing
      , autoState = Menu.empty
      , query = ""
      , howManyToShow = 5
      , pokemonList = []
      , showMenu = False
      , selectedMon = Nothing
      }
    , Cmd.none
    )


type Msg
    = GetPokemonList String
    | GetPokemon String
    | GotPokeList (Result Http.Error PokeList)
    | GotPokemon (Result Http.Error Pokemon)
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


updateConfig : Menu.UpdateConfig Msg RefValue
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


acceptablePokemon : String -> List RefValue -> List RefValue
acceptablePokemon query pokemon =
    let
        lowerQuery =
            String.toLower query
    in
    List.filter (String.contains lowerQuery << String.toLower << .name) pokemon


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetPokemonList url ->
            ( model, getPokemons url )

        GetPokemon name ->
            ( model, getPokemon name )

        GotPokemon (Ok pkmn) ->
            ( { model | selectedMon = Just pkmn }
            , Cmd.none
            )

        GotPokemon (Err errMessage) ->
            ( { model | pokedex = Nothing, errorMessage = Just (buildErrorMessage errMessage) }, Cmd.none )

        GotPokeList (Ok pokedex) ->
            let
                followUp =
                    case pokedex.next of
                        Just n ->
                            getPokemons n

                        Nothing ->
                            Cmd.none
            in
            ( { model
                | pokedex = Just pokedex
                , pokemonList = List.append model.pokemonList pokedex.results
              }
            , followUp
            )

        GotPokeList (Err errMessage) ->
            ( { model | pokedex = Nothing, errorMessage = Just (buildErrorMessage errMessage) }, Cmd.none )

        SetAutoCompleteState autoMsg ->
            let
                ( newState, maybeMsg ) =
                    Menu.update updateConfig
                        autoMsg
                        model.howManyToShow
                        model.autoState
                        (acceptablePokemon model.query model.pokemonList)

                newModel =
                    { model | autoState = newState }
            in
            maybeMsg
                |> Maybe.map (\updateMsg -> update updateMsg newModel)
                |> Maybe.withDefault ( newModel, Cmd.none )

        SetQuery newQuery ->
            ( { model | query = newQuery, showMenu = True }, Cmd.none )

        SelectPokemon id ->
            let
                newMonMaybe =
                    List.filter (\poke -> poke.name == id) model.pokemonList
                        |> List.head
            in
            ( { model
                | query =
                    newMonMaybe
                        |> Maybe.withDefault (RefValue "unown" "nourl")
                        |> .name
                , autoState = Menu.empty
                , showMenu = False
              }
            , case newMonMaybe of
                Just pk ->
                    getPokemon pk.name

                Nothing ->
                    Cmd.none
            )


view : Model -> Html Msg
view model =
    div []
        [ pokemonSelect model
        , button [ onClick (GetPokemonList (pokeApiBase ++ pokeApiSpecies)) ]
            [ text "get em all" ]
        , case model.pokedex of
            Nothing ->
                p [] [ text "ain't got none" ]

            Just m ->
                ul []
                    (List.map (\n -> li [] [ text n.name ]) model.pokemonList)
        ]


pokeApiBase : String
pokeApiBase =
    "https://pokeapi.co"


pokeApiSpecies : String
pokeApiSpecies =
    "/api/v2/pokemon-species/?limit=100"


pokeApiPokemon : String
pokeApiPokemon =
    "/api/v2/pokemon/"


getPokemons : String -> Cmd Msg
getPokemons url =
    Http.get
        { url = url
        , expect = Http.expectJson GotPokeList pokeListDecoder
        }


getPokemon : String -> Cmd Msg
getPokemon name =
    Http.get
        { url = pokeApiBase ++ pokeApiPokemon ++ name
        , expect = Http.expectJson GotPokemon pokemonDecoder
        }


displayMon : Maybe Pokemon -> Html Msg
displayMon pkmn =
    case pkmn of
        Just mon ->
            div []
                [ p [] [ text ("(#" ++ String.fromInt mon.order ++ ") " ++ mon.name) ]
                , ul [] (List.map (\t -> li [] [ text t.name ]) mon.types)
                ]

        Nothing ->
            div [] []


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
        , displayMon model.selectedMon
        ]


viewConfig : Menu.ViewConfig RefValue
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
