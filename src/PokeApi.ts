import  axios, { AxiosResponse }  from 'axios';

const baseUrl = "https://pokeapi.co/api/v2/"
const typeEndpoint = 'type/'
const pokemonEndpoint = 'pokemon/'
const pokemonListStartUrl: string = baseUrl + pokemonEndpoint + '?limit=60';

class Pokemon {
    name: string;
    types: string[];
}

class RefValue {
    name: string;
    url : string;
}

class PokemonApi {
    name: string;
    types: RefValue[]
}

class PokemonListApi {
    name: string;
    next?: string;
    results: RefValue[];
}

class Type {}

export function fetchPokedex (dex: string[], url: string = pokemonListStartUrl) : Promise<string[]>  {
    let initResult: Promise<AxiosResponse<PokemonListApi>> = axios.get(url);
    return initResult.then((soFar: AxiosResponse<PokemonListApi> ) => {
        let newNames = [] 
        if (soFar.data.results) {
            newNames = soFar.data.results.map(rv => rv.name)
        }
        let newDex = dex.concat(newNames);
        if (soFar.data.next !== null) {
            return fetchPokedex(newDex, soFar.data.next);
        } else {
            return newDex;
        }
    });
}