let HanoiGame = require('../game/game.js');
let HanoiView = require('../game/toh-view.js');


$( () => {
  const rootEl = $('.hanoi');
  const game = new HanoiGame();
  new HanoiView(game, rootEl);
});
