package com.kennygoff;

import flash.display.Sprite;
import flash.events.Event;

class Entity extends Sprite
{
  public function new()
  {
    super();

    this.addEventListener(Event.ADDED_TO_STAGE, init);
  }

  public function init(e:Event)
  {
    this.removeEventListener(Event.ADDED_TO_STAGE, init);
  }
  
  private function _initDimensions(w:Int, h:Int)
  {
    this.graphics.beginFill(0xFFFFFF, 0);
    this.graphics.drawRect(0, 0, w, h);
    this.graphics.endFill();

    this.width = w;
    this.height = h;
  }
}