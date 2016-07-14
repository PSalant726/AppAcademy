function myUniq(arr) {
  let ret_arr = [];
  for (let i = 0; i < arr.length; i++) {
    if (!ret_arr.includes(arr[i])) {
      ret_arr.push(arr[i]);
    }
  }
  return ret_arr;
}

// console.log(myUniq([1,1,2,2,3,3,1]));


function twoSum(arr) {
  let ret_arr = [];

  for (let i = 0; i < arr.length; i++) {
    for (let j = i + 1; j < arr.length; j++) {
      if (arr[i] + arr[j] === 0) {
        ret_arr.push([i, j]);
      }
    }
  }
  return ret_arr;
}

// console.log(twoSum([-1, 0, 2, -2, 1]));

function transpose(arr) {
  let ret_arr = [];
  for (let i = 0; i < arr.length; i++) { //row
    ret_arr[i] = [];
    for (let j = 0; j < arr.length; j++) { //column
      ret_arr[i].push(arr[j][i]);
    }
  }
  return ret_arr;
}

// console.log(transpose([[0, 1, 2],[3, 4, 5],[6, 7, 8]]));
