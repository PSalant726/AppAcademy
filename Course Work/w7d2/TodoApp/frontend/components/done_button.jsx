let React = require('react');
let TodoStore = require('../stores/todo_store.js');

var DoneButton = React.createClass({
  getInitialState(){
    return({done: this.props.todoList.done});
  },

  handleDone(event){
    event.preventDefault();
    
    TodoStore.toggleDone(this.props.todoList.id);
    this.setState({done: this.props.todoList.done});
  },

  render(){
    let buttonText;
    if (this.props.todoList.done) {
        buttonText = "Undo";
    } else {
      buttonText = "Done";
    }
    return(
      <button onClick={this.handleDone}>{buttonText}</button>
    );
  }

});







module.exports = DoneButton;
