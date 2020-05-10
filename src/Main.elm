module Main exposing (main)

import Browser
import Browser.Dom
import Client
import Decoders exposing (pokeListDecoder, pokeTypeDecoder, pokemonDecoder)
import Html exposing (Html, div, img, input, li, p, text, ul)
import Html.Attributes as Attrs exposing (id, src)
import Html.Events exposing (onInput)
import Http
import PokeApiDataTypes exposing (PokeList, Pokemon, RefValue, Type)
import Table
import Task


type alias PokemonSelectConfig r =
    { r
        | howManyToShow : Int
        , dropDownOpen : Maybe String
    }


type alias Autocomplete =
    { query : String
    , id : String
    }


type alias Model =
    { pokedex : Maybe PokeList
    , typedex : List Type
    , errorMessage : Maybe String
    , pokemonList : List String
    , pokemonListReal : List Pokemon
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
    { query = ""
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
      , typedex = []
      , errorMessage = Nothing
      , pokemonList = []
      , pokemonListReal =
            [ { name = "Lunala"
              , order = 0 -- wtf is this field?
              , types = [ "ghost", "psychic" ]
              }
            ]
      , selections = initPokeSelectAuto
      , dropDownOpen = Nothing
      , howManyToShow = 5
      }
    , Cmd.batch
        [ getPokemons (Client.baseUrl ++ Client.speciesEndpoint)
        , getTypes
        ]
    )


type Msg
    = GetPokemonList String
    | GotPokeList (Result Http.Error PokeList)
    | GotPokemon (Result Http.Error Pokemon)
    | SetQuery String String
    | SelectPokemon String
    | GotTypes (Result Http.Error PokeList)
    | GotType (Result Http.Error Type)
    | NoOp


buildErrorMessage : Http.Error -> String
buildErrorMessage httpError =
    case httpError of
        Http.BadUrl message ->
            message

        Http.Timeout ->
            "Server is taking too long to respond."

        Http.NetworkError ->
            "unable to reach server."

        Http.BadStatus sc ->
            "request failed with status code: " ++ String.fromInt sc

        Http.BadBody message ->
            message


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetPokemonList url ->
            ( model, getPokemons url )

        GotPokemon (Ok pkmn) ->
            ( { model | pokemonListReal = pkmn :: model.pokemonListReal }
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

        SetQuery id query ->
            ( updatePokeSelectionQuery id query model
            , pokemonSelected query id model.pokemonList
            )

        SelectPokemon name ->
            ( { model | dropDownOpen = Nothing }
            , getPokemon name
            )

        GotTypes (Ok types) ->
            ( model, Cmd.batch (List.map getType types.results) )

        GotTypes (Err errMessage) ->
            ( { model | errorMessage = Just (buildErrorMessage errMessage) }, Cmd.none )

        GotType (Ok pokeType) ->
            ( { model | typedex = pokeType :: model.typedex }, Cmd.none )

        GotType (Err errMessage) ->
            ( { model | errorMessage = Just (buildErrorMessage errMessage) }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ pokemonSelect model Nothing
        , Html.p [] [ text (model.errorMessage |> Maybe.withDefault "") ]
        , Table.printTable model.pokemonListReal model.typedex
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


getTypes : Cmd Msg
getTypes =
    Http.get
        { url = Client.baseUrl ++ Client.typeEndpoint
        , expect = Http.expectJson GotTypes pokeListDecoder
        }


getType : String -> Cmd Msg
getType url =
    Http.get
        { url = Client.baseUrl ++ Client.typeEndpoint ++ url
        , expect = Http.expectJson GotType pokeTypeDecoder
        }


pokemonSelected : String -> String -> List String -> Cmd Msg
pokemonSelected name id dex =
    let
        htmlId =
            pokemonSelectId id
    in
    if List.any (\m -> name == String.toLower m) dex then
        Task.attempt (\_ -> NoOp) (Browser.Dom.blur (htmlId))
    else
        Cmd.none


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
    { current | selections = newAutocompletes }


isIn : String -> List String -> Bool
isIn value list =
    List.any (\item -> String.toLower value == String.toLower item) list


pokemonInputBox : List String -> PokemonSelectConfig r -> Autocomplete -> Html Msg
pokemonInputBox pokemonList config autocomplete =
    div []
        [ img [ src "./media/pokemon/icons/0.png" ] []
        , input
            ([ onInput (setQueryById autocomplete.id)
             , Attrs.class "autocomplete-input"
             , Attrs.value autocomplete.query
             , id (pokemonSelectId autocomplete.id)
             ]
             -- this is hacky as hell but works around blur() not closing the complete menu until I write my own
                ++ (if isIn autocomplete.query pokemonList then
                        []

                    else
                        [ Attrs.list ("pokemon-datalist-" ++ autocomplete.id) ]
                   )
            )
            []
        ]


pokemonSelectId : String -> String
pokemonSelectId index =
    "pokedex-" ++ index


pokemonSelect : Model -> Maybe Pokemon -> Html Msg
pokemonSelect model maybeMon =
    div []
        (List.map
            (\selection ->
                div []
                    {- This particular datalist could probably be universal for all 6 team slots. However, I am going
                       to be generalizing it to use with movesets as well, which will all need their own, oft-changing lists
                    -}
                    [ Html.datalist [ id ("pokemon-datalist-" ++ selection.id) ]
                        (List.map (\name -> Html.option [ Attrs.value name ] []) model.pokemonList)
                    , pokemonInputBox model.pokemonList
                        model
                        selection
                    ]
            )
            --, displayMon maybeMon
            model.selections
        )


setQueryById : String -> (String -> Msg)
setQueryById pokeId =
    SetQuery pokeId
