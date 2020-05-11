<script>
    let types = []
</script>

<table>
<thead>
    <th></th>
    <th>0</th>
    <th>1/4</th>
    <th>1/2</th>
    <th>Neutral</th>
    <th>2x</th>
    <th>4x</th>
</thead>
<tbody>
{#each types as type}
<tr>
    <td>{type.name}</td>
</tr>
{/each}
</tbody>
</table>