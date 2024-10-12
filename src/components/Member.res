@react.component
let make = (~index, ~state: Reducers.state, ~dispatch) => {
  let thinDex = state.thinPokedex
  let datalistId = "pokedex-index-" ++ string_of_int(index)
  let onChange = evt => {
    ReactEvent.Form.preventDefault(evt)
    let value: string = ReactEvent.Form.target(evt)["value"]
    if thinDex->Array.includes(value) {
      Promise.then(PokeApiWrapper.getPokemon(value), pokemon => {
        Promise.resolve(dispatch(Actions.SetTeam(Some(pokemon), index)))
      })->ignore
    } else {
      dispatch(Actions.SetTeam(None, index))
    }
  }
  <div className="member">
    <datalist id={datalistId}>
      {React.array(
        thinDex->Array.mapWithIndex((name, i) => <option key={string_of_int(i)} value=name />),
      )}
    </datalist>
    <input
      type_="text"
      id={"member-" ++ string_of_int(index)}
      placeholder="Gotta catch at least one"
      list={datalistId}
      onChange
    />
    <Moves member={state.team->Array.get(index)->Option.flatMap(a => a)} />
  </div>
}
