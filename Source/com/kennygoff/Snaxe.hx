package com.kennygoff;

import flash.display.Sprite;
import flash.events.Event;
import openfl.display.FPS;

class Snaxe extends Sprite
{
  var snake : Snake;

  public function new()
  {
    super();

    this.addEventListener(Event.ADDED_TO_STAGE, init);
  }

  public function init(e:Event)
  {
    this.removeEventListener(Event.ADDED_TO_STAGE, init);
    this.addEventListener(Event.ENTER_FRAME, update);

    snake = new Snake(20, 20);
    addChild(snake);

    addChild(new FPS(0, 0));
  }

  public function clear()
  {
    this.graphics.beginFill(0x66b5ff, 1);
    this.graphics.drawRect(0, 0, this.stage.width, this.stage.height);
    this.graphics.endFill();
  }

  public function update(e:Event)
  {
    snake.update(e);

    // render
    clear();
    snake.render();
  }
}