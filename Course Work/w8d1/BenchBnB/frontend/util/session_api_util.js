const SessionApiUtil = {
  signUp(user, successCallback, errorCallback){
    $.ajax({
      url: 'api/users',
      method: 'POST',
      data: { user: user },
      dataType: 'json',
      success: function(response){
        successCallback(response);
      },
      error: function(response){
        errorCallback(response);
      }
    });
  },

  logIn(user, successCallback, errorCallback){
    $.ajax({
      url: 'api/session',
      method: 'POST',
      data: { user: user },
      dataType: 'json',
      success: function(response){
        successCallback(response);
      },
      error: function(response){
        errorCallback(response);
      }
    });
  },

  logOut(successCallback, errorCallback){
    $.ajax({
      url: 'api/session',
      method: 'DELETE',
      success: function(response){
        successCallback(response);
      },
      error: function(response){
        errorCallback(response);
      }
    });
  }
};

module.exports = SessionApiUtil;
