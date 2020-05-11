<script lang="typescript">
    import {almostPokedex} from '../initialize';
    import Member from './Member.svelte';
    import Effectiveness from "./Effectiveness.svelte";

    export let name;
    let pokedex = [];
    almostPokedex.then((dex) => {
        console.log(dex);
        pokedex = dex
    });
    let selecteds = Array(6).fill("")
</script>

<style></style>

<div id="team">
{#each selecteds as member}
    <Member pokedex="{pokedex}" bind:selected={member}/>
{/each}
</div>


<h2>team sofar</h2>
<ul>
{#each selecteds as member}
    <li>{member}</li>
{/each}
</ul>

<Effectiveness/>
