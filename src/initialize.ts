import {getPokedex, getTypedex} from './PokeApi';
import {thinPokedex, typedexRaw} from "./components/store";

getPokedex().then(thinPokedex.set);
getTypedex().then(typedexRaw.set);
