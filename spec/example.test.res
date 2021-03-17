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

zora("a single type takes double damage from an attack it takes double damage from", t => {
  t->equal(
    Model.Effectiveness.attackEffectiveness(dark, [psychic]),
    Model.Effectiveness.Double,
    "wasn't double",
  )
  done()
})

zora("a single type takes is immune to attacks it takes no damage from", t => {
  t->equal(
    Model.Effectiveness.attackEffectiveness(psychic, [dark]),
    Model.Effectiveness.Immune,
    "dark wasn't immune to psychic",
  )
  done()
})

zora("a single type takes half damage from attacks it takes half damage from", t => {
  t->equal(
    Model.Effectiveness.attackEffectiveness(psychic, [psychic]),
    Model.Effectiveness.Half,
    "psychic wasn't resistant to psychic",
  )
  done()
})

zora(
  "a single type takes Neutral damage from an attack it has no weaknesses or resistances to",
  t => {
    t->equal(
      Model.Effectiveness.attackEffectiveness(psychic, [ghost]),
      Model.Effectiveness.Neutral,
      "psychic wasn't resistant to psychic",
    )
    done()
  },
)

zora("a dual type is immune if one of it's types is immune", t => {
  t->equal(
    attackEffectiveness(psychic, [psychic, dark]),
    Model.Effectiveness.Immune,
    "psychic into psychic/dark",
  )
  done()
})

zora("a dual type is 4x if both of it's types are weak", t => {
  t->equal(
    attackEffectiveness(dark, [psychic, ghost]),
    Model.Effectiveness.Quadruple,
    "dark into psychic/ghost",
  )
  done()
})

zora("a dual type is quarter if both of it's types are resistant", t => {
  t->equal(
    attackEffectiveness(ghost, [dark, dark]),
    Model.Effectiveness.Quarter,
    "ghost into dark/dark",
  )
  done()
})
