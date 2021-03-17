module Effectiveness: {
  type effectiveness
  type pokemonType
  let attackEffectiveness: (pokemonType, array<pokemonType>) => effectiveness
} = {
  type effectiveness =
    | Immune
    | Quarter
    | Half
    | Neutral
    | Double
    | Quadruple

  type pokemonType = {
    name: string,
    noDamageFrom: array<string>,
    halfDamageFrom: array<string>,
    doubleDamageFrom: array<string>,
  }

  let singleTypeEffectiveness = (~attackType: pokemonType, ~defenseType: pokemonType) => {
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
    | [Half, Double] => Neutral
    | [Neutral, Neutral] => Neutral
    | [Neutral, Double] => Double
    | [Double, Double] => Quadruple
    | _ => Neutral
    }
  }

  export attackEffectiveness: (pokemonType, array<pokemonType>) => effectiveness = (
    attackType,
    defenseTypes,
  ) => {
    let si: pokemonType => effectiveness = singleTypeEffectiveness(~attackType, ~defenseType=_)
    let individualEffectivenesses: array<effectiveness> = Array.map(si, defenseTypes)
    lookup(individualEffectivenesses)
  }
}
