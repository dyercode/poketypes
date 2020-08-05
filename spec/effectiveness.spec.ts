import 'mocha'
import {expect} from 'chai'
import {Type} from "../src/model/type";
import {attackEffectiveness, Effectiveness} from "../src/model/effectiveness";

const psychicName = 'psychic'
const ghostName = 'ghost';
const darkName = 'dark';

const psychic: Type = {
    name: psychicName,
    noDamageFrom: [],
    halfDamageFrom: [psychicName],
    doubleDamageFrom: [darkName, ghostName]
} as Type

const dark: Type = {
    name: darkName,
    noDamageFrom: [psychicName],
    halfDamageFrom: [ghostName],
    doubleDamageFrom: []
} as Type;

const ghost: Type = {
    name: ghostName,
    noDamageFrom: [],
    halfDamageFrom: [],
    doubleDamageFrom: [darkName]
} as Type;

describe('effectiveness', () => {
    describe('for a single type', () => {
        it("takes double damage from an attack it takes double damage from", () => {
            expect(attackEffectiveness(dark, [psychic])).to.equal(Effectiveness.Double)
        });
        it("takes is immune to attacks it takes no damage from", () => {
            expect(attackEffectiveness(psychic, [dark])).to.equal(Effectiveness.Immune)
        });
        it("takes half damage from attacks it takes half damage from", () => {
            expect(attackEffectiveness(psychic, [psychic])).to.equal(Effectiveness.Half)
        });
        it("takes Neutral damage from an attack it has no weaknesses or resistances to", () => {
            expect(attackEffectiveness(psychic, [ghost])).to.equal(Effectiveness.Neutral)
        });
    });

    describe('for a dual type', () => {
        it("is immune if one of it's types is immune", () => {
            expect(attackEffectiveness(psychic, [psychic, dark])).to.equal(Effectiveness.Immune)
        });
        it("is 4x if both of it's types are weak", () => {
            expect(attackEffectiveness(dark, [psychic, ghost])).to.equal(Effectiveness.Quadrouple)
        });
        it("is quarter if both of it's types are resistant", () => {
            expect(attackEffectiveness(ghost, [dark, dark])).to.equal(Effectiveness.Quarter)
        });
    });
});