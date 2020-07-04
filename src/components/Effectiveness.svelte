<script lang="typescript">
    import {typedex} from './store';
    import {Type} from '../model/type';
    import {Pokemon} from '../model/pokemon';
    import {Effectiveness, attackEffectiveness} from '../model/effectiveness';

    const {Half, Double, Immune, Neutral, Quadrouple, Quarter} = Effectiveness;

    export let team: Pokemon[];

    function teamEffectiveness(attackType: Type, testEffective: Effectiveness, inteam: Pokemon[]) {
        if (inteam) {
            return inteam
                    .filter((i: Pokemon) => i !== null && i !== undefined)
                    .map(member => {
                        const memberTypes = member.types.map((name: string) => $typedex.find(type => type.name == name))
                        if (member) {
                            if (attackEffectiveness(attackType, memberTypes) === testEffective) {
                                return 1;
                            } else {
                                return 0;
                            }
                        }
                    })
                    .reduce((acc, val) => acc + val, 0)
        }
    }
</script>

<table>
    <thead>
    <tr>
        <th></th>
        <th>0</th>
        <th>1/4</th>
        <th>1/2</th>
        <th>Neutral</th>
        <th>2x</th>
        <th>4x</th>
    </tr>
    </thead>
    <tbody>
    {#each $typedex as type}
        <tr>
            <th>{type.name}</th>
            <td>{teamEffectiveness(type, Immune, team)}</td>
            <td>{teamEffectiveness(type, Quarter, team)}</td>
            <td>{teamEffectiveness(type, Half, team)}</td>
            <td>{teamEffectiveness(type, Neutral, team)}</td>
            <td>{teamEffectiveness(type, Double, team)}</td>
            <td>{teamEffectiveness(type, Quadrouple, team)}</td>
        </tr>
    {/each}
    </tbody>
</table>