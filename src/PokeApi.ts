import  axios, { AxiosResponse }  from 'axios';

const baseUrl = 'https://pokeapi.co/api/v2/'
const typeEndpoint = 'type/'
const pokemonEndpoint = 'pokemon/'
const pokemonListStartUrl: string = baseUrl + pokemonEndpoint + '?limit=60';
const typeListStartUrl: string = baseUrl + typeEndpoint + '?limit=60';

class Pokemon {
    name: string;
    types: string[];
}

class RefValue {
    name: string;
    url: string;
}

class ListApi {
    name: string;
    next?: string;
    results: RefValue[];
}

export function getPokedex (dex: string[], url: string = pokemonListStartUrl): Promise<string[]>  {
    const initResult: Promise<AxiosResponse<ListApi>> = axios.get(url);
    return initResult.then((soFar: AxiosResponse<ListApi> ) => {
        let newNames = [];
        if (soFar.data.results) {
            newNames = soFar.data.results.map(rv => rv.name)
        }
        const newDex = dex.concat(newNames);
        if (soFar.data.next !== null) {
            return getPokedex(newDex, soFar.data.next);
        } else {
            return newDex;
        }
    });
}

export function getTypedex (dex: string[], url: string = typeListStartUrl): Promise<string[]>  {
    const initResult: Promise<AxiosResponse<ListApi>> = axios.get(url);
    return initResult.then((soFar: AxiosResponse<ListApi> ) => {
        let newNames = [] 
        if (soFar.data.results) {
            newNames = soFar.data.results.map(rv => rv.name)
        }
        const newDex = dex.concat(newNames);
        if (soFar.data.next !== null) {
            return getTypedex(newDex, soFar.data.next);
        } else {
            return newDex;
        }
    });
}
