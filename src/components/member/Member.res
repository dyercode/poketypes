@react.component
let make = (~index, ~state: Reducers.state) => {
  let thinDex = state.thinPokedex
  let (thing, setThing) = React.useState(_ => "")
  let datalistId = "pokedex-index-" ++ string_of_int(index)
  <div className="member">
    <datalist id={datalistId}>
      {ReasonReact.array(
        thinDex->Belt.Array.mapWithIndex((i, name) => <option key={string_of_int(i)} value=name />),
      )}
    </datalist>
    <input
      type_="text"
      id={"member-" ++ string_of_int(index)}
      placeholder="Gotta catch at least one"
      list={datalistId}
    />
  </div>
}
