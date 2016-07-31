const BenchStore = require('../stores/bench_store.js');
const BenchIndexItem = require('./bench_index_item.jsx');
const BenchActions = require('../actions/bench_actions');
const React = require('react');

const BenchIndex = React.createClass({
  getInitialState(){
    return({ benches: BenchStore.all() });
  },

  componentDidMount(){
    this.listener = BenchStore.addListener(this._handleChange);
    // BenchActions.fetchAllBenches();
  },

  _handleChange(){
    this.setState({ benches: BenchStore.all() });
  },

  componentWillUnmount(){
    this.listener.remove();
  },

  render(){
    let benchIndexItems = Object.keys(this.state.benches).map((bench, i) => {
      return (<BenchIndexItem bench={ this.state.benches[bench] } key={ i } />);
    });

    return(<ul className="bench-index">{ benchIndexItems }</ul>);
  }
});

module.exports = BenchIndex;
