let member = key => <p key=j`$key`> {React.string("member")} </p>

@react.component
let make = (~selecteds) =>
  <div id="team">
    {ReasonReact.array(selecteds->Belt.Array.mapWithIndex((i, _) => member(i)))}
  </div>
