@react.component
let make = (~index, ~state: Reducers.state) => {
  let thinDex = state.thinPokedex
  let (thing, setThing) = React.useState(_ => "")
  <div className="member">
    <input
      type_="text"
      id={"member-" ++ string_of_int(index)}
      placeholder="Gotta catch at least one"
      list="pokedex-index"
    />
    <datalist>
      {ReasonReact.array(
        thinDex->Belt.Array.mapWithIndex((i, name) => <option key={string_of_int(i)} value=name />),
      )}
    </datalist>
  </div>
}
