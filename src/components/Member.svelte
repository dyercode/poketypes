<script>
    import {onMount} from 'svelte';
    import '../../node_modules/awesomplete/awesomplete.js'
    import {team, thinPokedex} from './store.ts'
    import {getPokemon} from '../PokeApi.ts';

    export let selected;
    export let index;
    onMount(() => {
        let input = document.getElementById(`member-${index}`)
        let ap = new Awesomplete(input, {list: `pokedex-${index}`});
        thinPokedex.subscribe((list) => {
            ap.list = list;
            ap.evaluate();
        });
        input.addEventListener('blur', (it) => {
            const text = it.target.value;
            if (!text || !$thinPokedex.includes(text)) {
                team.update(current => {
                    current[index] = null;
                    return current;
                });
            } else {
                getPokemon(text).then(newMon => {
                    selected = text;
                    team.update(current => {
                        current[index] = newMon;
                        return current;
                    })
                })
            }
        });
        input.addEventListener('awesomplete-selectcomplete', (it) => {
            selected = it.text.value;
            it.target.blur();
        });
    });
</script>

<style>
    @import '../../node_modules/awesomplete/awesomplete.css';
</style>

<input type="text" id="member-{index}" placeholder="Gotta catch at least one" list="pokedex-{index}"/>
<datalist id="pokedex-{index}">
    {#each $thinPokedex as  poke , i}
        <option>{poke}</option>
    {/each}
</datalist>