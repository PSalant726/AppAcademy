const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsleft, completionCallback) {
  if (numsleft > 0) {
    reader.question("Please provide a number: \n", function (number) {
      sum += parseInt(number);
      numsleft--;
      console.log(`Current sum: ${sum}`);
      addNumbers(sum, numsleft, completionCallback);
    });
  } else if (numsleft === 0) {
    completionCallback(sum);
    reader.close();
  }
}

// addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));
