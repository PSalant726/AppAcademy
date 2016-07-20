var View = function (game, $el) {
  this.game = game;
  this.el = $el;
  this.setupTowers();
  this.render();
  this.bindEvents();
  this.chosenTower = null;
};

View.prototype.setupTowers = function () {
  let $towers = $("<ul></ul>");
  $towers.attr("class", "towers group");
  this.el.append($towers);
  for(let i = 0; i < 3; i++){
    let $tower = $("<li></li>");
    $tower.attr("id",`tower-${i}`);
    $tower.attr("class", "tower");
    $towers.append($tower);
    $tower.append($(`<ul id=\"discs-${i}\" class="discs"></ul>`));
  }
};


View.prototype.render = function () {
  $('li').remove('.disc');
  for (let i = 0; i < this.game.towers.length; i++){
    let $tower = $(`#discs-${i}`);
    for (let j = 0; j < this.game.towers[i].length; j++){
      let discSize = this.game.towers[i][j] - 1;
      let $disc = $(`<li id=\"disc-${discSize}\"></li>`);
      $disc.attr("class", "disc");
      $tower.prepend($disc);
    }
  }
};

View.prototype.bindEvents = function () {
  $("li.tower").on("click", event => {
    $('h1').remove('.message');
    const $clickTower = $(event.currentTarget);
    let towerId = $clickTower.attr("id");
    let towerIdx =  parseInt(towerId[towerId.length - 1]);
    if (this.chosenTower !== null) {
      let move = this.game.move(this.chosenTower,towerIdx);
      this.render();
      this.chosenTower = null;
      if (!move) postMessage("Yo shit is whackkkkkk!!");
      if (this.game.isWon()) postMessage("You Win!");
    } else {
      this.chosenTower = towerIdx;
    }
  });
};

let postMessage = function (message) {
  let $body = $("body");
  $body.append(`<h1 class="message">${message}</h1>`);
};

module.exports = View;
