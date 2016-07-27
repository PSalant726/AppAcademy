const TodoList = require('./components/todo_list.jsx');
const React = require('react');
const ReactDOM = require('react-dom');

document.addEventListener("DOMContentLoaded", function(){
  ReactDOM.render(<TodoList/>, document.getElementById('root'));
});
