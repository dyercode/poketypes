@react.component
let make = (~member: option<Model.Pokemon.pokemon>) => {
  switch member {
  | Some(pokemon) =>
    <ol>
      <li>
        <Move index={1} moves={pokemon.moves} />
      </li>
      <li>
        <Move index={2} moves={pokemon.moves} />
      </li>
      <li>
        <Move index={3} moves={pokemon.moves} />
      </li>
      <li>
        <Move index={4} moves={pokemon.moves} />
      </li>
    </ol>
  | None => React.null
  }
}
