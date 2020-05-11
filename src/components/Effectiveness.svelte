<script>
    import {typedex} from './store.ts'
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
            <td>0</td>
            <td>0</td>
            <td>0</td>
            <td>0</td>
            <td>0</td>
            <td>0</td>
        </tr>
    {/each}
    </tbody>
</table>