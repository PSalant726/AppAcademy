const React = require('react');
const ReactDOM = require('react-dom');
const Search = require('./components/search.jsx');
const ReactRouter = require('react-router');
const Router = ReactRouter.Router;
const Route = ReactRouter.Route;
const IndexRoute = ReactRouter.IndexRoute;
const hashHistory = ReactRouter.hashHistory;
const BenchForm = require('./components/bench_form');

const App = React.createClass({
  render(){
    return (
      <div>
        <header><h1>Bench BnB</h1></header>
        { this.props.children }
      </div>
    );
  }
});

const appRouter = (
  <Router history={ hashHistory }>
    <Route path="/" component={ App }>
      <IndexRoute component={ Search } />
      <Route path="/benches/new" component={ BenchForm } />
    </Route>
  </Router>
);

document.addEventListener("DOMContentLoaded", function(){
  ReactDOM.render(appRouter, document.getElementById('content'));
});
