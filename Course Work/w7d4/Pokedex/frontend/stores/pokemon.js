const Store = require("flux/utils").Store;
const Dispatcher = require('../dispatcher/dispatcher.js');
const PokemonStore = new Store(Dispatcher);
const PokemonConstants = require('../constants/pokemon_constants.js');

let _pokemons = {};

PokemonStore.resetPokemons = function(pokemons){
  _pokemons = {};
  pokemons.forEach(function(pokemon){
    _pokemons[pokemon.id] = pokemon;
  });
};

PokemonStore.all = function() {
  let pokemons = [];
  Object.keys(_pokemons).forEach((key) => {
    pokemons.push(_pokemons[key]);
  });

  return pokemons;
};

PokemonStore.showDetails = function(pokemon) {
  
};

PokemonStore.__onDispatch = function(payload) {
  switch (payload.actionType) {
    case PokemonConstants.POKEMONS_RECEIVED:
      this.resetPokemons(payload.pokemons);
      this.__emitChange();
      break;
    case PokemonConstants.POKEMON_RECEIVED:
      this.showDetails(payload.pokemon);
      this.__emitChange();
      break;
  }
};

PokemonStore.find = function(id){
  return _pokemons[id];
};

module.exports = PokemonStore;
