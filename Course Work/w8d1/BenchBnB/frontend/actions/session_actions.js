const SessionApiUtil = require('../util/session_api_util');
const AppDispatcher = require('../dispatcher/dispatcher');
const SessionConstants = require('../constants/session_constants');

const SessionActions = {
  signUp(user){
    // add errorCallback argument
    SessionApiUtil.signUp(user, SessionActions.receiveCurrentUser);
  },

  logIn(user){
    // add errorCallback argument
    SessionApiUtil.logIn(user, SessionActions.receiveCurrentUser);
  },

  logOut(){
    // add errorCallback argument
    SessionApiUtil.logOut(SessionActions.removeCurrentUser);
  },

  receiveCurrentUser(user){
    AppDispatcher.dispatch({
      actionType: SessionConstants.LOGIN,
      user: user
    });
  },

  removeCurrentUser(){
    AppDispatcher.dispatch({
      actionType: SessionConstants.LOGOUT,
    });
  }
};

module.exports = SessionActions;
