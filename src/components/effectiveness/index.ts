import { Pokemon } from "./../../model/pokemon";
import { attackEffectiveness, Effectiveness } from "../../model/effectiveness";
import { Type } from "../../model/type";
import { Option } from "fp-ts/lib/Option";
import { array } from "fp-ts";

function sum(a: number, b: number) {
  return a + b;
}

const findTypeByName = (typedex: Type[]) => (name: string) =>
  typedex.find((type: Type) => type.name == name);

export function teamEffectiveness(
  attackType: Type,
  testEffective: Effectiveness,
  inTeam: Array<Option<Pokemon>>,
  typedex: Type[]
): number {
  const typeLookup = findTypeByName(typedex);
  const lookupTypes = (mon: Pokemon): Type[] =>
    mon.types.map(typeLookup).filter((x) => x != null);

  return array
    .compact(inTeam)
    .map((member: Pokemon) => {
      const memberTypes: Type[] = lookupTypes(member);
      if (attackEffectiveness(attackType, memberTypes) === testEffective) {
        return 1;
      } else {
        return 0;
      }
    })
    .reduce(sum, 0);
}
