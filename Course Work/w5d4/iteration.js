 Array.prototype.bubbleSort = function () {
  let flag = false;

  while (flag === false) {
    flag = true;

    let i = 0;
    for (let j = i + 1; j < this.length; j++) {

      if (this[i] > this[j]) {
        flag = false;
        let holder = this[i];
        this[i] = this[j];
        this[j] = holder;
      }

      i++;
    }
  }

  return this;
};

// console.log([3,4,2,5,1,1,3,4,5].bubbleSort());

String.prototype.substrings = function () {
  let substr = [];
  for (let i = 0; i < this.length; i++) {
    for (let j = i + 1; j <= this.length; j++) {
      if (!substr.includes(this.slice(i, j))){
        substr.push(this.slice(i, j));
      }
    }
  }
  return substr;
};

// console.log("Tony".substrings());
