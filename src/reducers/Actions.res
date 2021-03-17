type actions =
  | InitializePokedex
  | SetPokedex(array<string>)
  | SetTypedex(array<Model.Pokemon.pokemonType>)
  | SetTeam(option<Model.Pokemon.pokemon>, int)
