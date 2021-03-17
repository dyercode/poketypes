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
      Js.Promise.then_(pokedex => {
        Js.log(pokedex)
        Js.Promise.resolve(dispatch(Actions.SetTypedex(pokedex)))
      }, PokeApiWrapper.getTypedex)->ignore
      None
    } else {
      None
    }
  })
  <div id="team">
    {React.array(
      [1, 2, 3, 4, 5, 6]->Belt.Array.mapWithIndex((i, _) =>
        <Member index=i key={string_of_int(i)} state=pokeState dispatch />
      ),
    )}
    <Effectiveness state=pokeState />
  </div>
}
