package com.kennygoff;

import flash.display.Sprite;
import flash.events.Event;

class Game extends Sprite
{
  public function new()
  {
    super();

    this.addEventListener(Event.ADDED_TO_STAGE, _init);
  }

  public function init(e:Event)
  {
  }

  public function update(e:Event)
  {
  }

  public function _init(e:Event)
  {
    this.removeEventListener(Event.ADDED_TO_STAGE, init);

    init(e);

    this.addEventListener(Event.ENTER_FRAME, update);
  }
}