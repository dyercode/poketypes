module Client exposing (baseUrl, pokemonEndpoint, speciesEndpoint, typeEndpoint)


baseUrl : String
baseUrl =
    "https://pokeapi.co/api/v2"


speciesEndpoint : String
speciesEndpoint =
    "/pokemon-species/?limit=100"


pokemonEndpoint : String
pokemonEndpoint =
    "/pokemon/"


typeEndpoint : String
typeEndpoint =
    "/type/"
