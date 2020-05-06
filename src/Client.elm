module Client exposing (baseUrl, speciesEndpoint, pokemonEndpoint, typeEndpoint)

baseUrl : String
baseUrl  =
    "https://pokeapi.co"

speciesEndpoint : String
speciesEndpoint =
    "/api/v2/pokemon-species/?limit=100"


pokemonEndpoint : String
pokemonEndpoint =
    "/api/v2/pokemon/"

typeEndpoint : String
typeEndpoint = "/type/"