const Dispatcher = require('../dispatcher/dispatcher.js');
const PokemonConstants = require('../constants/pokemon_constants.js');
const ApiUtil = require('../util/api_util.js');

const PokemonActions = {
  receiveAllPokemons: function(pokemons){
    Dispatcher.dispatch({
      actionType: PokemonConstants.POKEMONS_RECEIVED,
      pokemons: pokemons
    });
  },

  fetchAllPokemons: function(){
    ApiUtil.fetchAllPokemons(PokemonActions.receiveAllPokemons);
  },

  receiveSinglePokemon: function(pokemon) {
    Dispatcher.dispatch({
      actionType: PokemonConstants.POKEMON_RECEIVED,
      pokemon: pokemon
    });
  },

  fetchPokemon: function(id) {
    ApiUtil.fetchPokemon(PokemonActions.receiveSinglePokemon, id);
  }
};

module.exports = PokemonActions;
