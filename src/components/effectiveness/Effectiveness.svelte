<script lang="typescript">
    // @ts-ignore
    import {typedex} from '../store.ts';
    // @ts-ignore
    import {Pokemon} from '../../model/pokemon.ts';
    // @ts-ignore
    import {Effectiveness} from '../../model/effectiveness.ts';
    // @ts-ignore
    import { teamEffectiveness } from './index.ts'

    const {Half, Double, Immune, Neutral, Quadrouple, Quarter} = Effectiveness;

    export let team: Pokemon[];

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
            <td>{teamEffectiveness(type, Immune, team, typedex)}</td>
            <td>{teamEffectiveness(type, Quarter, team, typedex)}</td>
            <td>{teamEffectiveness(type, Half, team, typedex)}</td>
            <td>{teamEffectiveness(type, Neutral, team, typedex)}</td>
            <td>{teamEffectiveness(type, Double, team, typedex)}</td>
            <td>{teamEffectiveness(type, Quadrouple, team, typedex)}</td>
        </tr>
    {/each}
    </tbody>
</table>