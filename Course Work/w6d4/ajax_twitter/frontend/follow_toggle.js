const FollowToggle = function(el, options = {}) {
  this.$el = $(el);
  this.userId = this.$el.data('user-id');
  this.followState = options.followedState || this.$el.data('initial-follow-state');
  this.render();
  this.handleClick();
};

FollowToggle.prototype.render = function () {
  if (!this.$el.data('user-id')) this.$el.attr('data-user-id', this.userId);
  if (!this.$el.data('initial-follow-state')) this.$el.attr('data-initial-follow-state', this.followState);
  if (this.followState === "unfollowed") {
    this.$el.text("Follow!");
  }
  else if (this.followState === "followed") {
    this.$el.text("Unfollow!");
  }
};

FollowToggle.prototype.handleClick = function () {
  this.$el.on("click", event => {
    event.preventDefault();
    this.$el.prop("disabled", "true");
    if (this.followState === "unfollowed") {
      $.ajax({
        url: `/users/${this.userId}/follow`,
        type: 'POST',
        dataType: "json",
        success: () => {
          this.followState = "followed";
          this.$el.removeProp("disabled");
          this.render();
        }
      });
    } else if (this.followState === "followed") {
      $.ajax({
        url: `/users/${this.userId}/follow`,
        type: 'DELETE',
        dataType: "JSON",
        success: () => {
          this.followState = "unfollowed";
          this.$el.removeProp("disabled");
          this.render();
        }
      });
    }
  });
};

module.exports = FollowToggle;
