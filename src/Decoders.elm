module Decoders exposing (listRefValDecoder, pokeListDecoder, pokeTypeDecoder, pokemonApiDecoder, pokemonDecoder, refValDecoder)

import Json.Decode exposing (Decoder, at, field, int, list, map2, map3, map5, map6, maybe, string)
import PokeApiDataTypes exposing (DamageRelations, PokeList, Pokemon, RefValue, Type)


pokeListDecoder : Decoder PokeList
pokeListDecoder =
    map3 PokeList
        (field "count" int)
        (maybe (field "next" string))
        (field "results" (list (Json.Decode.map getName refValDecoder)))


type alias PokemonApi =
    { name : String
    , order : Int -- Dex number?
    , abilities : List RefValue
    , types : List RefValue
    , moves : List RefValue
    }


pokemonApiDecoder : Decoder PokemonApi
pokemonApiDecoder =
    map5 PokemonApi
        (field "name" string)
        (field "order" int)
        (field "abilities" (list (listRefValDecoder "ability")))
        (field "types" (list (listRefValDecoder "type")))
        (field "moves" (list (listRefValDecoder "move")))


getName : RefValue -> String
getName rv =
    rv.name


pokemonDecoder : Decoder Pokemon
pokemonDecoder =
    map3 Pokemon
        (field "name" string)
        (field "order" int)
        (field "types" (list (Json.Decode.map getName (listRefValDecoder "type"))))


refValDecoder : Decoder RefValue
refValDecoder =
    map2 RefValue
        (field "name" string)
        (field "url" string)


listRefValDecoder : String -> Decoder RefValue
listRefValDecoder key =
    map2 RefValue
        (at [ key, "name" ] string)
        (at [ key, "url" ] string)


damageRelations : Decoder DamageRelations
damageRelations =
    map6 DamageRelations
        (field "double_damage_from" (list refValDecoder))
        (field "double_damage_to" (list refValDecoder))
        (field "half_damage_from" (list refValDecoder))
        (field "half_damage_to" (list refValDecoder))
        (field "no_damage_from" (list refValDecoder))
        (field "no_damage_to" (list refValDecoder))


pokeTypeDecoder : Decoder Type
pokeTypeDecoder =
    map2 Type
        (field "name" string)
        (field "damage_relations" damageRelations)
