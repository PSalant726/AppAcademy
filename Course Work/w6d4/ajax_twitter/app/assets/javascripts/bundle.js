/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	let FollowToggle = __webpack_require__(1);
	let UserSearch = __webpack_require__(2);
	
	$(document).ready(function() {
	  $.each($('button.follow-toggle'), function(i, val) {
	    new FollowToggle(val);
	  });
	  $.each($('.query'), function(i, val) {
	    new UserSearch(val);
	  });
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

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


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	let FollowToggle = __webpack_require__(1);
	
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


/***/ }
/******/ ]);
//# sourceMappingURL=bundle.js.map