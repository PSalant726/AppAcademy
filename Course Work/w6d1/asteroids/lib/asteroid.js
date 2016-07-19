
const Util = require('./utils.js');
const MovingObject = require('./moving_object.js');


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
