const React = require('react');

const PokemonsIndexItem = React.createClass({
  render() {
    return (
      <li
        onClick={this.showDetail}
        className="poke-list-item"
        key={this.props.key}>
        {this.props.pokemon.name}
      </li>);
  },

  showDetail() {
    hashHistory.push(`/pokemon/${this.props.pokemon.id}`);
  }
});

module.exports = PokemonsIndexItem;
