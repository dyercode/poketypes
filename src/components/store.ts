import { writable } from 'svelte/store';

export const team = writable(Array(6).fill(null))
export const typedex = writable([])
