<script lang="ts">
  import "../../node_modules/awesomplete/awesomplete.css";
  import Awesomplete from "awesomplete";
  import type { Pokemon } from "../model/pokemon";
  import { onMount } from "svelte";
  import { team, thinPokedex } from "./store";
  import { getPokemon } from "../PokeApi";
  import { Option, some, none } from "fp-ts/lib/Option";
  import Moves from "./moves/Moves.svelte";
  import { AwesompleteEvent } from "~typings/AwesomepleteEvent";

  export let selected: string;
  export let index: number;
  onMount(() => {
    let input = document.getElementById(`member-${index}`);
    let ap: Awesomplete = new Awesomplete(input, { list: `#pokedex-${index}` });
    thinPokedex.subscribe((list: string[]) => {
      ap.list = list;
      ap.evaluate();
    });
    input.addEventListener("blur", (it) => {
      const text: string = (it.target as HTMLInputElement).value;
      if (!text || !$thinPokedex.includes(text)) {
        team.update((current: Option<Pokemon>[]) => {
          current[index] = none;
          return current;
        });
      } else {
        getPokemon(text).then((newMon: Pokemon) => {
          selected = text;
          team.update((current: Option<Pokemon>[]) => {
            current[index] = some(newMon);
            return current;
          });
        });
      }
    });
    input.addEventListener("awesomplete-selectcomplete", (it: any) => {
      const bit = it as AwesompleteEvent;
      selected = bit.text.value;
      bit.target.blur();
    });
  });
</script>

<div class="member">
  <input
    type="text"
    id="member-{index}"
    placeholder="Gotta catch at least one"
    list="pokedex-{index}" />

  <Moves bind:index />
</div>
