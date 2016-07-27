const React = require('react');

var TodoDetailView = React.createClass({


  render(){
    return(
      <div>
        <p>{this.props.todoList.body}</p>
        <button onClick={this.props.destroyAction}>Delete</button>
      </div>
    );
  }

});



module.exports = TodoDetailView;
