<script lang="ts">
  import Awesomplete from "awesomplete";
  import type { Pokemon } from "../../model/pokemon";
  import { team } from "../store";
  import {
    Option,
    map,
    getOrElse,
    none,
    of,
    flatten,
    some,
  } from "fp-ts/lib/Option";
  import { derived } from "svelte/store";
  import { pipe } from "fp-ts/lib/function";
  import { AwesompleteEvent } from "~typings/AwesomepleteEvent";
  import { beforeUpdate, onMount } from "svelte";

  export let index: number;
  export let moveIndex: number;
  let mymon = derived(team, (mons: Option<Pokemon>[]) => mons[index]);
  let moves = derived(mymon, (mon: Option<Pokemon>) => {
    return pipe(
      mon,
      map((m: Pokemon) => m.moves),
      getOrElse(() => [])
    );
  });

  let selected = "";
  mymon.subscribe((mon: Option<Pokemon>) => {
    selected = pipe(
      mon,
      map((m) => m.knownMoves[`move${moveIndex}`]),
      flatten,
      getOrElse(() => "")
    );
  });

  let moveId = `mon-${index}-move-${moveIndex}`;

  let ap: Option<Awesomplete> = none;
  beforeUpdate(() => {
    pipe(
      ap,
      map((a) => a.close())
    );
  });

  onMount(() => {
    let input = document.getElementById(moveId);
    ap = of(new Awesomplete(input, { list: `#moves-${index}` }));
    moves.subscribe((ms: string[]) => {
      pipe(
        ap,
        map((a) => {
          a.list = ms;
          a.evaluate();
        })
      );
    });
    input.addEventListener("blur", (it) => {
      const text: string = (it.target as HTMLInputElement).value;
      if (!text || !$moves.includes(text)) {
        team.update((current: Option<Pokemon>[]) => {
          let before: Option<Pokemon> = current[index];
          let updated: Option<Pokemon> = pipe(
            before,
            map((mon: Pokemon) => {
              mon.knownMoves[`move${moveIndex}`] = none;
              return mon;
            })
          );
          current[index] = updated;
          return current;
        });
      } else {
        team.update((current: Option<Pokemon>[]) => {
          let before = current[index];
          let updated: Option<Pokemon> = pipe(
            before,
            map((mon: Pokemon) => {
              mon.knownMoves[`move${moveIndex}`] = some(text);
              return mon;
            })
          );
          current[index] = updated;
          return current;
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

<style>
</style>

<label for={moveId}>move {moveIndex}</label><input
  id={moveId}
  placeholder="move {moveIndex}"
  value={selected} />
