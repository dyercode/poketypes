module TypesTest exposing (..)

import Expect exposing (FloatingPointTolerance(..))
import PokeApiDataTypes exposing (RefValue, Type)
import Table exposing (typeDamageMultiplier, Effectiveness(..))
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "weakness"
        [ describe "a single type"
            [ test "is 2x weak to double damage attack"
                (\_ -> Expect.equal Double (typeDamageMultiplier dark [ psychic ]))
            , test "is immune to no damage attack"
                (\_ -> Expect.equal Immune (typeDamageMultiplier psychic [ dark ]))
            , test "is resistant to a half damage attack"
                (\_ -> Expect.equal Half (typeDamageMultiplier psychic [ psychic ]))
            ]
        , describe "a dual type"
            [ test "is immune if one of its types is immune"
                (\_ -> Expect.equal Immune (typeDamageMultiplier psychic [ psychic, dark ]))
            , test "is 4x weak if both types are double damage"
                (\_ -> Expect.equal Quadrouple (typeDamageMultiplier dark [ psychic, ghost ]))
            ]
        ]


nameToRefVal : String -> RefValue
nameToRefVal string =
    { name = string, url = "" }


psychicName : String
psychicName =
    "Psychic"


darkName : String
darkName =
    "Dark"


ghostName : String
ghostName =
    "Ghost"


dark : Type
dark =
    { name = darkName
    , damageRelations =
        { doubleDamageFrom = []
        , doubleDamageTo = []
        , halfDamageFrom = []
        , halfDamageTo = []
        , noDamageFrom = [ { name = psychicName, url = "" } ]
        , noDamageTo = []
        }
    }


psychic : Type
psychic =
    { name = psychicName
    , damageRelations =
        { doubleDamageFrom = [ nameToRefVal darkName ]
        , doubleDamageTo = []
        , halfDamageFrom = [ nameToRefVal psychicName ]
        , halfDamageTo = []
        , noDamageFrom = []
        , noDamageTo = []
        }
    }


ghost : Type
ghost =
    { name = ghostName
    , damageRelations =
        { doubleDamageFrom = [ nameToRefVal darkName ]
        , doubleDamageTo = []
        , halfDamageFrom = []
        , halfDamageTo = []
        , noDamageFrom = []
        , noDamageTo = []
        }
    }
