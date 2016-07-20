/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	let HanoiGame = __webpack_require__(1);
	let HanoiView = __webpack_require__(2);


	$( () => {
	  const rootEl = $('.hanoi');
	  const game = new HanoiGame();
	  new HanoiView(game, rootEl);
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	function Game () {
	  this.towers = [[3, 2, 1], [], []];
	}

	Game.prototype.isValidMove = function(startTowerIdx, endTowerIdx) {
	    const startTower = this.towers[startTowerIdx];
	    const endTower = this.towers[endTowerIdx];

	    if (startTower.length === 0) {
	      return false;
	    } else if (endTower.length === 0) {
	      return true;
	    } else {
	      const topStartDisc = startTower[startTower.length - 1];
	      const topEndDisc = endTower[endTower.length - 1];
	      return topStartDisc < topEndDisc;
	    }
	};

	Game.prototype.isWon = function(){
	    // move all the discs to the last or second tower
	    return (this.towers[2].length == 3) || (this.towers[1].length == 3);
	};


	Game.prototype.move = function(startTowerIdx, endTowerIdx) {
	    if (this.isValidMove(startTowerIdx, endTowerIdx)) {
	      this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());
	      return true;
	    } else {
	      return false;
	    }
	};


	Game.prototype.print = function(){
	    console.log(JSON.stringify(this.towers));
	};


	Game.prototype.promptMove = function(reader, callback) {
	    this.print();
	    reader.question("Enter a starting tower: ", start => {
	      const startTowerIdx = parseInt(start);
	      reader.question("Enter an ending tower: ", end => {
	        const endTowerIdx = parseInt(end);
	        callback(startTowerIdx, endTowerIdx);
	      });
	    });
	};

	Game.prototype.run = function(reader, gameCompletionCallback) {
	    this.promptMove(reader, (startTowerIdx, endTowerIdx) => {
	      if (!this.move(startTowerIdx, endTowerIdx)) {
	        console.log("Invalid move!");
	      }

	      if (!this.isWon()) {
	        // Continue to play!
	        this.run(reader, gameCompletionCallback);
	      } else {
	        this.print();
	        console.log("You win!");
	        gameCompletionCallback();
	      }
	    });
	};

	module.exports = Game;


/***/ },
/* 2 */
/***/ function(module, exports) {

	var View = function (game, $el) {
	  this.game = game;
	  this.el = $el;
	  this.setupTowers();
	  this.render();
	  this.bindEvents();
	  this.chosenTower = null;
	};

	View.prototype.setupTowers = function () {
	  let $towers = $("<ul></ul>");
	  $towers.attr("class", "towers group");
	  this.el.append($towers);
	  for(let i = 0; i < 3; i++){
	    let $tower = $("<li></li>");
	    $tower.attr("id",`tower-${i}`);
	    $tower.attr("class", "tower");
	    $towers.append($tower);
	    $tower.append($(`<ul id=\"discs-${i}\" class="discs"></ul>`));
	  }
	};


	View.prototype.render = function () {
	  $('li').remove('.disc');
	  for (let i = 0; i < this.game.towers.length; i++){
	    let $tower = $(`#discs-${i}`);
	    for (let j = 0; j < this.game.towers[i].length; j++){
	      let discSize = this.game.towers[i][j] - 1;
	      let $disc = $(`<li id=\"disc-${discSize}\"></li>`);
	      $disc.attr("class", "disc");
	      $tower.prepend($disc);
	    }
	  }
	};

	View.prototype.bindEvents = function () {
	  $("li.tower").on("click", event => {
	    $('h1').remove('.message');
	    const $clickTower = $(event.currentTarget);
	    let towerId = $clickTower.attr("id");
	    let towerIdx =  parseInt(towerId[towerId.length - 1]);
	    if (this.chosenTower !== null) {
	      let move = this.game.move(this.chosenTower,towerIdx);
	      this.render();
	      this.chosenTower = null;
	      if (!move) postMessage("Yo shit is whackkkkkk!!");
	      if (this.game.isWon()) postMessage("You Win!");
	    } else {
	      this.chosenTower = towerIdx;
	    }
	  });
	};

	let postMessage = function (message) {
	  let $body = $("body");
	  $body.append(`<h1 class="message">${message}</h1>`);
	};

	module.exports = View;


/***/ }
/******/ ]);