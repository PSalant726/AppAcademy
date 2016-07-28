const React = require('react');
const Note = require('../util/note.js');
const TONES = require('../constants/tones.js');
const KeyStore = require('../stores/key_store.js');

const NoteKey = React.createClass({
  handleKey(){
    if(KeyStore.all()[this.props.noteName]) {
      document.getElementById(this.props.noteName).classList.add("pressed");
      this.note.start();
    } else {
      document.getElementById(this.props.noteName).classList.remove("pressed");
      this.note.stop();
    }
  },

  componentDidMount(){
    this.listener = KeyStore.addListener(this.handleKey);
    this.note = new Note(TONES[this.props.noteName]);
  },

  componentWillUnmount(){
    this.listener.remove();
  },

  render(){
    return(
      <div id={ this.props.noteName } className="key">
        { this.props.noteName }
      </div>
    );
  }
});

module.exports = NoteKey;
