@react.component
let make = () => {
  let (pokeState: Reducers.state, dispatch) = React.useReducer(
    Reducers.reducer,
    Reducers.initalState,
  )
  React.useEffect0(() => {
    if !pokeState.initialized {
      dispatch(Actions.InitializePokedex)
      PokeApiWrapper.getPokedex
      ->Promise.thenResolve(pokedex => {
        Console.log(pokedex)
        dispatch(Actions.SetPokedex(pokedex))
      })
      ->ignore

      Promise.thenResolve(PokeApiWrapper.getTypedex, pokedex => {
        Console.log(pokedex)
        dispatch(Actions.SetTypedex(pokedex))
      })->ignore
      None
    } else {
      None
    }
  })
  <section id="main">
    <Effectiveness state=pokeState />
    <div id="team">
      {React.array(
        Array.make(~length=6, 0)->Array.mapWithIndex((_, i) =>
          <Member index=i key={string_of_int(i)} state=pokeState dispatch />
        ),
      )}
    </div>
  </section>
}
