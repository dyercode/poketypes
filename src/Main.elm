module Main exposing (main)

import Browser
import Client
import Decoders exposing (pokeListDecoder, pokemonDecoder)
import Html exposing (Html, div, img, input, li, p, text, ul)
import Html.Attributes as Attrs exposing (id, src)
import Html.Events exposing (onInput)
import Http
import Menu
import PokeApiDataTypes exposing (PokeList, Pokemon, RefValue, Type)
import Table


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
    , typedex : Maybe (List Type)
    , errorMessage : Maybe String
    , pokemonList : List RefValue
    , pokemonListReal : List Pokemon
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
      , typedex =
            Just
                [ { name = "Dark"
                  , damageRelations =
                        { doubleDamageFrom = []
                        , doubleDamageTo = []
                        , halfDamageFrom = []
                        , halfDamageTo = []
                        , noDamageFrom = [ { name = "Psychic", url = "" } ]
                        , noDamageTo = []
                        }
                  }
                , { name = "Psychic"
                  , damageRelations =
                        { doubleDamageFrom = [ { name = "Dark", url = "" } ]
                        , doubleDamageTo = []
                        , halfDamageFrom = [ { name = "Psychic", url = "" } ]
                        , halfDamageTo = []
                        , noDamageFrom = []
                        , noDamageTo = []
                        }
                  }
                , { name = "Ghost"
                  , damageRelations =
                        { doubleDamageFrom = [ { name = "Dark", url = "" } ]
                        , doubleDamageTo = []
                        , halfDamageFrom = []
                        , halfDamageTo = []
                        , noDamageFrom = []
                        , noDamageTo = []
                        }
                  }
                ]
      , errorMessage = Nothing
      , pokemonList = []
      , pokemonListReal =
            [ { name = "Lunala"
              , order = 0 -- wtf is this field?
              , types = [ "Ghost", "Psychic" ]
              }
            ]
      , selections = initPokeSelectAuto
      , selectedMon = Nothing
      , dropDownOpen = Nothing
      , howManyToShow = 5
      }
    , getPokemons (Client.baseUrl ++ Client.speciesEndpoint)
    )


type Msg
    = GetPokemonList String
    | GotPokeList (Result Http.Error PokeList)
    | GotPokemon (Result Http.Error Pokemon)
    | SetQuery String String
    | SetAutoCompleteState String Menu.Msg
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

        SetAutoCompleteState pokeId autoMsg ->
            let
                updatedConfig : Maybe ( Menu.State, Maybe Msg )
                updatedConfig =
                    updateConfigById pokeId autoMsg model
            in
            case updatedConfig of
                Just ( _, Nothing ) ->
                    ( model, Cmd.none )

                Just ( newState, Just justMsg ) ->
                    update justMsg (updateStateById model newState pokeId)

                Nothing ->
                    ( model, Cmd.none )

        SelectPokemon string ->
            ( { model | dropDownOpen = Nothing }, Cmd.none )


updateStateById : Model -> Menu.State -> String -> Model
updateStateById model newState id =
    let
        updatedSelections =
            List.map
                (\selection ->
                    if selection.id == id then
                        { selection | autoState = newState }

                    else
                        selection
                )
                model.selections
    in
    { model | selections = updatedSelections }


updateConfigById : String -> Menu.Msg -> Model -> Maybe ( Menu.State, Maybe Msg )
updateConfigById pokeId autoMsg model =
    List.filter (\selection -> selection.id == pokeId) model.selections
        |> List.head
        |> Maybe.map
            (\selection ->
                Menu.update updateConfig
                    autoMsg
                    model.howManyToShow
                    selection.autoState
                    (acceptablePokemon selection.query model.pokemonList)
            )



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
        [ pokemonSelect model Nothing
        , Table.printTable model.pokemonListReal
            (model.typedex
                |> Maybe.withDefault
                    [ { name = "Dark"
                      , damageRelations =
                            { noDamageFrom = []
                            , halfDamageFrom = []
                            , doubleDamageFrom = []
                            , noDamageTo = []
                            , halfDamageTo = []
                            , doubleDamageTo = []
                            }
                      }
                    ]
            )

        -- , if List.isEmpty model.pokemonList then
        -- p [] [ text "ain't got none" ]
        --
        --   else
        -- ul []
        -- (List.map (\n -> li [] [ text n.name ]) model.pokemonList)
        ]


getPokemons : String -> Cmd Msg
getPokemons url =
    Http.get
        { url = url
        , expect = Http.expectJson GotPokeList pokeListDecoder
        }


getPokemon : String -> Cmd Msg
getPokemon name =
    Http.get
        { url = Client.baseUrl ++ Client.pokemonEndpoint ++ name
        , expect = Http.expectJson GotPokemon pokemonDecoder
        }


displayMon : Maybe Pokemon -> Html Msg
displayMon pkmn =
    case pkmn of
        Just mon ->
            div []
                [ p [] [ text ("(#" ++ String.fromInt mon.order ++ ") " ++ mon.name) ]
                , ul [] (List.map (\t -> li [] [ text t ]) mon.types)
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


thingy : String -> (Menu.Msg -> Msg)
thingy id =
    SetAutoCompleteState id


viewMenu : PokemonSelectConfig r -> Autocomplete -> List RefValue -> Html Msg
viewMenu config model pokemons =
    div [ Attrs.class "autocomplete-menu" ]
        [ Html.map
            (thingy model.id)
            (Menu.view
                viewConfig
                config.howManyToShow
                model.autoState
                (acceptablePokemon model.query pokemons)
            )
        ]


updatePokeSelectionQuery : String -> String -> Model -> Model
updatePokeSelectionQuery pokeId newQuery current =
    let
        newAutocompletes =
            List.map
                (\selection ->
                    if selection.id == pokeId then
                        { selection | query = newQuery }

                    else
                        selection
                )
                current.selections
    in
    { current | selections = newAutocompletes, dropDownOpen = Just pokeId }


isOpen : Autocomplete -> Maybe String -> Bool
isOpen me current =
    case current of
        Just s ->
            me.id == s

        Nothing ->
            False


pokemonInputBox : List RefValue -> PokemonSelectConfig r -> Maybe String -> Autocomplete -> Html Msg
pokemonInputBox pokemonList config currentOpen autocomplete =
    div []
        [ img [ src "./media/pokemon/icons/0.png" ] []
        , input
            [ onInput (setQueryById autocomplete.id)
            , Attrs.class "autocomplete-input"
            , Attrs.value autocomplete.query
            , id ("poke-select-" ++ autocomplete.id)
            ]
            []
        , if isOpen autocomplete currentOpen then
            viewMenu config autocomplete pokemonList

          else
            Html.div [] []
        ]


pokemonSelect : Model -> Maybe Pokemon -> Html Msg
pokemonSelect model maybeMon =
    div []
        (List.map
            (\selection ->
                div []
                    [ pokemonInputBox model.pokemonList
                        model
                        model.dropDownOpen
                        selection
                    ]
            )
            --, displayMon maybeMon
            model.selections
        )


setQueryById : String -> (String -> Msg)
setQueryById pokeId =
    SetQuery pokeId
