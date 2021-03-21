let member = key => <p key=j`$key`> {React.string("member")} </p>

@react.component
let make = () => {
  let (pokeState, dispatch) = React.useReducer(Reducers.reducer, Reducers.initalState)
  React.useEffect0(() => {
    if !pokeState.initialized {
      dispatch(Actions.InitializePokedex)
      Js.Promise.then_(pokedex => {
        Js.log(pokedex)
        Js.Promise.resolve(dispatch(Actions.SetPokedex(pokedex)))
      }, PokeApiWrapper.getPokedex)->ignore
      None
    } else {
      None
    }
  })
  <div id="team">
    {ReasonReact.array(
      [1, 2, 3, 4, 5, 6]->Belt.Array.mapWithIndex((i, _) =>
        <Member index=i key={string_of_int(i)} state=pokeState />
      ),
    )}
  </div>
}
