import {getPokedex, getTypedex} from './PokeApi';
import {typedex, thinPokedex} from "./components/store";

getPokedex().then(thinPokedex.set);
getTypedex().then(typedex.set);
