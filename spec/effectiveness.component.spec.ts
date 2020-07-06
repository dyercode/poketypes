import 'mocha'
import { teamEffectiveness } from "../src/components/effectiveness/index"
import { expect } from 'chai'
import { Type } from '../src/model/type';
import { Effectiveness } from '../src/model/effectiveness';

describe("Effectiveness", () => {
    // export function teamEffectiveness(attackType: Type, testEffective: Effectiveness, inteam: Pokemon[], typedex: Type[]) {
    describe("teamEffectiveness", () => {
        it('zero when type not found in dex', () => {
            expect(teamEffectiveness(new Type("dark"), Effectiveness.Immune, [{name: "darkmon", types: ["psychic"]}], [])).to.equal(0);
        });

        it('defaults to zero when nothing goes in', () => {
            expect(teamEffectiveness(null, null, null, null)).to.equal(0);
        });
    });

});