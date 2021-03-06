import { Type } from "./type";

export enum Effectiveness {
    Immune = 1,
    Quarter,
    Half,
    Neutral,
    Double,
    Quadrouple
}

const { Half, Double, Immune, Neutral, Quadrouple, Quarter } = Effectiveness;

const singleTypeEffectiveness = (attack: Type) => (defenseType: Type): Effectiveness => {
    const doubles: Effectiveness[] =
        defenseType.doubleDamageFrom.flatMap((effectiveName) => {
            return (effectiveName === attack.name) ? [Double] : [];
        });

    const half: Effectiveness[] =
        defenseType.halfDamageFrom.flatMap((effectiveName) => {
            return (effectiveName === attack.name) ? [Half] : [];
        });

    const immune: Effectiveness[] =
        defenseType.noDamageFrom.flatMap((effectiveName) => {
            return (effectiveName === attack.name) ? [Immune] : [];
        });

    return [doubles, half, immune].flat()[0] || Neutral;
}

function lookup(types: Effectiveness[]): Effectiveness {
    const sorted = types.slice().sort();
    if (sorted.length == 1) {
        return sorted[0];
    } else if (sorted.includes(Immune)) {
        return Immune;
    } else if (sorted.every(val => val === Half)) {
        return Quarter;
    } else if (sorted === [Half, Neutral]) {
        return Half;
    } else if (sorted === [Half, Double]) {
        return Neutral;
    } else if (sorted === [Neutral, Neutral]) {
        return Neutral;
    } else if (sorted === [Neutral, Double]) {
        return Double;
    } else if (sorted.every((val) => val === Double)) {
        return Quadrouple;
    } else {
        return Neutral;
    }
}

export function attackEffectiveness(attack: Type, defenseTypes: Type[]): Effectiveness {
    const individualEffectivenesses: Effectiveness[] = defenseTypes.map(singleTypeEffectiveness(attack))
    return lookup(individualEffectivenesses);
}
