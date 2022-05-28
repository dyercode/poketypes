<script lang="ts">
  import type { Pokemon } from "../../model/pokemon";
  import { team } from "../store";
  import { Option, isSome } from "fp-ts/lib/Option";
  import { derived } from "svelte/store";
  import Move from "./Move.svelte";

  export let index: number;
  let mymon = derived(team, (mons: Option<Pokemon>[]) => mons[index]);
  let exists = derived(mymon, isSome);
</script>

<style>
  ol {
    list-style-type: none;
  }
</style>

{#if $exists}
  <ol>
    <li>
      <Move bind:index moveIndex={1} />
    </li>
    <li>
      <Move bind:index moveIndex={2} />
    </li>
    <li>
      <Move bind:index moveIndex={3} />
    </li>
    <li>
      <Move bind:index moveIndex={4} />
    </li>
  </ol>
{/if}
