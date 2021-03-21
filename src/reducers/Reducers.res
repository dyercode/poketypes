type state = {
  thinPokedex: array<string>,
  initialized: bool,
}

let initalState = {
  thinPokedex: [],
  initialized: false,
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
  }
}
