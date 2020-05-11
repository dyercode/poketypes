<script lang="typescript">
    import { almostPokedex } from '../initialize';
    export let name;
    let pokedex= [];
    almostPokedex.then((dex) => {console.log(dex) ; pokedex = dex});
</script>

<style></style>

<input type="text" placeholder="Gotta catch at least one"/>
<h1>Hello {name}!</h1>
<ul>
	{#each pokedex as { name }, i}
		<li>(#{i}): {name} </li>
	{/each}
</ul>