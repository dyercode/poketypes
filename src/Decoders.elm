module Decoders exposing (listRefValDecoder, pokeListDecoder, pokemonDecoder, refValDecoder)

import Json.Decode exposing (Decoder, at, field, int, list, map2, map3, map5, maybe, string)
import PokeApiDataTypes exposing (PokeList, Pokemon, RefValue)


pokeListDecoder : Decoder PokeList
pokeListDecoder =
    map3 PokeList
        (field "count" int)
        (maybe (field "next" string))
        (field "results" (list refValDecoder))


pokemonDecoder : Decoder Pokemon
pokemonDecoder =
    map5 Pokemon
        (field "name" string)
        (field "order" int)
        (field "abilities" (list (listRefValDecoder "ability")))
        (field "types" (list (listRefValDecoder "type")))
        (field "moves" (list (listRefValDecoder "move")))


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

damageRelations

    
