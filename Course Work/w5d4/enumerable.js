Array.prototype.myEach = function(func) {
  for (let i = 0; i < this.length; i++) {
    func(this[i]);
  }
  return this;
};

// [1,2,3].myEach(el => console.log(el + 5));

Array.prototype.myMap = function (func) {
  let ret_arr = [];

  function action(el) {
    ret_arr.push(func(el));
  }

  this.myEach(action);

  return ret_arr;
};

// console.log([1,2,3].myMap(el => el + 5));

Array.prototype.myInject = function (func) {
  let accum = this[0];

  function action(el) {
    accum = func(accum, el);
  }

  this.slice(1).myEach(action);

  return accum;
};

// console.log([1,2,3].myInject((accum, el) => accum + el));
