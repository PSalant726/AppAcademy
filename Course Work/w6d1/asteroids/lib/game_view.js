
const GameView = function (game, ctx) {
  this.game = game;
  this.ctx = ctx;
};

GameView.prototype.start = function () {
  setInterval(function (){
    this.game.draw(this.ctx);
  }.bind(this), 20);
  setInterval(function () {
    this.game.step();
  }.bind(this), 20);
};

module.exports = GameView;
