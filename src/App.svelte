<script lang="typescript">
    import { team } from './components/store';
    import Member from './components/Member.svelte';
    import Effectiveness from "./components/Effectiveness.svelte";

    const selecteds = Array(6).fill("");
</script>

<style></style>

<div id="team">
{#each selecteds as member, i}
    <Member bind:selected={member} index="{i}"/>
{/each}
</div>


<!--<h2>team sofar</h2>-->
<!--<ul>-->
<!--{#each selecteds as member}-->
<!--    <li>{member}</li>-->
<!--{/each}-->
<!--</ul>-->

<Effectiveness team={$team} />
