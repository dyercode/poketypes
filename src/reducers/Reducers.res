open Model

type state = {
  thinPokedex: array<string>,
  initialized: bool,
  team: array<option<Pokemon.pokemon>>,
  typedex: array<Pokemon.pokemonType>,
  useShadow: bool,
  useUnknown: bool,
}

let initalState = {
  thinPokedex: [],
  initialized: false,
  team: [None, None, None, None, None, None],
  typedex: [],
  useShadow: false,
  useUnknown: false,
}

let reducer = (state, action) => {
  switch action {
  | Actions.InitializePokedex => {
      ...state,
      initialized: true,
    }
  | Actions.SetPokedex(dex) => {
      ...state,
      thinPokedex: dex,
    }
  | Actions.SetTypedex(dex) => {
      ...state,
      typedex: dex,
    }
  | Actions.SetTeam(newMember, index) =>
    let newTeam = state.team->Array.mapWithIndex((oldMember, i) =>
      if i == index {
        newMember
      } else {
        oldMember
      }
    )
    {
      ...state,
      team: newTeam,
    }
  }
}
