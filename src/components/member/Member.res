@react.component
let make = (~index) =>
  <div className="member">
    <input
      type_="text"
      id={"member-" ++ string_of_int(index)}
      placeholder="Gotta catch at least one"
      list="pokedex-index"
    />
  </div>
