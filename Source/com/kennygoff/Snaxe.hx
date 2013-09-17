package com.kennygoff;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import openfl.display.FPS;
import haxe.Timer;

enum Direction { Up; Right; Down; Left; }

class Snaxe extends Game
{
  private var snake : Array<Cell>;
  private var direction : Direction;
  private var snakeLength : Int;
  private var food : Cell;

  public function new()
  {
    super();
  }

  public override function init(e:Event)
  {
    super.init(e);

    this.graphics.beginFill(0x66b5ff, 1);
    this.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
    this.graphics.endFill();

    initSnake();
    initFood();

    addChild(new FPS(0, 0));
    stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
  }

  public function initFood()
  {
    if(food == null)
    {
      food = new Cell(0, 0, 10, 10);
      addChild(food);
    }

    food.x = Math.floor(Math.random() * 48) * 10;
    food.y = Math.floor(Math.random() * 48) * 10;
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

  public override function update(e:Event)
  {
    var head = snake.pop();
    var tail_x = Math.floor(head.x);
    var tail_y = Math.floor(head.y);

    if(snake.length > 0)
    {
      head.x = snake[0].x;
      head.y = snake[0].y;
    }
    switch(this.direction)
    {
      case Up: head.y -= 10;
      case Right: head.x += 10;
      case Down: head.y += 10;
      case Left: head.x -= 10;
    }

    snake.unshift(head);

    if(Math.floor(snake[0].x/10) == Math.floor(food.x/10) && Math.floor(snake[0].y/10) == Math.floor(food.y/10))
    {
      snakeLength++;
      initFood();
    }

    if(snake.length < snakeLength)
    {
      var tail = new Cell(tail_x, tail_y);
      snake.push(tail);
      addChild(tail);
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