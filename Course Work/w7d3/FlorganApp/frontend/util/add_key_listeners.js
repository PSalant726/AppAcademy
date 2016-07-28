const KeyActions = require('../actions/key_actions.js');
const KEYS = require('../constants/keys.js');

module.exports = function(){
  $(document).on('keydown', (e) => {
    // dispatch a keyAction to add the key
    KeyActions.keyPressed(KEYS[e.keyCode]);
  });
  $(document).on('keyup', (e) => {
    // dispatch a keyAction to remove the key
    KeyActions.keyReleased(KEYS[e.keyCode]);
  });
};
