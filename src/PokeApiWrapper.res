let baseUrl = "https://pokeapi.co/api/v2/"
let typeEndpoint = "type/"
let pokemonEndpoint = "pokemon/"
let pokemonListStartUrl: string = baseUrl ++ pokemonEndpoint ++ "?limit=60"
let typeListStartUrl: string = baseUrl ++ typeEndpoint ++ "?limit=60"

type refValue = {
  name: string,
  url: string,
}

type listApi = {
  name: string,
  next: Js.Nullable.t<string>,
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

let fromPokemonApi: pokemonApi => Pokemon.pokemon = (pokeApi: pokemonApi) => {
  name: pokeApi.name,
  types: pokeApi.types->Belt.Array.map(rv => rv["type"].name),
  moves: pokeApi.moves->Belt.Array.map((rv: move) => rv["move"].name),
  knownMoves: (None, None, None, None),
}

let then_ = Js.Promise.then_

let fetchApi = (url: string, jsonParser) => {
  Fetch.fetch(url)->then_(Fetch.Response.text, _)->then_(text => {
    jsonParser(text)->Js.Promise.resolve
  }, _)
}

export getPokemon = name => {
  let url = baseUrl ++ pokemonEndpoint ++ name
  fetchApi(url, pokemonApiParseJson)->then_(api => fromPokemonApi(api)->Js.Promise.resolve, _)
}

let rec fetchListApi = (url, dex) => {
  let initResult = fetchApi(url, listApiParseJson)

  initResult->then_((soFar: listApi) => {
    let newNames = soFar.results->Belt.Array.map(rv => rv.name)
    let newDex = Belt.Array.concat(dex, newNames)

    switch Js.Nullable.toOption(soFar.next) {
    | None => Js.Promise.resolve(newDex)
    | Some(more) => fetchListApi(more, newDex)
    }
  }, _)
}

let getThinTypedex = () => {
  fetchListApi(typeListStartUrl, [])
}

export getPokedex: Js.Promise.t<array<string>> = {
  fetchListApi(pokemonListStartUrl, [])
}

let getName = rv => rv.name

let toNames: array<refValue> => array<string> = inpu => inpu->Belt.Array.map(rv => rv.name)

let fromTypeApi: typeApi => Pokemon.pokemonType = ta => {
  name: ta.name,
  noDamageFrom: ta.damage_relations.no_damage_from->toNames,
  halfDamageFrom: ta.damage_relations.half_damage_from->toNames,
  doubleDamageFrom: ta.damage_relations.double_damage_from->toNames,
}

export getTypedex = {
  getThinTypedex()->then_(tt => {
    tt
    ->Belt.Array.map(name => {
      let url = baseUrl ++ typeEndpoint ++ name
      fetchApi(url, typeApiParseJson)
    })
    ->Js.Promise.all
  }, _)->then_(types => types->Belt.Array.map(fromTypeApi)->Js.Promise.resolve, _)
}
