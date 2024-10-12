open Model.Pokemon
open Model.Effectiveness

@react.component
let make = (~state: Reducers.state) => {
  let typedex: array<pokemonType> = state.typedex
  let team: array<option<pokemon>> = state.team

  let findTypeByName = (td: array<pokemonType>, name: string): option<pokemonType> => {
    td->Array.find((t: pokemonType) => t.name === name)
  }

  let teamEffectiveness = (
    attackType: pokemonType,
    testEffective: Model.Effectiveness.effectiveness,
    inTeam: array<option<pokemon>>,
    typedex: array<pokemonType>,
  ): int => {
    let typeLookup = findTypeByName(typedex, ...)
    let lookupTypes = (mon: pokemon): array<pokemonType> => mon.types->Array.filterMap(typeLookup)

    inTeam
    ->Array.filterMap((member: option<pokemon>) => {
      member->Option.flatMap(m => {
        let memberTypes: array<pokemonType> = lookupTypes(m)
        if attackEffectiveness(attackType, memberTypes) === testEffective {
          Some(m)
        } else {
          None
        }
      })
    })
    ->Array.length
  }

  <table id="effectiveness">
    <thead>
      <tr>
        <th />
        <th> {React.string("0")} </th>
        <th> {React.string("1/4")} </th>
        <th> {React.string("1/2")} </th>
        <th> {React.string("Neutral")} </th>
        <th> {React.string("2x")} </th>
        <th> {React.string("4x")} </th>
      </tr>
    </thead>
    <tbody>
      {React.array(
        typedex
        ->Array.filter(t =>
          (t.name !== "shadow" || state.useShadow) && (t.name !== "unknown" || state.useUnknown)
        )
        ->Array.mapWithIndex((t: pokemonType, i) => {
          <tr key={string_of_int(i)}>
            <th> {React.string(t.name)} </th>
            <td> {React.int(teamEffectiveness(t, Immune, team, typedex))} </td>
            <td> {React.int(teamEffectiveness(t, Quarter, team, typedex))} </td>
            <td> {React.int(teamEffectiveness(t, Half, team, typedex))} </td>
            <td> {React.int(teamEffectiveness(t, Neutral, team, typedex))} </td>
            <td> {React.int(teamEffectiveness(t, Double, team, typedex))} </td>
            <td> {React.int(teamEffectiveness(t, Quadruple, team, typedex))} </td>
          </tr>
        }),
      )}
    </tbody>
  </table>
}
