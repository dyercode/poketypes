import { Option } from "fp-ts/lib/Option";

export class Pokemon {
  name: string;
  types: string[];
  moves: string[];
  knownMoves: KnownMoves;
}

export class KnownMoves {
  move1: Option<string>;
  move2: Option<string>;
  move3: Option<string>;
  move4: Option<string>;
}
