module Pokemon = {
  type pokemonType = {
    name: string,
    noDamageFrom: array<string>,
    halfDamageFrom: array<string>,
    doubleDamageFrom: array<string>,
  }

  type knownMoves = (option<string>, option<string>, option<string>, option<string>)

  type pokemon = {
    name: string,
    types: array<string>,
    moves: array<string>,
    knownMoves: knownMoves,
  }
}

module Move = {
  type move = {
    name: string,
    pokemonType: Pokemon.pokemonType,
  }
}

module Type = {
  type pokemonType = {
    name: string,
    noDamageFrom: array<string>,
    halfDamageFrom: array<string>,
    doubleDamageFrom: array<string>,
  }
}

module Effectiveness = {
  // type effectiveness
  // let attackEffectiveness: (Pokemon.pokemonType, array<Pokemon.pokemonType>) => effectiveness
  // } = {
  type effectiveness =
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
      typeList->Array.filter(String.equal(_, attackType.name))->Array.length > 0
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

  let compare = (e1, e2) => Ordering.fromInt(order(e1) - order(e2))
  // let compare = (e1, e2) => Ordering.map(order, Int32.compare) ->Ordering.reverse

  let lookup: array<effectiveness> => effectiveness = (types: array<effectiveness>) => {
    let sorted: array<effectiveness> = Array.copy(types)
    Array.sort(sorted, compare)
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

  let attackEffectiveness: (Pokemon.pokemonType, array<Pokemon.pokemonType>) => effectiveness = (
    attackType,
    defenseTypes,
  ) => {
    let si = singleTypeEffectiveness(~attackType, ~defenseType=_)
    let individualEffectivenesses: array<effectiveness> = Array.map(defenseTypes, si)
    lookup(individualEffectivenesses)
  }
}
