package com.kennygoff;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import openfl.display.FPS;
import haxe.Timer;

enum Direction
{
  Up; Right; Down; Left;
}

class Snaxe extends Sprite
{
  var snake : Array<Cell>;
  var direction : Direction;
  var snakeLength : Int;
  var cacheTime : Float;
  var food : Cell;

  public function new()
  {
    super();

    this.addEventListener(Event.ADDED_TO_STAGE, init);
  }

  public function init(e:Event)
  {
    this.removeEventListener(Event.ADDED_TO_STAGE, init);

    cacheTime = Timer.stamp();
    addChild(new FPS(0, 0));
    initSnake();
    initFood();

    this.addEventListener(Event.ENTER_FRAME, update);
    stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
  }

  public function initFood()
  {
    if(food == null)
    {
      food = new Cell(0, 0, 10, 10);
      addChild(food);
    }

    var fx = Math.floor(Math.random() * 48);
    var fy = Math.floor(Math.random() * 48);

    food.x = fx*10;
    food.y = fy*10;
  }

  public function initSnake()
  {
    if(snake != null)
    {
      for(cell in snake)
      {
        removeChild(cell);
      }
    }

    direction = Right;
    snakeLength = 5;
    snake = new Array<Cell>();
    var cell = new Cell(0, 0);
    snake.push(cell);
    addChild(cell);
  }

  public function clear()
  {
    this.graphics.beginFill(0x66b5ff, 1);
    this.graphics.drawRect(0, 0, this.stage.width, this.stage.height);
    this.graphics.endFill();
  }

  public function update(e:Event)
  {
    var currentTime = Timer.stamp();
    if(currentTime - cacheTime > 0.05)
    {
      cacheTime = currentTime;

      var tail = snake.pop();
      var tail_x = Math.floor(tail.x);
      var tail_y = Math.floor(tail.y);
      if(snake.length > 0)
      {
        tail.x = snake[0].x;
        tail.y = snake[0].y;
      }
      switch(this.direction)
      {
        case Up: tail.y -= 10;
        case Right: tail.x += 10;
        case Down: tail.y += 10;
        case Left: tail.x -= 10;
      }

      snake.unshift(tail);

      if(snake.length < snakeLength)
      {
        var cell = new Cell(tail_x, tail_y);
        snake.push(cell);
        addChild(cell);
      }

      if(snake.length > 0 && food != null && Math.floor(snake[0].x/10) == Math.floor(food.x/10) && Math.floor(snake[0].y/10) == Math.floor(food.y/10))
      {
        snakeLength++;
        initFood();
      }
    }

    // render
    clear();
    for(cell in snake)
    {
      cell.render();
    }
    food.render();
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