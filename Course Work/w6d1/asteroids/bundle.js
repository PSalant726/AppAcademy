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

	const Game = __webpack_require__(1);
	const GameView = __webpack_require__(5);
	const Asteroid = __webpack_require__(2);

	document.addEventListener("DOMContentLoaded", function () {
	  const canvas = document.getElementById('game-canvas');
	  const game = new Game();
	  canvas.width = game.dimX;
	  canvas.height = game.dimY;

	  const ctx = canvas.getContext('2d');
	  const gameView = new GameView(game, ctx);
	  gameView.start();

	});

	window.Asteroid = Asteroid;


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Asteroid = __webpack_require__(2);
	const MovingObject = __webpack_require__(4);

	const Game = function () {
	  this.dimX = Game.DIM_X;
	  this.dimY = Game.DIM_Y;
	  this.numAsteroids = Game.NUM_ASTEROIDS;
	  this.asteroids = [];
	  this.addAsteroids();
	};

	Game.DIM_X = 1400;
	Game.DIM_Y = 900;
	Game.NUM_ASTEROIDS = 100;

	Game.prototype.addAsteroids = function () {
	  for (let i = 0; i < this.numAsteroids; i++ ){
	    options = { pos: this.randomPosition() };
	    this.asteroids.push(new Asteroid(options));
	  }
	};

	Game.prototype.randomPosition = function () {
	  let x = Math.random() * this.dimX;
	  let y = Math.random() * this.dimY;
	  return [x, y];
	};

	Game.prototype.draw = function (ctx) {
	  ctx.clearRect(0, 0, this.dimX, this.dimY);
	  let that = this;
	  this.asteroids.forEach(function (asteroid) {
	    asteroid.pos = that.wrap(asteroid.pos[0], asteroid.pos[1]);
	    asteroid.draw(ctx);
	  });
	};

	Game.prototype.moveObjects = function () {
	  this.asteroids.forEach(function (asteroid) {
	    asteroid.move();
	  });
	};

	Game.prototype.wrap = function (posX, posY) {
	  if (posX > (this.dimX + 100)) {
	    posX -= (this.dimX + 100);
	  } else if (posX < -100) {
	    posX += (this.dimX + 100);
	  }

	  if (posY > (this.dimY + 100)) {
	    posY -= (this.dimY + 100);
	  } else if (posY < -100) {
	    posY += (this.dimY + 100);
	  }

	  return [posX, posY];
	};

	Game.prototype.checkCollisions = function () {
	  let that = this;
	  this.asteroids.forEach(function (asteroid) {
	    that.asteroids.forEach(function (asteroid2) {
	      if (asteroid !== asteroid2) {
	        if (asteroid.isCollidedWith(asteroid2)) {
	          // asteroid.changeDirection(asteroid2);
	        }
	      }
	    });
	  });
	};

	Game.prototype.step = function () {
	  this.moveObjects();
	  this.checkCollisions();

	};


	module.exports = Game;


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	
	const Util = __webpack_require__(3);
	const MovingObject = __webpack_require__(4);


	const Asteroid = function (options) {
	  options.vel = Util.randomVec(Math.random() * 4);
	  options.color = '#'+(Math.random()*0xFFFFFF<<0).toString(16);
	  options.radius = Math.random() * 30 + 10;
	  MovingObject.call(this, options);
	};

	Asteroid.COLOR = '#000000';
	Asteroid.RADIUS = 20;

	Util.inherits(Asteroid, MovingObject);

	module.exports = Asteroid;


/***/ },
/* 3 */
/***/ function(module, exports) {

	const Util = {
	  inherits: function (childClass, parentClass) {
	    const Surrogate = function () {};
	    Surrogate.prototype = parentClass.prototype;
	    childClass.prototype = new Surrogate();
	    childClass.prototype.constructor = childClass;
	  },

	  randomVec: function (length) {
	    let x = Math.random() * length;
	    let y = Math.sqrt((length * length) - (x * x));
	    var multiplier = [-1, 1];
	    x = x * multiplier[Math.floor(Math.random() * multiplier.length)];
	    y = y * multiplier[Math.floor(Math.random() * multiplier.length)];
	    return [x, y];
	  }
	};


	module.exports = Util;


/***/ },
/* 4 */
/***/ function(module, exports) {

	const MovingObject = function (options) {
	  this.pos = options.pos;
	  this.vel = options.vel;
	  this.radius = options.radius;
	  this.color = options.color;
	};

	MovingObject.prototype.draw = function (ctx) {

	  ctx.fillStyle = this.color;
	  ctx.beginPath();
	  ctx.arc(
	    this.pos[0],
	    this.pos[1],
	    this.radius,
	    0,
	    2 * Math.PI,
	    false
	  );

	  ctx.fill();
	};

	MovingObject.prototype.move = function () {
	  this.pos[0] += this.vel[0];
	  this.pos[1] += this.vel[1];
	};

	MovingObject.prototype.isCollidedWith = function (otherObject) {
	  let collided = false;
	  let dist = Math.sqrt( Math.pow((this.pos[1] - otherObject.pos[1]),2) + Math.pow((this.pos[0] - otherObject.pos[0]),2) );
	  let min_dist = this.radius + otherObject.radius;
	  if (dist < min_dist) { collided = true; }
	  return collided;
	};

	MovingObject.prototype.changeDirection = function (otherObject) {
	  let temp = this.vel;
	  this.vel = otherObject.vel;
	  otherObject.vel = temp;
	};


	module.exports = MovingObject;


/***/ },
/* 5 */
/***/ function(module, exports) {

	
	const GameView = function (game, ctx) {
	  this.game = game;
	  this.ctx = ctx;
	};

	GameView.prototype.start = function () {
	  setInterval(function (){
	    this.game.draw(this.ctx);
	  }.bind(this), 20);
	  setInterval(function () {
	    this.game.step();
	  }.bind(this), 20);
	};

	module.exports = GameView;


/***/ }
/******/ ]);