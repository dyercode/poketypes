@react.component
let make = (~index: int, ~moves: array<string>) => {
  let moveId = "move-"
  let datalistId = "pokemon-move-index-" ++ string_of_int(index)

  <div>
    <datalist id={datalistId}>
      {React.array(
        moves->Array.mapWithIndex((value, i) => {
          <option key={string_of_int(i)} value />
        }),
      )}
    </datalist>
    <label htmlFor={moveId}> {React.string("move " ++ string_of_int(index))} </label>
    <input id={moveId} placeholder={"move " ++ index->Int.toString} list={datalistId} />
  </div>
}
