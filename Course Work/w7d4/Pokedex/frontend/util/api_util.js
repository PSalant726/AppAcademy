module.exports = {
  fetchAllPokemons: function(callback) {
    $.ajax ({
      url: "api/pokemon",
      type: "GET",
      dataType: "json",
      success: function(fetchedPokemons) {
        callback(fetchedPokemons);
      }
    });
  },

  fetchPokemon: function(callback, id) {
    $.ajax ({
      url: `api/pokemon/${id}`,
      type: "GET",
      dataType: "json",
      success: function(fetchedPokemon) {
        callback(fetchedPokemon);
      }
    });
  }

};
