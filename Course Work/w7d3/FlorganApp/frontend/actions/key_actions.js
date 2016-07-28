const AppDispatcher = require('../dispatcher/dispatcher');

const KeyActions = {
  keyPressed: function (noteName) {
    AppDispatcher.dispatch({
      actionType: "PRESS_KEY",
      noteName: noteName
    });
  },

  keyReleased: function (noteName) {
    AppDispatcher.dispatch({
      actionType: "RELEASE_KEY",
      noteName: noteName
    });
  }
};

module.exports = KeyActions;
