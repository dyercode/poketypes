import { Readable, Writable, derived, get, writable } from "svelte/store";
import { Config } from "./config";
import { Pokemon } from "../model/pokemon";
import { Type } from "../model/type";
import { none, Option } from "fp-ts/lib/Option";

const config: Writable<Config> = writable({
  useUnknown: false,
  useShadow: false,
});
const team: Writable<Option<Pokemon>[]> = writable(Array(6).fill(none));
const typedexRaw: Writable<Type[]> = writable([]);
const typedex: Readable<Type[]> = derived(typedexRaw, (types: Type[]) => {
  const c = get(config);
  return types.filter((t) => {
    return (
      (t.name !== "shadow" || c.useShadow) &&
      (t.name !== "unknown" || c.useUnknown)
    );
  });
});

const thinPokedex: Writable<string[]> = writable([]);

export { config, team, typedexRaw, typedex, thinPokedex };
