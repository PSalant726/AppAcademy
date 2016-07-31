const PokemonStore = require('../../stores/pokemon.js');
const React = require('react');
const PokemonActions = require('../../actions/pokemon_actions.js');
const PokemonsIndexItem = require('./pokemons_index_item.jsx');

const PokemonsIndex = React.createClass({

  getInitialState() {
    return ({
      pokemons: []
    });
  },

  componentDidMount() {
    this.listener = PokemonStore.addListener(this.handleReceive);
    PokemonActions.fetchAllPokemons();
  },

  handleReceive() {
    this.setState({ pokemons: PokemonStore.all() });
  },

  componentWillUnmount() {
    this.listener.remove();
  },

  render(){
    let pokemonsList = this.state.pokemons.map((pokemon, i) => {
      return (<PokemonsIndexItem pokemon={pokemon} key={i}/>);
    });

    return(
      <ul>
        {pokemonsList}
      </ul>
    );
  }

});

module.exports = PokemonsIndex;
