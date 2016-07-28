const React = require('react');
const ReactDOM = require('react-dom');
const Organ = require('./components/organ.jsx');
const KeyListeners = require('./util/add_key_listeners.js');

document.addEventListener("DOMContentLoaded", function(){
  ReactDOM.render(<Organ />, document.getElementById('content'));
  KeyListeners();
});
