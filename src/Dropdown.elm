module Dropdown exposing (Model, Msg, update, view)

import Html exposing (Html, div, img, input)
import Html.Attributes as Attrs exposing (id, src)
import Html.Events exposing (onInput)
import Menu
import PokeApiDataTypes exposing (Pokemon, RefValue)


type Msg
    = SetQuery String String


type alias Autocomplete =
    { query : String
    , autoState : Menu.State
    , id : String
    }


type alias Model =
    { team : List Pokemon
    , selections : List Autocomplete
    }


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetQuery id text ->
            ( updatePokeSelectionQuery id text model, Cmd.none )



-- SetAutoCompleteState ->
-- ( model, Cmd.none )


view : Model -> Html Msg
view model =
    pokemonSelect model.selections [] Nothing


setQueryById : String -> (String -> Msg)
setQueryById id =
    SetQuery id


bareMinSingleThing : List RefValue -> Autocomplete -> Html Msg
bareMinSingleThing pokemonList autocomplete =
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
                bareMinSingleThing pokeList model
             --div
             --[]
             --[ img [ src "./media/pokemon/icons/0.png" ] []
             --, input
             --    [ --onInput SetQuery
             --      Attrs.class "autocomplete-input"
             --    , Attrs.value model.query
             --    , id ("pookers" ++ model.id)
             --    ]
             --    []
             --]
             --, if model.showMenu then
             --    viewMenu model pokeList
             --
             --  else
             --    Html.div [] []
             --, displayMon maybeMon
            )
            models
        )
