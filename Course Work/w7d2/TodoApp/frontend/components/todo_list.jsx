const React = require('react');
const TodoStore = require('../stores/todo_store.js');
const TodoListItem = require('./todo_list_item.jsx');
const TodoForm = require('./todo_form.jsx');

const TodoList = React.createClass({
  getInitialState(){
    return ({todos: {}});
  },

  componentDidMount(){
    TodoStore.addChangedHandler(this.todosChanged);
    TodoStore.fetch();
  },

  componentWillUnmount(){
    TodoStore.removeChangedHandler(this.todosChanged);
  },

  todosChanged(){
    this.setState({todos: TodoStore.all()});
  },

  render(){
    let allTodos = Object.keys(this.state.todos);
    let titlesArray = allTodos.map((key, i) => {
      return (
        <TodoListItem todoList={this.state.todos[key]} key={i}/>
      );
    });
    return (
      <div>
        {titlesArray}
        <TodoForm />
      </div>
    );
  }
});


module.exports = TodoList;
