package com.kennygoff;

import flash.events.Event;

class Cell extends Entity
{
  function new(?x:Int, ?y:Int, ?width:Int, ?height:Int)
  {
    super();
    
    this.x = (x == null)? 0 : x;
    this.y = (y == null)? 0 : y;
    this._initDimensions((width == null)? 10 : width, (height == null)? 10 : height);
  }

  public override function init(e:Event)
  {
    this.graphics.beginFill(0x555555, 1);
    this.graphics.drawRect(0, 0, this.width, this.height);
    this.graphics.endFill();
  }
}