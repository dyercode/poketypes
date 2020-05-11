<script lang="typescript">
    import { almostPokedex } from '../initialize';
    export let name;
    let pokedex= [];
    almostPokedex.then((dex) => {console.log(dex) ; pokedex = dex});
</script>

<style></style>

<input type="text" placeholder="Gotta catch at least one" list="pokedex"/>
<h1>Hello {name}!</h1>
<datalist id="pokedex">
	{#each pokedex as  poke , i}
		<option>{poke}</option>
	{/each}
</datalist>