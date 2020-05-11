<script>
	export let pokedex;
	export let selected;
</script>

<input type="text" placeholder="Gotta catch at least one" list="pokedex" bind:value={selected}/>
<datalist id="pokedex">
	{#each pokedex as  poke , i}
		<option>{poke}</option>
	{/each}
</datalist>