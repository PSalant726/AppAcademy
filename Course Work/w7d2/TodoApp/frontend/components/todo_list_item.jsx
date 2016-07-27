const React = require('react');
const TodoStore = require('../stores/todo_store.js');
const DoneButton = require('./done_button.jsx');
const TodoDetailView = require('./todo_detail_view.jsx');

var TodoListItem = React.createClass({
  getInitialState(){
    return ({ hidden: true });
  },

  componentWillReceiveProps(){
    this.setState({ hidden: true });
  },

  handleClick(event){
    event.preventDefault();
    let futurehiddenState = this.state.hidden === true ? false : true;
    this.setState({ hidden: futurehiddenState });
  },

  handleDestroy(event){
    event.preventDefault();
    TodoStore.destroy(this.props.todoList.id);
  },

  render(){
    let hiddenStuff = "";
    if (!this.state.hidden) {

      hiddenStuff = <TodoDetailView destroyAction={this.handleDestroy}
        todoList={this.props.todoList}/>;
    }

    return(
      <div>
        <div>
          <div onClick={this.handleClick}>{this.props.todoList.title}</div>
          <DoneButton todoList={this.props.todoList}/>
        </div>
        <div>
          {hiddenStuff}
        </div>
      </div>
    );
  }


});




module.exports = TodoListItem;
