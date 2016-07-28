const React = require('react');
const TONES = require('../constants/tones.js');
const NoteKey = require('./note_key.jsx');
const Recorder = require('./recorder.jsx');

const Organ = React.createClass({
  render(){
    let notes = Object.keys(TONES).map((tone, idx) => {
      return <NoteKey noteName={ tone } key={ idx } />;
    });

    return (
      <div className="organ">
        { notes }
        <Recorder />
      </div>
    );
  }
});


module.exports = Organ;
