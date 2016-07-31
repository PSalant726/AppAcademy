const React = require('react');
const PokemonStore = require('../../stores/pokemon.js');
const PokemonActions = require('../../actions/pokemon_actions.js');

const PokemonDetail = React.createClass({
  getInitialState(){
    return({
      pokemon: null
    });
  },

  componentWillReceiveProps() {
    PokemonActions.fetchPokemon(this.props.params.pokemonId);
  },

  getStateFromStore(){
    let pokemon = PokemonStore.find(parseInt(this.props.params.pokemonId));
    return pokemon;
  },

  componentDidMount() {
    this.listener = PokemonStore.addListener(this.onChange);
    PokemonActions.fetchPokemon(this.props.params.pokemonId);
  },

  onChange() {
    this.setState({pokemon: this.getStateFromStore()});
  },

  render(){
    let details;
    if (this.state.pokemon){
      details = <div>
          {this.state.pokemon.name}
          <img src={this.state.pokemon.image_url}/>
        </div>;
    } else {
      details = <div></div>;
    }

    return (
      <div>
        <div className="pokemon-detail-pane">
          <div className="detail">
            {details}
          </div>
        </div>
      </div>
    );
  }
});

module.exports = PokemonDetail;
