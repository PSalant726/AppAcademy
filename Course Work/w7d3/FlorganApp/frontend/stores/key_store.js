const Store = require("flux/utils").Store;
const AppDispatcher = require('../dispatcher/dispatcher');
const TONES = require('../constants/tones.js');
const KeypressConstants = require('../constants/keypress_constants.js');

const KeyStore = new Store(AppDispatcher);

let _keys = {};

KeyStore.all = function () {
  let allKeys = {};
  return Object.assign(allKeys, _keys);
};

KeyStore.__onDispatch = function (payload) {
  switch (payload.actionType) {
    case KeypressConstants.PRESS_KEY:
      _keys[payload.noteName] = TONES[payload.noteName];
      KeyStore.__emitChange();
      break;
    case KeypressConstants.RELEASE_KEY:
      delete _keys[payload.noteName];
      KeyStore.__emitChange();
      break;
  }
};


module.exports = KeyStore;
