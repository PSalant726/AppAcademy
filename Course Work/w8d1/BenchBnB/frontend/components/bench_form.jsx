const React = require('react');
const BenchActions = require('../actions/bench_actions');
const hashHistory = require('react-router').hashHistory;

const BenchForm = React.createClass({
  getInitialState(){
    return({
      name: "",
      description: "",
      seating: 2
    });
  },

  update(prop){
    return (e) => this.setState({[prop]: e.target.value});
  },

  handleSubmit(event){
    event.preventDefault();
    const bench = Object.assign({}, this.state, this.props.location.query);
    BenchActions.createBench(bench);
    hashHistory.push("/");
  },

  handleCancel(event){
    event.preventDefault();
    hashHistory.push("/");
  },

  render(){
    return(
      <form className="bench-form" onSubmit={ this.handleSubmit }>
        <h3>Create Bench</h3>

        <label>Name: </label>
        <input type="text" value={ this.state.name }
          onChange={ this.update("name")} />
        <br></br>

        <label>Description: </label>
        <input type="text" value={ this.state.description }
          onChange={ this.update("description")} />
        <br></br>

        <label>Number of Seats: </label>
        <input min="0" type="number" value={ this.state.seating }
          onChange={ this.update("seating")} />
        <br></br>

        <label>Latitude: </label>
        <input disabled type="number" value={ this.props.location.query.lat } />
        <br></br>

        <label>Longitude: </label>
        <input disabled type="number" value={ this.props.location.query.lng } />
        <br></br>

        <br></br>
        <input type="submit" value="Create" />
        <button onClick={ this.handleCancel }>Cancel</button>
      </form>
    );
  }
});

module.exports = BenchForm;
