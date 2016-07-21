const Asteroid = require('./asteroid.js');
const MovingObject = require('./moving_object.js');

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
          asteroid.changeDirection(asteroid2);
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
