const React = require('react');
const ReactDOM = require('react-dom');
const PokemonsIndex = require('./components/pokemons/pokemons_index.jsx');
const PokemonDetail = require('./components/pokemons/pokemon_detail.jsx');
const App = require('./components/app.jsx');
import { Router, Route, hashHistory, IndexRoute } from 'react-router';

window.hashHistory = hashHistory;

const routes = (
  <Route path="/" component={App}>
    <Route path="pokemon/:pokemonId" component={PokemonDetail}></Route>
  </Route>
);

const router = (
  <Router history={hashHistory}>
    {routes}
  </Router>
);

document.addEventListener("DOMContentLoaded", function () {
  let root = document.querySelector('#root');
  ReactDOM.render(router, root);
});
