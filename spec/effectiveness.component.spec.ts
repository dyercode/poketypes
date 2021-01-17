import "mocha";
import { teamEffectiveness } from "../src/components/effectiveness/index";
import { expect } from "chai";
import { Type } from "../src/model/type";
import { Effectiveness } from "../src/model/effectiveness";
import { option } from "fp-ts";

describe("Effectiveness", () => {
  describe("teamEffectiveness", () => {
    describe("given some bad data", () => {
      it("defaults to zero when type not found in dex", () => {
        expect(
          teamEffectiveness(
            new Type("dark"),
            Effectiveness.Immune,
            [option.some({ name: "darkmon", types: ["psychic"], moves: [] , knownMoves: {move1: option.none, move2: option.none, move3: option.none, move4: option.none}})],
            []
          )
        ).to.equal(0);
      });

      it("defaults to zero when nothing goes in", () => {
        expect(teamEffectiveness(null, null, [], null)).to.equal(0);
      });
    });
  });
});
