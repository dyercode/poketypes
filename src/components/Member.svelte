<script lang="typescript">
    // @ts-ignore
    import { Pokemon } from '../model/pokemon.ts';
    import {onMount} from 'svelte';
    import * as Awesomplete from 'awesomplete';
    // @ts-ignore
    import {team, thinPokedex} from './store.ts'
    // @ts-ignore
    import {getPokemon} from '../PokeApi.ts';

    export let selected: string;
    export let index: number;
    class AwesompleteEvent {
        text: {label: string, value: string};
        target: HTMLInputElement;
    }
    onMount(() => {
        let input = document.getElementById(`member-${index}`)
        let ap = new Awesomplete(input, {list: `pokedex-${index}`});
        thinPokedex.subscribe((list: Pokemon[]) => {
            ap.list = list;
            ap.evaluate();
        });
        input.addEventListener('blur', (it) => {
            const text: string = (it.target as HTMLInputElement).value;
            if (!text || !$thinPokedex.includes(text)) {
                team.update((current: Pokemon[]) => {
                    current[index] = null;
                    return current;
                });
            } else {
                getPokemon(text).then((newMon: Pokemon) => {
                    selected = text;
                    team.update((current: Pokemon[]) => {
                        current[index] = newMon;
                        return current;
                    })
                })
            }
        });
        input.addEventListener('awesomplete-selectcomplete', (it: any) => {
            const bit = it as AwesompleteEvent;
            selected = bit.text.value;
            bit.target.blur();
        });
    });
</script>

<style>
    @import '../../node_modules/awesomplete/awesomplete.css';
</style>

<input type="text" id="member-{index}" placeholder="Gotta catch at least one" list="pokedex-{index}"/>
<datalist id="pokedex-{index}">
    {#each $thinPokedex as poke }
        <option>{poke}</option>
    {/each}
</datalist>