<script lang="typescript">
    import {almostPokedex} from '../initialize';
    import Member from './Member.svelte';
    import Effectiveness from "./Effectiveness.svelte";
    import {team} from './store.ts';

    export let name;
    let selecteds = Array(6).fill("")
</script>

<style></style>

<div id="team">
{#each selecteds as member, i}
    <Member bind:selected={member} index="{i}"/>
{/each}
</div>


<h2>team sofar</h2>
<ul>
{#each selecteds as member}
    <li>{member}</li>
{/each}
</ul>

<Effectiveness team={$team} />
