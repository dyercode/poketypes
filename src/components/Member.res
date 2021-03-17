@react.component
let make = (~index, ~state: Reducers.state, ~dispatch) => {
  let thinDex = state.thinPokedex
  let datalistId = "pokedex-index-" ++ string_of_int(index)
  let onChange = evt => {
    ReactEvent.Form.preventDefault(evt)
    let value: string = ReactEvent.Form.target(evt)["value"]
    if thinDex->Js.Array2.includes(value) {
      Js.Promise.then_(pokemon => {
        Js.Promise.resolve(dispatch(Actions.SetTeam(Some(pokemon), index)))
      }, PokeApiWrapper.getPokemon(value))->ignore
    } else {
      dispatch(Actions.SetTeam(None, index))
    }
  }
  <div className="member">
    <datalist id={datalistId}>
      {React.array(
        thinDex->Belt.Array.mapWithIndex((i, name) => <option key={string_of_int(i)} value=name />),
      )}
    </datalist>
    <input
      type_="text"
      id={"member-" ++ string_of_int(index)}
      placeholder="Gotta catch at least one"
      list={datalistId}
      onChange
    />
    <Moves member={state.team->Belt.Array.get(index)->Belt.Option.flatMap(a => a)} />
  </div>
}
