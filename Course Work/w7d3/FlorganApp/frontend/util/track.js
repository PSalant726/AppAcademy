const React = require('react');
const KeyStore = require('../stores/key_store.js');

const Track = function (attr) {
  this.name = attr.name || "";
  this.roll = attr.roll || [];
};

Track.prototype.startRecording = function () {
  this.roll = [];
  this.startTime = Date.now();
};

Track.prototype.addNotes = function (notesAry) {
  this.roll.push({
    timeSlice: Date.now() - this.startTime,
    notes: notesAry //Object.keys(KeyStore.all())
  });
};

Track.prototype.stopRecording = function () {
  this.addNotes([]);
};

module.exports = Track;
