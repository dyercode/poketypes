import { writable } from 'svelte/store';

export let team = writable(Array(6).fill(null))
export let typedex = writable([])
