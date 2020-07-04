import { writable, Writable, derived, get } from 'svelte/store';
import {Config} from "./config";
import {Pokemon} from '../model/pokemon';
import {Type} from '../model/type';

export const config: Writable<Config> = writable({useUnknown: false, useShadow: false});
export const team: Pokemon[] = writable(Array(6).fill(null))
export const typedexRaw: any[] = writable([])
export const typedex = derived(typedexRaw, (types: Type[]) => {
    const c = get(config)
    return types.filter(t => {
        return (t.name !== 'shadow' || c.useShadow) && (t.name !== 'unknown' || c.useUnknown);
    });
});

export const thinPokedex: Writable<any[]> = writable([])
