const React = require('react');

const BenchIndexItem = React.createClass({
  render (){
    return(
      <li className="bench-index-item">
        {this.props.bench.name}
        <br></br>
        {this.props.bench.description}
      </li>
    );
  }
});

module.exports = BenchIndexItem;
