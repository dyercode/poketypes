@react.component
let make = () => {
  let (pokeState: Reducers.state, dispatch) = React.useReducer(
    Reducers.reducer,
    Reducers.initalState,
  )
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
  <section id="main">
    <Effectiveness state=pokeState />
    <div id="team">
      {React.array(
        Belt.Array.range(1, 6)->Belt.Array.map(i =>
          <Member index=i key={string_of_int(i)} state=pokeState dispatch />
        ),
      )}
    </div>
  </section>
}
