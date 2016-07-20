var View = function (game, $el) {
  this.game = game;
  this.el = $el;
  this.over = false;
};

View.prototype.bindEvents = function () {
  $("li").on("click", event => {
    const clickSquare = event.currentTarget;
    if ($(clickSquare).attr('class') === "square"){
      this.makeMove($(clickSquare));
    } else {
      alert("You can't make that move!");
    }
  });
};

View.prototype.makeMove = function ($square) {
  if (this.over === false){
    let currentPlayer = this.game.currentPlayer;
    let className = currentPlayer + "-square";
    this.game.playMove(posConvert($square));
    $square.attr("class", className);
    $square.text(currentPlayer);
    let message;
    if (this.game.board.isOver()){
      this.over = true;
      if (this.game.board.winner()){
        message = currentPlayer + " wins!";
      } else {
        message = "It's a draw!!!";
      }
      postMessage(message);
    }
  }
};

let postMessage = function (message) {
  let $body = $("body");
  $body.append(`<h1>${message}</h1>`);
};


let posConvert = function ($square) {
  let squareIndex = parseInt($square.attr('id')) + 1;
  let x = Math.floor((squareIndex / 3)+ 0.9) - 1;
  let y;
  if (squareIndex % 3 === 0) {
    y = 2;
  } else {
    y = (squareIndex % 3) - 1;
  }
  return [x,y];
};

View.prototype.setupBoard = function () {
  const $ul = $("<ul></ul>");
  this.el.append($ul);
  $ul.attr("class", "board group");
  for (let i = 0; i < 9; i++){
    let $li = $("<li></li>");
    $li.attr("class", "square");
    $li.attr("id", i);
    $ul.append($li);
  }
};

module.exports = View;
