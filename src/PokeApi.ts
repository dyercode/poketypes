import axios, {AxiosResponse} from 'axios';
import {Type} from "./model/type";

const baseUrl = 'https://pokeapi.co/api/v2/'
const typeEndpoint = 'type/'
const pokemonEndpoint = 'pokemon/'
const pokemonListStartUrl: string = baseUrl + pokemonEndpoint + '?limit=60';
const typeListStartUrl: string = baseUrl + typeEndpoint + '?limit=60';

class RefValue {
    name: string;
    url: string;
}

class ListApi {
    name: string;
    next?: string;
    results: RefValue[];
}


function fromTypeApi(ta: TypeApi): Type {
    return {
        name: ta.name
        , noDamageFrom: ta.damage_relations.no_damage_from.map(d => d.name)
        , halfDamageFrom: ta.damage_relations.half_damage_from.map(d => d.name)
        , doubleDamageFrom: ta.damage_relations.double_damage_from.map(d => d.name)
    } as Type;
}

class DamageRelationsApi {
    no_damage_from: RefValue[]
    half_damage_from: RefValue[]
    double_damage_from: RefValue[]
}

class TypeApi {
    name: string;
    damage_relations: DamageRelationsApi;

}

export function getPokedex(dex: string[] = [], url: string = pokemonListStartUrl): Promise<string[]> {
    const initResult: Promise<AxiosResponse<ListApi>> = axios.get(url);
    return initResult.then((soFar: AxiosResponse<ListApi>) => {
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

function getThinTypedex(dex: string[] = [], url: string = typeListStartUrl): Promise<string[]> {
    const initResult: Promise<AxiosResponse<ListApi>> = axios.get(url);
    return initResult.then((soFar: AxiosResponse<ListApi>) => {
        let newNames = []
        if (soFar.data.results) {
            newNames = soFar.data.results.map(rv => rv.name)
        }
        const newDex = dex.concat(newNames);
        if (soFar.data.next !== null) {
            return getThinTypedex(newDex, soFar.data.next);
        } else {
            return newDex;
        }
    });
}

export function getTypedex(): Promise<Type[]> {
    return getThinTypedex()
        .then((names: string[]) => {
            const fullTypes: Promise<TypeApi>[] = names.map(name => {
                return axios.get(baseUrl + typeEndpoint + name)
                    .then(r => r.data);
            });
            return Promise.all(fullTypes);
        })
        .then((apiData: TypeApi[]) => {
            return apiData.map(fromTypeApi)
        });

