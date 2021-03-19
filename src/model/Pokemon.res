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
