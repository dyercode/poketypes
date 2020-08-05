import {registerRoute} from "workbox-routing";
import {CacheFirst} from "workbox-strategies";

registerRoute(({url}) => url.origin === 'https://pokeapi.co',
    new CacheFirst({
        cacheName: 'pokeapi-cache'
    })
);