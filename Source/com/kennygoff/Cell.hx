package com.kennygoff;

class Cell extends Entity
{
  var rendered : Bool;
  function new(?x:Int, ?y:Int, ?width:Int, ?height:Int)
  {
    super();

    rendered = false;
    this.x = (x == null)? 0 : x;
    this.y = (y == null)? 0 : y;
    this._initDimensions((width == null)? 10 : width, (height == null)? 10 : height);
  }

  public override function render()
  {
    if(rendered) return;
    rendered = true;
    
    this.graphics.beginFill(0x555555, 1);
    this.graphics.drawRect(0, 0, this.width, this.height);
    this.graphics.endFill();
  }
}