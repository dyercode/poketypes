module Dropdown exposing (Autocomplete, DropdownId, Msg, bareMinSingleThing)

import Html exposing (Html, div, img, input)
import Html.Attributes as Attrs exposing (id, src)
import Html.Events exposing (onInput)
import Menu exposing (Msg)
import PokeApiDataTypes exposing (Pokemon, RefValue)



--                   pokemon auto  -> text   -> dropdownOpen -> element
type alias Model =
    {
     team: List Pokemon
     , selections: List Autocomplete

    }

updatePokeSelectionQuery: String -> query -> List Autocomplete -> List Autocomplete
updatePokeSelectionQuery id newQuery current =
    List.map
        (\autocomplete ->
        if autocomplete.id == id then
            {autocomplete | query = newQuery}
        else
            autocomplete
        )
        current



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetQuery id text ->
            (GotTeam (updatePokeSelectionQuery id text model.selections), Cmd.none)

        SetAutoCompleteState ->

type alias DropdownId =
    String


type alias Autocomplete =
    { query : String
    , autoState : Menu.State
    , id : String
    }


type Msg
    = SetAutoCompleteState
    | SetQuery String String


setQueryById : String -> (String -> Msg)
setQueryById id =
    SetQuery id

bareMinSingleThing : List RefValue -> String -> Bool -> String -> Html msg
bareMinSingleThing pokemonList query droppedDown selectId =
    div []
        [ img [ src "./media/pokemon/icons/0.png" ] []
        , input
            [ onInput (setQueryById selectId)
            , Attrs.class "autocomplete-input"
            , Attrs.value query
            , id ("pookers" ++ selectId)
            ]
            []
        ]


pokemonSelect : List Autocomplete -> List RefValue -> Maybe Pokemon -> Html Msg
pokemonSelect models pokeList maybeMon =
    div []
        (List.map
            (\model ->
                bareMinSingleThing pokeList model.query False model.id
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
