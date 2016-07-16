const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function Game(stackSize) {
  this.stackSize = stackSize;
  this.towers = [[], [], []];
  for(let i = stackSize; i > 0; i--) {
    this.towers[0].push(i);
  }
}

Game.prototype.promptMove = function (completionCallBack) {
  let that = this;
  that.printTowers();
  reader.question("Which tower do you want to take from: ",
    function(idx1){
    let startTowerIdx = idx1;

    reader.question("Which tower do you want to move the disk to: ",
      function(idx2){
      let endTowerIdx = idx2;

      that.makeMove(startTowerIdx, endTowerIdx);
      that.run(completionCallBack);
    });
  });
};

Game.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  let startTower = this.towers[startTowerIdx];
  let endTower = this.towers[endTowerIdx];

  if ((startTowerIdx === endTowerIdx) ||
      (startTowerIdx < 0 ||startTowerIdx > 2) ||
      (endTowerIdx < 0 || endTowerIdx > 2) ||
      (startTower.length === 0) ||
      (startTower[startTower.length - 1] > endTower[endTower.length - 1])) {
    return false;
  }
  else {
    return true;
  }
};

Game.prototype.makeMove = function (startTowerIdx, endTowerIdx) {
  let startTower = this.towers[startTowerIdx];
  let endTower = this.towers[endTowerIdx];

  if (this.isValidMove(startTowerIdx, endTowerIdx) === true){
      endTower.push(startTower.pop());
  } else {
    console.log("That move is invalid!");
    this.promptMove(completionCallBack);
  }
};

Game.prototype.printTowers = function () {
  console.log(JSON.stringify(this.towers));
};

Game.prototype.isWon = function () {
  if (this.towers[1].length === this.stackSize ||
      this.towers[2].length === this.stackSize) {
    return true;
  } else {
    return false;
  }
};

// game = new Game(3);
// game.makeMove(0, 2);
// game.makeMove(0, 1);
// game.makeMove(2, 1);
// game.makeMove(0, 2);
// game.makeMove(1, 0);
// game.makeMove(1, 2);
// game.makeMove(0, 2);
// console.log(game.isWon());

Game.prototype.run = function (completionCallBack) {
  if (this.isWon()) {
    reader.close();
    completionCallBack();
  } else {
    this.promptMove(completionCallBack);
  }
};

game = new Game(3);
game.run(function () {
   game.printTowers();
   console.log("You win!");
 });
