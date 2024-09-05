open Zora
open Model.Effectiveness

let psychicName = "psychic"
let ghostName = "ghost"
let darkName = "dark"

let psychic: Model.Pokemon.pokemonType = {
  name: psychicName,
  noDamageFrom: [],
  halfDamageFrom: [psychicName],
  doubleDamageFrom: [darkName, ghostName],
}

let dark: Model.Pokemon.pokemonType = {
  name: darkName,
  noDamageFrom: [psychicName],
  halfDamageFrom: [ghostName],
  doubleDamageFrom: [],
}

let ghost: Model.Pokemon.pokemonType = {
  name: ghostName,
  noDamageFrom: [],
  halfDamageFrom: [],
  doubleDamageFrom: [darkName],
}

zora("a single type takes double damage from an attack it takes double damage from", async t => {
  t->equal(
    Model.Effectiveness.attackEffectiveness(dark, [psychic]),
    Model.Effectiveness.Double,
    ~msg="wasn't double",
  )
})

zora("a single type takes is immune to attacks it takes no damage from", async t => {
  t->equal(
    Model.Effectiveness.attackEffectiveness(psychic, [dark]),
    Model.Effectiveness.Immune,
    ~msg="dark wasn't immune to psychic",
  )
})

zora("a single type takes half damage from attacks it takes half damage from", async t => {
  t->equal(
    Model.Effectiveness.attackEffectiveness(psychic, [psychic]),
    Model.Effectiveness.Half,
    ~msg="psychic wasn't resistant to psychic",
  )
})

zora(
  "a single type takes Neutral damage from an attack it has no weaknesses or resistances to",
  async t => {
    t->equal(
      Model.Effectiveness.attackEffectiveness(psychic, [ghost]),
      Model.Effectiveness.Neutral,
      ~msg="psychic wasn't resistant to psychic",
    )
  },
)

zora("a dual type is immune if one of it's types is immune", async t => {
  t->equal(
    attackEffectiveness(psychic, [psychic, dark]),
    Model.Effectiveness.Immune,
    ~msg="psychic into psychic/dark",
  )
})

zora("a dual type is 4x if both of it's types are weak", async t => {
  t->equal(
    attackEffectiveness(dark, [psychic, ghost]),
    Model.Effectiveness.Quadruple,
    ~msg="dark into psychic/ghost",
  )
})

zora("a dual type is quarter if both of it's types are resistant", async t => {
  t->equal(
    attackEffectiveness(ghost, [dark, dark]),
    Model.Effectiveness.Quarter,
    ~msg="ghost into dark/dark",
  )
})
