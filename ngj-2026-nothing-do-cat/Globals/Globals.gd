extends Node

var tileSize : Vector2 = Vector2(32,32);  
var catTileSize : Vector2 = Vector2(32,32); 
var humanTileSize : Vector2 = Vector2(32,64); 

var screenSize : Vector2 = Vector2(320, 160);
var catPosition : Vector2;
var humanPosition : Vector2;

var human_interrupted_counter = 0;
var gameEnd = false;

#Screen size
#640 x 320
#480 x 270
#320 x 160
