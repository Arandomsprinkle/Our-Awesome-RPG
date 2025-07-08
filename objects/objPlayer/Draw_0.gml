/// @description Insert description here
// You can write your code in this editor
draw_self();




//Draw "targeted" square.
//I'm dumb so this is the best way I could come up with.
var _dirX = [1, 1, 0, -1, -1, -1, 0, 1];
var _dirY = [0, -1, -1, -1, 0, 1, 1, 1];
var _frontX = x + _dirX[directionIndex] * TILESIZE;
var _frontY = y + _dirY[directionIndex] * TILESIZE;

draw_sprite(sprChecker, 0, _frontX, _frontY);