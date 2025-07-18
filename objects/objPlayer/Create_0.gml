/// @description Insert description here
// You can write your code in this editor

moving = false;
startX = y;
startY = x;
moveX = 0;
moveY = 0;
targetX = 0;
targetY = 0;
directionIndex = 0;
totalDistance = 0;
moveSpeed = 1;
canAttack = true;
canInteract = true;

dirX = [1, 1, 0, -1, -1, -1, 0, 1];
dirY = [0, -1, -1, -1, 0, 1, 1, 1];


inventory = []; //Will flesh this out later.