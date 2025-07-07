/// @description Insert description here
// You can write your code in this editor

//Movement (Still a bit iffy)
if (!moving) {
    var _inputX = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
    var _inputY = (keyboard_check(vk_down) || keyboard_check(ord("S"))) - (keyboard_check(vk_up) || keyboard_check(ord("W")));

    if (_inputX != 0 || _inputY != 0) {
        directionIndex = (round((point_direction(0, 0, _inputX, -_inputY) + 270) / 45)) mod 8; //fucking christ rofl

        startX = x;
        startY = y;
        targetX = x + _inputX * TILESIZE;
        targetY = y + _inputY * TILESIZE;
	    
		//Tile-based Collision
	    var _tilemap = layer_tilemap_get_id("Collision");
	    var _tileX = targetX div TILESIZE;
	    var _tileY = targetY div TILESIZE;
	    var _tileIndex = tilemap_get(_tilemap, _tileX, _tileY);

	    if (_tileIndex != 1) {
	        moveX = _inputX * moveSpeed;
	        moveY = _inputY * moveSpeed;
	        totalDistance = abs(targetX - startX) + abs(targetY - startY);
	        moving = true;
	    }
	}
}
else {
	x += moveX;
	y += moveY;

	if ((moveX > 0 && x >= targetX) || (moveX < 0 && x <= targetX)) {x = targetX;}
	if ((moveY > 0 && y >= targetY) || (moveY < 0 && y <= targetY)) {y = targetY;}
	if (x == targetX && y == targetY) {moving = false;}
}

//Animation
if (moving) {
    var _moved = abs(x - startX) + abs(y - startY);
    var _progress = _moved / totalDistance;
    image_index = directionIndex * 4 + (floor(_progress * 4) mod 4);
}
else {
    image_index = directionIndex * 4;
}
