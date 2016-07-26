const React = require('react');
const ReactDOM = require('react-dom');
const Tabs = require('./tabs.jsx');
const Clock = require('./clock.jsx');
const Weather = require('./weather.jsx');

const Panes = [
  {title: "title one", content: "content one"},
  {title: "curry blows", content: "seriously tho"},
  {title: "F Durant", content: "FTW"}
];

var Widgets = React.createClass({
  render() {
    return(
      <div>
        <Clock/>
          <br></br>
        <Weather/>
          <br></br>
        <Tabs panes={Panes}/>
      </div>
    );
  }
});

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<Widgets />, document.getElementById('main'));
});
