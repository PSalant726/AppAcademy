const React = require('react');
const KeyStore = require('../stores/key_store.js');
const Track = require('../util/track.js');

const Recorder = React.createClass({
  getInitialState(){
    return ({
      recording: false,
      track: new Track({})
    });
  },

  toggleRecording(e){
    e.preventDefault();
    if (this.state.recording) {
      this.listener.remove();
      this.state.track.stopRecording();
    } else {
      this.listener = KeyStore.addListener(this.updateTrack);
      this.state.track.startRecording();
    }
    this.setState({ recording : (this.state.recording === true ? false : true) });
  },

  updateTrack(){
    this.state.track.addNotes(Object.keys(KeyStore.all()));
    console.log(this.state.track.roll);
  },

  render(){
    return(
      <div>
        <button
          onClick={ this.toggleRecording }>
          {this.state.recording ? "Stop" : "Record"}
        </button>
      </div>
    );
  }
});

module.exports = Recorder;
