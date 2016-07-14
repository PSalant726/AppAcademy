// Part I - JS Fundamentals

function madLib(verb, adj, noun) {
  console.log('We shall ' + verb + ' the ' + adj + ' ' + noun);
}

function isOdd(num){
  if (num % 2 === 0){
    return false;
  }
  return true;
}

function yell(words){
  console.log(words.toUpperCase() + '!!!');
}

function isSubstring(searchString, subString){
  console.log(searchString.includes(subString));
}

// Part II - JS Looping Constructs

function fizzBuzz(arr){
  var ret_arr = [];
  for (var i = 0; i < arr.length; i++) {
    if (i % 3 === 0 || i % 5 === 0) {
      ret_arr.push(i);
    }
  }
  console.log(ret_arr);
}

function isPrime(num){
  for (var i = 2; i < num; i++) {
    if (num % i === 0) {
      return false;
    }
  }
  return true;
}

function sumOfNPrimes(num){
  var primes = [];
  while (primes.length < num) {
    var i = 2;
    if (isPrime(i)) {
      primes.push(i);
    }
    i++;
  }
  var sum = 0;
  primes.forEach(prime => sum += prime);
  console.log(sum);
}

// Part III - Arguments

function printChildren(parent, ...children){
  console.log(parent + "'s children are:");
  children.forEach(child => console.log(child));
}

function addThree (a, b, c) {
  return a + b + c;
}

var arr = [1,2,3];

console.log(addThree(...arr));

function dinnerTonightIs(food = "pizza"){
  console.log("Dinner tonight is " + food);
}
