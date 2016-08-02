const React = require('react');
const ReactDOM = require('react-dom');
const BenchStore = require('../stores/bench_store');
const BenchActions = require('../actions/bench_actions');
const hashHistory = require('react-router').hashHistory;

const BenchMap = React.createClass({
  componentDidMount(){
    let that = this;
    const mapDOMNode = ReactDOM.findDOMNode(this.refs.map);
    const mapOptions = {
      center: {lat: 40.767368, lng: -73.972669},
      zoom: 12
    };
    this.map = new google.maps.Map(mapDOMNode, mapOptions);
    this.listener = BenchStore.addListener(this.markMaker);
    this.idleListener = this.map.addListener("idle", function(){
      let bounds = that.map.getBounds();
      let northEast = { "lat": bounds.getNorthEast().lat(),
        "lng": bounds.getNorthEast().lng()
      };
      let southWest = { "lat": bounds.getSouthWest().lat(),
        "lng": bounds.getSouthWest().lng()
      };
      BenchActions.fetchAllBenches({bounds: {"northEast": northEast,
        "southWest": southWest
      }});
    });
    google.maps.event.addListener(this.map, 'click', event => {
      const coords = { lat: event.latLng.lat(), lng: event.latLng.lng() };
      that._handleClick(coords);
    });
  },

  _handleClick(coords) {
    hashHistory.push({
      pathname: "benches/new",
      query: coords
    });
  },

  componentWillUnmount(){
    this.listener.remove();
    this.idleListener.remove();
  },

  markMaker(){
    let benches = BenchStore.all();
    let lastMarkers = [];
    if (this.markers) {
      lastMarkers = this.markers;
    } else {
      lastMarkers = [];
    }
    this.markers = [];
    Object.keys(benches).forEach(benchId => {
      let pos = new google.maps.LatLng(
        benches[benchId].lat,
        benches[benchId].lng
      );
      let marker = new google.maps.Marker({
        position: pos,
        title: "BenchBnB!",
        map: this.map
      });
      this.markers.push(marker);
    });
    lastMarkers.forEach(marker => {
      if(!this.markers.includes(marker)){
        marker.setMap(null);
      }
    });
  },

  render(){
    return(
      <div className="map" ref="map"></div>
    );
  }
});

module.exports = BenchMap;
