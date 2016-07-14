// function range (start, end) {
//   if (end < start) { return []; }
//   if (end === start) { return [start]; }
//   range(start, end - 1).push(end - 1);
// }
//
// console.log(range(1, 6));


// [start, end - 1].push(end)

function range(start, end) {
  if (end < start) { return []; }
  return [start].concat(range(start + 1, end));
}

// console.log(range(1, 20));

function itrSum(arr) {
  let sum = 0;
  arr.forEach( el => sum += el);

  return sum;
}

// console.log(itr_sum([1,2,3,4,5]));

function recSum(arr) {
  if (arr.length <= 1) { return arr[0]; }
  return arr[0] += recSum(arr.slice(1));
}

// console.log(rec_sum([1,2,3,4,5]));

function exp1(b, e) {
  if (e === 0) { return 1; }
  return b * exp1(b, e - 1);
}

// console.log(exp1(2, 3));

function exp2(b, e) {
  if (e === 0) {
    return 1;
  } else if (e % 2 === 0) {
    return Math.pow(exp2(b, e / 2), 2);
  } else {
    return b * Math.pow(exp2(b, (e - 1) / 2), 2);
  }
}

// console.log(exp2(2, 5));

function itFib(n) {
  let fib_arr = [0, 1];

  while (fib_arr.length <= n) {
    fib_arr.push(fib_arr[fib_arr.length - 1] + fib_arr[fib_arr.length - 2]);
  }

  return fib_arr;
}

// console.log(it_fib(13));

function recFib(n) {
  if (n === 0) {
    return [];
  } else if (n === 1) {
    return [0];
  } else if (n === 2) {
    return [0, 1];
  } else {
    let fibs = recFib(n - 1);
    fibs.push(fibs[fibs.length - 1] + fibs[fibs.length - 2]);

    return fibs;
  }
}

// console.log(rec_fib(13));

function bSearch(arr, target) {
  if (arr.length === 0) {
   return null;
  }
  let mid = Math.floor(arr.length / 2);
  // debugger
  if ( arr[mid] < target ) {
    let subresult = bSearch(arr.slice(mid+1), target);
    if (subresult === null) { return null; }
    return mid + 1 + subresult;
  } else if (arr[mid] === target) {
    return mid;
  } else {
    // debugger
    return bSearch(arr.slice(0, mid), target);
  }
}

// console.log(bSearch([1, 2, 3], 1));
// console.log(bSearch([2, 3, 4, 5], 3));
// console.log(bSearch([2, 4, 6, 8, 10], 6));
// console.log(bSearch([1, 3, 4, 5, 9], 5));
// console.log(bSearch([1, 2, 3, 4, 5, 6], 6));
// console.log(bSearch([1, 2, 3, 4, 5, 6], 0));
// console.log(bSearch([1, 2, 3, 4, 5, 7], 6));
