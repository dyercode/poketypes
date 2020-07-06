import { Readable, Writable, derived, get, writable } from 'svelte/store';
import {Config} from "./config";
import {Pokemon} from '../model/pokemon';
import {Type} from '../model/type';

const config: Writable<Config> = writable({useUnknown: false, useShadow: false});
const team: Writable<Pokemon[]> = writable(Array(6).fill(null))
const typedexRaw: Writable<Type[]> = writable([])
const typedex: Readable<Type[]> = derived(typedexRaw, (types: Type[]) => {
    const c = get(config)
    return types.filter(t => {
        return (t.name !== 'shadow' || c.useShadow) && (t.name !== 'unknown' || c.useUnknown);
    });
});

const thinPokedex: Writable<Pokemon[]> = writable([])

export {config, team, typedexRaw, typedex, thinPokedex}
