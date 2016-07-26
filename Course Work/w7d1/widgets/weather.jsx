const React = require('react');

const Weather = React.createClass({
  getInitialState() {
    return {weather: null};
  },

  componentDidMount() {
    navigator.geolocation.getCurrentPosition(function (position) {
      this.loadXMLDoc(position.coords.latitude, position.coords.longitude);
    }.bind(this));
  },

  parseWeather(lat, long) {
    let parsed = JSON.parse(response);

    return `City: ${parsed.name} Temp: ${parsed.main.temp}`;
  },
  loadXMLDoc(lat, long) {
    var xmlhttp = new XMLHttpRequest();
    let that = this;

    xmlhttp.onreadystatechange = function() {
      if (xmlhttp.readyState == XMLHttpRequest.DONE ) {
        if (xmlhttp.status == 200) {
          that.setState({weather: JSON.parse(xmlhttp.responseText)});
        }
        else if (xmlhttp.status == 400) {
          alert('There was an error 400');
        }
        else {
          alert('something else other than 200 was returned');
        }
      }
    };

    xmlhttp.open("GET", `http://api.openweathermap.org/data/2.5/find?lat=${lat}&lon=${long}&APPID=645c5d39c7603f17e23fcaffcea1a3c1`, true);
    xmlhttp.send();
  },

  render() {
    if (this.state.weather){
      return (
        <div>
          <h1>Weather</h1>
          <div className='weather'>
            {this.state.weather.list[0].main.temp}
          </div>
        </div>
      );
    }else{
      return (
        <div>
          <h1>Loading Weather</h1>
        </div>
      );
    }
  }
});

module.exports = Weather;
