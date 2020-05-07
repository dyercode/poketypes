module PokeApiDataTypes exposing (DamageRelation, DamageRelations, PokeList, Pokemon, RefValue, Type)


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
    , types : List String
    }


type alias DamageRelation =
    { doubleDamageFrom : List String
    , doubleDamageTo : List String
    , halfDamageFrom : List String
    , halfDamageTo : List String
    , noDamageFrom : List String
    , noDamageTo : List String
    }


getName : RefValue -> String
getName rv =
    rv.name


getNames : List RefValue -> List String
getNames rv =
    List.map getName rv


type alias Type =
    { name : String
    , damageRelations : DamageRelations
    }



--damageRelationHelper : DamageRelationApi -> DamageRelation
--damageRelationHelper api =
--    { doubleDamageFrom = getNames api.doubleDamageFrom
--    , doubleDamageTo = getNames api.doubleDamageTo
--    , halfDamageFrom = getNames api.halfDamageFrom
--    , halfDamageTo = getNames api.halfDamageTo
--    , noDamageFrom = getNames api.noDamageFrom
--    , noDamageTo = getNames api.noDamageTo
--    }
--


type alias DamageRelations =
    { doubleDamageFrom : List RefValue
    , doubleDamageTo : List RefValue
    , halfDamageFrom : List RefValue
    , halfDamageTo : List RefValue
    , noDamageFrom : List RefValue
    , noDamageTo : List RefValue
    }
