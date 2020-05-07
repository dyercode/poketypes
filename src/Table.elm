module Table exposing (Effectiveness(..), printTable, typeDamageMultiplier)

import Client
import Decoders exposing (pokeListDecoder)
import Html exposing (Html, text)
import Http
import List.Extra
import Maybe.Extra
import PokeApiDataTypes exposing (DamageRelations, PokeList, Pokemon, Type)


type TableMsg
    = GotTypes (Result Http.Error PokeList)
    | GotType (Result Http.Error Type)


type Effectiveness
    = Immune
    | Quarter
    | Half
    | Neutral
    | Double
    | Quadrouple


getTypes : Cmd TableMsg
getTypes =
    Http.get
        { url = Client.baseUrl ++ Client.typeEndpoint
        , expect = Http.expectJson GotTypes pokeListDecoder
        }


damageRelationMultiple : String -> DamageRelations -> Effectiveness
damageRelationMultiple attackType damageRelations =
    let
        doubleMultiplier =
            damageRelations.doubleDamageFrom
                |> List.any (\t -> t.name == attackType)
                |> (\bool ->
                        if bool then
                            Just Double

                        else
                            Nothing
                   )

        halfMultiplier =
            damageRelations.halfDamageFrom
                |> List.any (\t -> t.name == attackType)
                |> (\bool ->
                        if bool then
                            Just Half

                        else
                            Nothing
                   )

        immuneMultiplier =
            damageRelations.noDamageFrom
                |> List.any (\t -> t.name == attackType)
                |> (\bool ->
                        if bool then
                            Just Immune

                        else
                            Nothing
                   )
    in
    Maybe.Extra.orList [ doubleMultiplier, halfMultiplier, immuneMultiplier ]
        |> Maybe.withDefault Neutral


effectiveTable : List Effectiveness -> Effectiveness
effectiveTable effectivenesses =
    case effectivenesses of
        [ x ] ->
            x

        -- halfs
        [ Half, Half ] ->
            Quarter

        [ Half, Neutral ] ->
            Neutral

        [ Half, Double ] ->
            Neutral

        [ Half, Immune ] ->
            Immune

        -- neutrals
        [ Neutral, Half ] ->
            Quarter

        [ Neutral, Neutral ] ->
            Neutral

        [ Neutral, Double ] ->
            Double

        [ Neutral, Immune ] ->
            Immune

        -- doubles
        [ Double, Half ] ->
            Quarter

        [ Double, Neutral ] ->
            Double

        [ Double, Double ] ->
            Quadrouple

        [ Double, Immune ] ->
            Immune

        _ ->
            Neutral


typeDamageMultiplier : Type -> List Type -> Effectiveness
typeDamageMultiplier attackType defenderTypes =
    defenderTypes
        |> List.map (\t -> damageRelationMultiple attackType.name t.damageRelations)
        |> effectiveTable


upgradeType : List Type -> String -> Maybe Type
upgradeType typedex name =
    List.filter (\t -> t.name == name) typedex
        |> List.head


printTable : List Pokemon -> List Type -> Html msg
printTable team typedex =
    Html.table []
        [ Html.thead []
            [ Html.th [] []
            , Html.th [] [ text "0" ]
            , Html.th [] [ text "1/4" ]
            , Html.th [] [ text "1/2" ]
            , Html.th [] [ text "Neutral" ]
            , Html.th [] [ text "2x" ]
            , Html.th [] [ text "4x" ]
            ]
        , Html.tbody []
            (List.map
                (\attackType ->
                    let
                        teamTypes : List (List Type)
                        teamTypes =
                            List.map .types team
                                |> List.map (List.filterMap (upgradeType typedex))

                        effectivenesses : List Effectiveness
                        effectivenesses =
                            List.map (typeDamageMultiplier attackType) teamTypes
                    in
                    Html.tr []
                        [ Html.th [] [ text attackType.name ]
                        , Html.td [] [ text (String.fromInt (List.Extra.count (\pk -> pk == Immune) effectivenesses)) ]
                        , Html.td [] [ text (String.fromInt (List.Extra.count (\pk -> pk == Quarter) effectivenesses)) ]
                        , Html.td [] [ text (String.fromInt (List.Extra.count (\pk -> pk == Half) effectivenesses)) ]
                        , Html.td [] [ text (String.fromInt (List.Extra.count (\pk -> pk == Neutral) effectivenesses)) ]
                        , Html.td [] [ text (String.fromInt (List.Extra.count (\pk -> pk == Double) effectivenesses)) ]
                        , Html.td [] [ text (String.fromInt (List.Extra.count (\pk -> pk == Quadrouple) effectivenesses)) ]
                        ]
                )
                typedex
            )
        ]
