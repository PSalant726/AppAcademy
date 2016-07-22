let FollowToggle = require('./follow_toggle.js');

const UserSearch = function(nav) {
  this.$nav = $(nav);
  this.$input = $('input.query');
  this.ul = $('ul.users');
  this.handleInput();
};

UserSearch.prototype.handleInput = function () {
  let that = this;
  this.$input.on("input", function (event) {
    event.preventDefault();
    let formData = $(this).val();
    $.ajax({
      url: `/users/search`,
      type: 'GET',
      dataType: "json",
      data: {query: formData},
      success: (users) => {
        // debugger
        that.renderResults(users);
      }
    });
  });
};

UserSearch.prototype.renderResults = function (users) {
  $('ul.users').empty();
  users.forEach( (user) => {
    let $li = $(`<li><a href="/users/${user.id}/">${user.username}</a><button id=\"${user.id}\" class="follow-toggle" type="submit" data-initial-follow-state="" data-user-id="${user.id}"></button></li>`);
    $('ul.users').append($li);
    let $button = $(`button#${user.id}`);
    let followedState;
    if (user.followed) {
      followedState = "followed";
    } else if (!user.followed) {
      followedState = "unfollowed";
    }
    // debugger
    new FollowToggle($button, { userId: user.id, followedState: followedState });
    $(`button#${user.id}`).css("margin-left", "5px");
  });
};


module.exports = UserSearch;
