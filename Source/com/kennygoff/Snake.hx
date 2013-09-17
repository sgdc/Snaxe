package com.kennygoff;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

enum Direction
{
  Up; Right; Down; Left;
}

class Snake extends Entity
{
  var cells : Array<Cell>;
  var direction : Direction;

  public function new(?x:Int, ?y:Int)
  {
    super();

    this.x = (x == null)? 0 : x;
    this.y = (y == null)? 0 : y;
    this.direction = Right;
  }

  public override function init(e:Event)
  {
    super.init(e);

    cells = new Array<Cell>();
    cells.push(new Cell(0, 0, 20, 20));
    addChild(cells[0]);

    stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
  }

  public function update(e:Event)
  {
    switch(this.direction)
    {
      case Up: this.y -= 1;
      case Right: this.x += 1;
      case Down: this.y += 1;
      case Left: this.x -= 1;
    }
  } 

  public override function render()
  {
    for(cell in cells)
    {
      cell.render();
    }
  }

  private function stage_onKeyDown(e:KeyboardEvent)
  {
    switch (e.keyCode)
    {
      case Keyboard.UP: direction = Up;
      case Keyboard.RIGHT: direction = Right;
      case Keyboard.DOWN: direction = Down;
      case Keyboard.LEFT: direction = Left;
    }
  }
}