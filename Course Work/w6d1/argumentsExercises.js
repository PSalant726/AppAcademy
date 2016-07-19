function argsSum() {
  let args = Array.from(arguments);
  // let args = Array.prototype.slice.call(arguments);
  let sum = 0;
  args.forEach (function (arg) {
    sum += arg;
  });
  return sum;
}

function restSum(...args) {
  let sum = 0;
  args.forEach (function (arg) {
    sum += arg;
  });
  return sum;
}

Function.prototype.argsMyBind = function (context) {
  let args = Array.from(arguments).slice(1);
  let that = this;
  return function () {
    let args2 = Array.from(arguments);
    that.apply(context, args.concat(args2));
  };
};


Function.prototype.restMyBind = function(context, ...args) {
  return (...args2) => {
    this.apply(context, args.concat(args2));
  };
};

function curriedSum(numArgs) {
  let numbers = [];
  let sum = 0;
  function _curriedSum(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      numbers.forEach (function (number) {
        sum += number;
      });
      return sum;
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;
}

Function.prototype.argCurry = function (numArgs) {
  let args = [];
  let that = this;
  function _curry (num) {
    args.push(num);

    if (args.length < numArgs) {
      return _curry;
    } else {
      return that.apply(null, args);
    }
  }
  return _curry;
};

Function.prototype.restCurry = function (numArgs) {
  let args = [];
  let that = this;
  function _curry (num) {
    args.push(num);

    if (args.length < numArgs) {
      return _curry;
    } else {
      return that.call(null, ...args);
    }
  }
  return _curry;
};
