let member = key => <p key=j`$key`> {React.string("member")} </p>

@react.component
let make = (~selecteds) => {
  let (pokeState, dispatch) = React.useReducer(Reducers.reducer, Reducers.initalState)
  <div id="team">
    {ReasonReact.array(
      selecteds->Belt.Array.mapWithIndex((i, _) => <Member index=i state=pokeState />),
    )}
  </div>
}
