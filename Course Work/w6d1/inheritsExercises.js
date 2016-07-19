Function.prototype.inherits = function (superClass) {
  const Surrogate = function () {};
  Surrogate.prototype = superClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};


// function MovingObject () {}
//
// function Ship () {}
// Ship.inherits(MovingObject);
//
// function Asteroid (size) {
//   this.size = size;
// }
//
// Asteroid.inherits(MovingObject);
// MovingObject.prototype.velocity = function () {};
// Asteroid.prototype.speed = function(){};
// a = new Asteroid();
