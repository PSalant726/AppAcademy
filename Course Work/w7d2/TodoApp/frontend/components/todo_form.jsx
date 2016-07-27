let React = require('react');
let TodoStore = require('../stores/todo_store.js');

const TodoForm = React.createClass({
  getInitialState(){
    return(
      { title: "", body: "", done: false }
    );
  },

  updateTitle(event){
    this.setState({ title: event.currentTarget.value });
  },

  updateBody(event){
    this.setState({ body: event.currentTarget.value });
  },

  handleSubmit(event){
    event.preventDefault();
    TodoStore.create(this.state);
    
    this.setState({ title: "", body: "", done: false });
  },

  render(){
    return (
      <form onSubmit={this.handleSubmit}>
        <input type="text"
          placeholder="Title"
          value={this.state.title}
          onChange={this.updateTitle}>
        </input>
        <br></br>
        <textarea
          placeholder="Body"
          value={this.state.body}
          onChange={this.updateBody}>
        </textarea>
        <br></br>
        <button type="submit">
          Submit
        </button>
      </form>
    );
  }
});

module.exports = TodoForm;
