module PokeApiDataTypes exposing (PokeList, Pokemon, RefValue)


type alias PokeList =
    { count : Int
    , next : Maybe String
    , results : List RefValue
    }


type alias RefValue =
    { name : String
    , url : String
    }


type alias Pokemon =
    { name : String
    , order : Int
    , abilites : List RefValue
    , types : List RefValue
    , moves : List RefValue
    }
