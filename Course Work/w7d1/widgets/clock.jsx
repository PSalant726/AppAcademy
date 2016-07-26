const React = require('react');

const Clock = React.createClass({
  getInitialState() {
    return {time: new Date()};
  },
  tick() {
    this.setState({time: new Date()});
  },

  componentDidMount() {
    setInterval(this.tick, 1000);
  },

  render() {
    return (
      <div>
        <h1>Clock</h1>

        <div className='clock'>

          <div>
            Time: {this.state.time.toTimeString()}
          </div>

          <div>
            Date: {this.state.time.toDateString()}
          </div>

        </div>

      </div>
    );
  }
});

module.exports = Clock;
