import {getPokedex, getTypedex} from './PokeApi';
import {typedex} from "./components/store";

export const almostPokedex = getPokedex([])
getTypedex().then(typedex.set);
