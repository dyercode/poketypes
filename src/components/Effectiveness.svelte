<script>
    import {typedex, team} from './store.ts'
    import {Effectiveness, attackEffectiveness} from '../model/effectiveness.ts'
    const {Half, Double, Immune, Neutral, Quadrouple, Quarter} = Effectiveness;

    function teamEffectiveness(attackType, testEffective)  {
        return $team
            .filter(i => i !== null)
            .map(member => {
                if (member) {
                    if (attackEffectiveness(attackType, member.types) === testEffective) {
                        return 1;
                    } else {
                        return 0;
                    }
                }
            })
            .reduce((acc, val) => acc + val, 0)
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
            <td>{teamEffectiveness(type, Immune)}</td>
            <td>{teamEffectiveness(type, Quarter)}</td>
            <td>{teamEffectiveness(type, Half)}</td>
            <td>{teamEffectiveness(type, Neutral)}</td>
            <td>{teamEffectiveness(type, Double)}</td>
            <td>{teamEffectiveness(type, Quadrouple)}</td>
        </tr>
    {/each}
    </tbody>
</table>