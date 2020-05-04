module Main exposing (main)

import Browser
import Decoders exposing (pokeListDecoder, pokemonDecoder)
import Html exposing (Html, button, div, img, input, li, p, text, ul)
import Html.Attributes as Attrs exposing (id, src)
import Html.Events exposing (onClick, onInput)
import Http
import Menu
import PokeApiDataTypes exposing (PokeList, Pokemon, RefValue)


type alias PokemonSelectConfig r =
    { r
        | howManyToShow : Int
        , dropDownOpen : Maybe String
    }


type alias Autocomplete =
    { query : String
    , autoState : Menu.State
    , id : String
    }


type alias Model =
    { pokedex : Maybe PokeList
    , errorMessage : Maybe String
    , pokemonList : List RefValue
    , selectedMon : Maybe Pokemon
    , dropDownOpen : Maybe String
    , howManyToShow : Int
    , selections : List Autocomplete
    }


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


defaultPokeSelectAuto : Autocomplete
defaultPokeSelectAuto =
    { autoState = Menu.empty
    , query = ""
    , id = ""
    }


initPokeSelectAuto : List Autocomplete
initPokeSelectAuto =
    List.indexedMap
        (\index select ->
            { select | id = String.fromInt index }
        )
        (List.repeat 6 defaultPokeSelectAuto)


init : () -> ( Model, Cmd Msg )
init _ =
    ( { pokedex = Nothing
      , errorMessage = Nothing

      --   , autocomplete = initPokeSelectAuto
      , pokemonList = []
      , selections = initPokeSelectAuto
      , selectedMon = Nothing
      , dropDownOpen = Nothing
      , howManyToShow = 5
      }
    , getPokemons (pokeApiBase ++ pokeApiSpecies)
    )


type Msg
    = GetPokemonList String
    | GotPokeList (Result Http.Error PokeList)
    | GotPokemon (Result Http.Error Pokemon)
    | SetQuery String String



--| SetAutoCompleteState Menu.Msg
--| SetQuery String
--| SelectPokemon String


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



--updateConfig : Menu.UpdateConfig Msg RefValue
--updateConfig =
--    Menu.updateConfig
--        { toId = .name
--        , onKeyDown =
--            \code maybeId ->
--                if code == 13 then
--                    Maybe.map SelectPokemon maybeId
--
--                else
--                    Nothing
--        , onTooLow = Nothing
--        , onTooHigh = Nothing
--        , onMouseEnter = \_ -> Nothing
--        , onMouseLeave = \_ -> Nothing
--        , onMouseClick = \id -> Just <| SelectPokemon id
--        , separateSelections = False
--        }


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

        SetQuery id text ->
            ( updatePokeSelectionQuery id text model, Cmd.none )



--SetAutoCompleteState autoMsg ->
--    let
--        ( newState, maybeMsg ) =
--            Menu.update updateConfig
--                autoMsg
--                model.howManyToShow
--                model.autocomplete.autoState
--                (acceptablePokemon model.autocomplete.query model.pokemonList)
--
--        autocomplete =
--            model.autocomplete
--
--        newModel =
--            { model | autocomplete = { autocomplete | autoState = newState } }
--    in
--    maybeMsg
--        |> Maybe.map (\updateMsg -> update updateMsg newModel)
--        |> Maybe.withDefault ( newModel, Cmd.none )
--SetQuery newQuery ->
--    let
--        autocomplete =
--            model.autocomplete
--    in
--    ( { model | autocomplete = { autocomplete | query = newQuery, showMenu = True } }
--    , Cmd.none
--    )
--SelectPokemon id ->
--    let
--        newMonMaybe =
--            List.filter (\poke -> poke.name == id) model.pokemonList
--                |> List.head
--
--        autocomplete =
--            model.autocomplete
--    in
--    ( { model
--        | autocomplete =
--            { autocomplete
--                | query =
--                    newMonMaybe
--                        |> Maybe.withDefault (RefValue "unown" "nourl")
--                        |> .name
--                , autoState = Menu.empty
--                , showMenu = False
--            }
--      }
--    , case newMonMaybe of
--        Just pkmn ->
--            getPokemon pkmn.name
--
--        Nothing ->
--            Cmd.none
--    )


view : Model -> Html Msg
view model =
    div []
        [ pokemonSelect model.selections [] Nothing
        , if List.isEmpty model.pokemonList then
            p [] [ text "ain't got none" ]

          else
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



--viewMenu : Autocomplete -> List RefValue -> Html.Html Msg
--viewMenu model pokemons =
--    Html.div [ Attrs.class "autocomplete-menu" ]
--        [ Html.map SetAutoCompleteState <|
--            Menu.view viewConfig
--                model.howManyToShow
--                model.autoState
--                (acceptablePokemon model.query pokemons)
--        ]


updatePokeSelectionQuery : String -> String -> Model -> Model
updatePokeSelectionQuery id newQuery current =
    let
        newAutocompletes =
            List.map
                (\selection ->
                    if selection.id == id then
                        { selection | query = newQuery }

                    else
                        selection
                )
                current.selections
    in
    { current | selections = newAutocompletes }


pokemonInputBox : List RefValue -> Autocomplete -> Html Msg
pokemonInputBox pokemonList autocomplete =
    div []
        [ img [ src "./media/pokemon/icons/0.png" ] []
        , input
            [ onInput (setQueryById autocomplete.id)
            , Attrs.class "autocomplete-input"
            , Attrs.value autocomplete.query
            , id ("pookers" ++ autocomplete.id)
            ]
            []
        ]


pokemonSelect : List Autocomplete -> List RefValue -> Maybe Pokemon -> Html Msg
pokemonSelect models pokeList maybeMon =
    div []
        (List.map
            (\model ->
                pokemonInputBox pokeList model
            --  div
            --  []
             --, if model.showMenu then
             --    viewMenu model pokeList
             --
             --  else
             --    Html.div [] []
             --, displayMon maybeMon
            )
            models
        )


setQueryById : String -> (String -> Msg)
setQueryById id =
    SetQuery id
