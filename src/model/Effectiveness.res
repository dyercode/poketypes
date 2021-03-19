module Effectiveness: {
  export type effectiveness
  let attackEffectiveness: (Pokemon.pokemonType, array<Pokemon.pokemonType>) => effectiveness
} = {
  export type effectiveness =
    | Immune
    | Quarter
    | Half
    | Neutral
    | Double
    | Quadruple

  let singleTypeEffectiveness = (
    ~attackType: Pokemon.pokemonType,
    ~defenseType: Pokemon.pokemonType,
  ) => {
    let hasAttack = typeList => {
      typeList->Belt.Array.keep(t => t == attackType.name)->Belt.Array.size > 0
    }

    if hasAttack(defenseType.doubleDamageFrom) {
      Double
    } else if hasAttack(defenseType.halfDamageFrom) {
      Half
    } else if hasAttack(defenseType.noDamageFrom) {
      Immune
    } else {
      Neutral
    }
  }

  let order = e => {
    switch e {
    | Immune => 0
    | Quarter => 1
    | Half => 2
    | Neutral => 3
    | Double => 4
    | Quadruple => 5
    }
  }

  let compare = (e1, e2) => order(e1) - order(e2)

  let lookup: array<effectiveness> => effectiveness = (types: array<effectiveness>) => {
    let sorted: array<effectiveness> = Array.copy(types)
    Array.sort(compare, sorted)
    switch sorted {
    | [e] => e
    | [Immune, _] => Immune
    | [Half, Half] => Quarter
    | [Half, Neutral] => Half
    | [Half, Double]
    | [Neutral, Neutral] =>
      Neutral
    | [Neutral, Double] => Double
    | [Double, Double] => Quadruple
    | _ => Neutral
    }
  }

  export attackEffectiveness: (Pokemon.pokemonType, array<Pokemon.pokemonType>) => effectiveness = (
    attackType,
    defenseTypes,
  ) => {
    let si = singleTypeEffectiveness(~attackType, ~defenseType=_)
    let individualEffectivenesses: array<effectiveness> = Array.map(si, defenseTypes)
    lookup(individualEffectivenesses)
  }
}
