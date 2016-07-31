const React = require('react');
const ReactDOM = require('react-dom');
const Search = require('./components/search.jsx');

document.addEventListener("DOMContentLoaded", function(){
  ReactDOM.render(<Search />, document.getElementById('content'));
});
