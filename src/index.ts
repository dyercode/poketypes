import "./initialize";
import App from "./App.svelte";
import { getPokemon } from "~PokeApiWrapper.gen";

const app = new App({
  target: document.getElementById("svelte-app"),
  props: {},
});

getPokemon("ditto").then(console.log);
export default app;
