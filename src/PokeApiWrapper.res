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
  next: option<string>,
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

export getPokemon = name =>
  Fetch.fetch(baseUrl ++ pokemonEndpoint ++ name)
  ->Js.Promise.then_(Fetch.Response.text, _)
  ->Js.Promise.then_(text => pokemonApiParseJson(text)->Js.Promise.resolve, _)
  ->Js.Promise.then_(api => fromPokemonApi(api)->Js.Promise.resolve, _)

let rec getThinTypedex = (~url=typeListStartUrl, ~dex=[], ()): Js.Promise.t<array<string>> => {
  let initResult =
    Fetch.fetch(url)
    ->Js.Promise.then_(Fetch.Response.text, _)
    ->Js.Promise.then_(text => listApiParseJson(text)->Js.Promise.resolve, _)

  initResult->Js.Promise.then_((soFar: listApi) => {
    let newNames = soFar.results->Belt.Array.map(rv => rv.name)
    let newDex = Belt.Array.concat(dex, newNames)
    switch soFar.next {
    | Some(s) => getThinTypedex(~dex=newDex, ~url=s, ())
    | None => Js.Promise.resolve(newDex)
    }
  }, _)
}

let getName = rv => rv.name

let toNames: array<refValue> => array<string> = inpu => inpu->Belt.Array.map(rv => rv.name)

let fromTypeApi: typeApi => Pokemon.pokemonType = ta => {
  name: ta.name,
  noDamageFrom: ta.damage_relations.no_damage_from->toNames,
  halfDamageFrom: ta.damage_relations.half_damage_from->toNames,
  doubleDamageFrom: ta.damage_relations.double_damage_from->toNames,
}

let getTypedex = {
  let then_ = Js.Promise.then_
  getThinTypedex()->then_(tt => {
    let fullTypes =
      tt->Belt.Array.map(name =>
        Fetch.fetch(baseUrl ++ typeEndpoint ++ name)
        ->then_(Fetch.Response.text, _)
        ->then_(fts => typeApiParseJson(fts)->Js.Promise.resolve, _)
      )
    Js.Promise.all(fullTypes)
  }, _)->then_(types => types->Belt.Array.map(fromTypeApi)->Js.Promise.resolve, _)
}

let rec getPokedex = (~url=pokemonListStartUrl, ~dex=[], ()): Js.Promise.t<array<string>> => {
  let initResult =
    Fetch.fetch(url)
    ->Js.Promise.then_(Fetch.Response.text, _)
    ->Js.Promise.then_(text => listApiParseJson(text)->Js.Promise.resolve, _)

  initResult->Js.Promise.then_((soFar: listApi) => {
    let newNames = soFar.results->Belt.Array.map(rv => rv.name)
    let newDex = Belt.Array.concat(dex, newNames)
    switch soFar.next {
    | Some(s) => getPokedex(~dex=newDex, ~url=s, ())
    | None => Js.Promise.resolve(newDex)
    }
  }, _)
}
