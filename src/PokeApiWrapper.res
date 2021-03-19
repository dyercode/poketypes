let baseUrl = "https://pokeapi.co/api/v2/"
let typeEndpoint = "type/"
let pokemonEndpoint = "pokemon/"
let pokemonListStartUrl: string = baseUrl ++ pokemonEndpoint ++ "?limit=60"
let typeListStartUrl: string = baseUrl ++ typeEndpoint ++ "?limit=60"

// function fromTypeApi(ta: TypeApi): Type {
//   return {
//     name: ta.name,
//     noDamageFrom: ta.damage_relations.no_damage_from.map((d) => d.name),
//     halfDamageFrom: ta.damage_relations.half_damage_from.map((d) => d.name),
//     doubleDamageFrom: ta.damage_relations.double_damage_from.map((d) => d.name),
//   } as Type;
// }

// function fromPokemonApi(pa: PokemonApi): Pokemon {
//   return {
//     name: pa.name,
//     types: pa.types.map((t) => t.type.name),
//     moves: pa.moves.map((t) => t.move.name),
//     knownMoves: {
//       move1: none,
//       move2: none,
//       move3: none,
//       move4: none,
//     } as KnownMoves,
//   } as Pokemon;
// }

// class DamageRelationsApi {
//   no_damage_from: RefValue[];
//   half_damage_from: RefValue[];
//   double_damage_from: RefValue[];
// }

// class TypeApi {
//   name: string;
//   damage_relations: DamageRelationsApi;
// }

// export function getPokedex(
//   dex: string[] = [],
//   url: string = pokemonListStartUrl
// ): Promise<string[]> {
//   return fetch(url)
//     .then((response) => response.json())
//     .then((soFar: ListApi) => {
//       let newNames = [];
//       if (soFar.results) {
//         newNames = soFar.results.map((rv) => rv.name);
//       }
//       const newDex = dex.concat(newNames);
//       if (soFar.next !== null) {
//         return getPokedex(newDex, soFar.next);
//       } else {
//         return newDex;
//       }
//     });
// }

// function getThinTypedex(
//   dex: string[] = [],
//   url: string = typeListStartUrl
// ): Promise<string[]> {
//   const initResult: Promise<ListApi> = fetch(url).then((response) =>
//     response.json()
//   );
//   return initResult.then((soFar: ListApi) => {
//     let newNames = [];
//     if (soFar.results) {
//       newNames = soFar.results.map((rv) => rv.name);
//     }
//     const newDex = dex.concat(newNames);
//     if (soFar.next !== null) {
//       return getThinTypedex(newDex, soFar.next);
//     } else {
//       return newDex;
//     }
//   });
// }

// export function getTypedex(): Promise<Type[]> {
//   return getThinTypedex()
//     .then((names: string[]) => {
//       const fullTypes: Promise<TypeApi>[] = names.map((name) => {
//         return fetch(baseUrl + typeEndpoint + name).then((r) => r.json());
//       });
//       return Promise.all(fullTypes);
//     })
//     .then((apiData: TypeApi[]) => {
//       return apiData.map(fromTypeApi);
//     });
/// function fromPokemonApi(pa: PokemonApi): Pokemon {
//   return {
//     name: pa.name,
//     types: pa.types.map((t) => t.type.name),
//     moves: pa.moves.map((t) => t.move.name),
//     knownMoves: {
//       move1: none,
//       move2: none,
//       move3: none,
//       move4: none,
//     } as KnownMoves,
//   } as Pokemon;

type refValue = {
  name: string,
  url: string,
}

type listApi = {
  name: string,
  next: option<string>,
  results: array<refValue>,
}

type move = {
    type: array<refValue>
}
type apiType = {
    type: array<refValue>
}

type pokemonApi = {
  name: string,
  types: array<apiType>,
  moves: array<move>,
}

@scope("JSON") @val
external rawParseJson: string => pokemonApi = "parse"

// @scope("window") @val
// external fetch: string => Js.Promise.t<Js.Response> = "fetch"

let fromPokemonApi: pokemonApi => Pokemon.pokemon = (pokeApi: pokemonApi) => {
  name: pokeApi.name,
  types: pokeApi.types->Belt.Array.map(rv => rv.name),
  moves: pokeApi.moves->Belt.Array.map(rv => rv.name),
  knownMoves: (None, None, None, None),
}

export getPokemon = name => Fetch.fetch(baseUrl ++ pokemonEndpoint ++ name)->Js.Promise.then_(r => {
    Js.Console.log(r)
    Fetch.Response.text(r)
  }, _)->Js.Promise.then_(
    text => rawParseJson(text)->Js.Promise.resolve,
    _,
  )->Js.Promise.then_(api => fromPokemonApi(api)->Js.Promise.resolve, _)
