import { Pokemon } from './../../model/pokemon';
import { Effectiveness, attackEffectiveness } from "../../model/effectiveness";
import { Type } from "../../model/type";

function sum(a: number, b: number) { return a + b; }

const findTypeByName = (typedex: Type[]) => (name: string) => typedex.find((type: Type) => type.name == name)

export function teamEffectiveness(attackType: Type, testEffective: Effectiveness, inteam: Pokemon[], typedex: Type[]): number {
    if (inteam) {
        const typeLookup = findTypeByName(typedex);
        const lookupTypes = (mon: Pokemon): Type[] => mon.types.map(typeLookup).filter(x => x != null);

        return inteam
            .filter((i: Pokemon) => i !== null && i !== undefined)
            .map((member: Pokemon) => {
                const memberTypes: Type[] = lookupTypes(member);
                if (attackEffectiveness(attackType, memberTypes) === testEffective) {
                    return 1;
                } else {
                    return 0;
                }
            })
            .reduce(sum, 0)
    } else return 0
}