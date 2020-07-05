<script lang="typescript">
    // @ts-ignore
    import { team } from './components/store.ts';
    import Member from './components/Member.svelte';
    import Effectiveness from "./components/Effectiveness.svelte";

    const selecteds: string[] = Array(6).fill("");
</script>

<style></style>

<div id="team">
{#each selecteds as member, i}
    <Member bind:selected={member} index="{i}"/>
{/each}
</div>

<Effectiveness team={$team} />
