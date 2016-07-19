const Game = require("./lib/game.js");
const GameView = require("./lib/game_view.js");
const Asteroid = require("./lib/asteroid.js");

document.addEventListener("DOMContentLoaded", function () {
  const canvas = document.getElementById('game-canvas');
  const game = new Game();
  canvas.width = game.dimX;
  canvas.height = game.dimY;

  const ctx = canvas.getContext('2d');
  const gameView = new GameView(game, ctx);
  gameView.start();

});

window.Asteroid = Asteroid;
