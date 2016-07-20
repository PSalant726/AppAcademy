const View = require('./ttt-view.js');// require appropriate file
const Game = require('../ticTacToe/game.js');// require appropriate file

$( () => {
  // Your code here
  let viewElement = $('.ttt');
  let game = new Game();
  let view = new View(game, viewElement);


  view.setupBoard();
  view.bindEvents();
});
