let FollowToggle = require('./follow_toggle.js');
let UserSearch = require('./user_search.js');

$(document).ready(function() {
  $.each($('button.follow-toggle'), function(i, val) {
    new FollowToggle(val);
  });
  $.each($('.query'), function(i, val) {
    new UserSearch(val);
  });
});
