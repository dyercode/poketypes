let baseUrl: string = "https://pokeapi.co/api/v2/"
let typeEndpoint: string = "type/"
let pokemonEndpoint: string = "pokemon/"
let pokemonListStartUrl: string = baseUrl ++ pokemonEndpoint ++ "?limit=60"
let typeListStartUrl: string = baseUrl ++ typeEndpoint ++ "?limit=60"

open Promise

type refValue = {
  name: string,
  url: string,
}

type listApi = {
  name: string,
  next: Nullable.t<string>,
  results: array<refValue>,
}

type damageRelationsApi = {
  no_damage_from: array<refValue>,
  half_damage_from: array<refValue>,
  double_damage_from: array<refValue>,
}

type typeApi = {
  name: string,
  damage_relations: damageRelationsApi,
}

type move = {"move": refValue}
type pokeType = {"type": refValue}
type pokemonApi = {
  name: string,
  types: array<pokeType>,
  moves: array<move>,
}

@scope("JSON") @val
external pokemonApiParseJson: string => pokemonApi = "parse"

@scope("JSON") @val
external listApiParseJson: string => listApi = "parse"

@scope("JSON") @val
external typeApiParseJson: string => typeApi = "parse"

let fromPokemonApi: pokemonApi => Model.Pokemon.pokemon = (pokeApi: pokemonApi) => {
  name: pokeApi.name,
  types: pokeApi.types->Array.map(rv => rv["type"].name),
  moves: pokeApi.moves->Array.map((rv: move) => rv["move"].name),
  knownMoves: (None, None, None, None),
}

let fetchApi = (url: string, jsonParser) => {
  open Fetch

  get(url)
  ->then(Response.text)
  ->thenResolve(jsonParser)
}

let getPokemon = name => {
  let url: string = baseUrl ++ pokemonEndpoint ++ name
  fetchApi(url, pokemonApiParseJson)->thenResolve(fromPokemonApi)
}

let rec fetchListApi = (url, dex) => {
  let initResult: promise<listApi> = fetchApi(url, listApiParseJson)

  initResult->then((soFar: listApi) => {
    let newNames = soFar.results->Array.map(rv => rv.name)
    let newDex = Array.concat(dex, newNames)

    switch Nullable.toOption(soFar.next) {
    | None => resolve(newDex)
    | Some(more) => fetchListApi(more, newDex)
    }
  })
}

let getThinTypedex = () => {
  fetchListApi(typeListStartUrl, [])
}

let getPokedex: Promise.t<array<string>> = {
  fetchListApi(pokemonListStartUrl, [])
}

let toNames: array<refValue> => array<string> = inpu => inpu->Array.map(rv => rv.name)

let fromTypeApi: typeApi => Model.Pokemon.pokemonType = ta => {
  name: ta.name,
  noDamageFrom: ta.damage_relations.no_damage_from->toNames,
  halfDamageFrom: ta.damage_relations.half_damage_from->toNames,
  doubleDamageFrom: ta.damage_relations.double_damage_from->toNames,
}

let getTypedex = {
  getThinTypedex()
  ->then(tt => {
    tt
    ->Array.map(name => {
      let url: string = baseUrl ++ typeEndpoint ++ name
      fetchApi(url, typeApiParseJson)
    })
    ->all
  })
  ->thenResolve(Array.map(_, fromTypeApi))
}
