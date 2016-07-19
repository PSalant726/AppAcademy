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
