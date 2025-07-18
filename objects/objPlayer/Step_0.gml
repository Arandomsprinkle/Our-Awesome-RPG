/// @description Insert description here
// You can write your code in this editor

//Input
var _inputX = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
var _inputY = (keyboard_check(vk_down) || keyboard_check(ord("S"))) - (keyboard_check(vk_up) || keyboard_check(ord("W")));
var _interact = (keyboard_check(vk_space) || keyboard_check(ord("F")) || keyboard_check(vk_enter));

if global.isPaused exit

//Movement
if (!moving) {
    if (_inputX != 0 || _inputY != 0) {
        directionIndex = (round(point_direction(0, 0, _inputX, _inputY) / 45)) mod 8;

        startX = x;
        startY = y;
        targetX = x + _inputX * TILESIZE;
        targetY = y + _inputY * TILESIZE;

        //Tile-based Collision
        var _tilemap = layer_tilemap_get_id("Collision");
        var _tileX = targetX div TILESIZE;
        var _tileY = targetY div TILESIZE;
        var _tileIndex = tilemap_get(_tilemap, _tileX, _tileY);
		
		//Instance-based Collision
		var _instanceCollision = collision_point(targetX, targetY, objInteractable, false, true);

		//No Collisions? No problem!
        if (_tileIndex != 1 && !_instanceCollision) {
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
    if (x == targetX && y == targetY) {
		moving = false;
	}
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

//Interaction
if (!moving && _interact) {
    var _dirX = [1, 1, 0, -1, -1, -1, 0, 1];
	var _dirY = [0, -1, -1, -1, 0, 1, 1, 1];
	var _frontX = x + _dirX[directionIndex] * TILESIZE;
	var _frontY = y + _dirY[directionIndex] * TILESIZE;
    var _target = collision_point(_frontX, _frontY, objInteractable, false, true);
	
	if (instance_exists(_target)) {
		with _target {
			active = true;
		}
	}
}

//Attacking
if (keyboard_check_pressed(vk_space)) {
    var _dirX = [1, 1, 0, -1, -1, -1, 0, 1];
    var _dirY = [0, -1, -1, -1, 0, 1, 1, 1];

    var _offsetX = 0;
    var _offsetY = 0;
    var _attackAngle = 0;
    var _attackXscale = 1;
    var _attackYscale = 1;
    _attackXscale = (_dirX[directionIndex] == -1) ? -1 : 1;

    switch (directionIndex) {
        case 0: // Right
            _offsetX = TILESIZE / 2;
            _offsetY = 0;
            _attackAngle = 0; // Points right
            break;
        case 1: // Up-Right
            _offsetX = TILESIZE / 2;
            _offsetY = -TILESIZE / 2;
            _attackAngle = 45; // Points up-right
            break;
        case 2: // Up
            _offsetX = 0;
            _offsetY = -TILESIZE / 2;
            _attackAngle = 90; // Points up
            break;
        case 3: // Up-Left
            _offsetX = -TILESIZE / 2;
            _offsetY = -TILESIZE / 2;
            // The trick: Calculate angle as if it's UP-RIGHT, then _attackXscale will flip it
            _attackAngle = -45; // Corresponds to Up-Right angle
            break;
        case 4: // Left
            _offsetX = -TILESIZE / 2;
            _offsetY = 0;
            // The trick: Calculate angle as if it's RIGHT, then _attackXscale will flip it
            _attackAngle = 0; // Corresponds to Right angle
            break;
        case 5: // Down-Left
            _offsetX = -TILESIZE / 2;
            _offsetY = TILESIZE / 2;
            // The trick: Calculate angle as if it's DOWN-RIGHT, then _attackXscale will flip it
            _attackAngle = -315; // Corresponds to Down-Right angle
            break;
        case 6: // Down
            _offsetX = 0;
            _offsetY = TILESIZE / 2;
            _attackAngle = 270; // Points down
            break;
        case 7: // Down-Right
            _offsetX = TILESIZE / 2;
            _offsetY = TILESIZE / 2;
            _attackAngle = 315; // Points down-right
            break;
    }

    var _attack_instance = instance_create_layer(x + _offsetX, y + _offsetY, "entities", objPlayerAttack);

    _attack_instance.image_angle = _attackAngle;
    _attack_instance.image_xscale = _attackXscale;
    _attack_instance.image_yscale = _attackYscale;
	
	var _targetAttackTileX = x + _dirX[directionIndex] * TILESIZE;
    var _targetAttackTileY = y + _dirY[directionIndex] * TILESIZE;
	var _hitTileX = _targetAttackTileX div TILESIZE;
    var _hitTileY = _targetAttackTileY div TILESIZE;
	//DEBUG
	draw_set_color(c_fuchsia);
    draw_rectangle(_hitTileX * TILESIZE, _hitTileY * TILESIZE, (_hitTileX + 1) * TILESIZE - 1, (_hitTileY + 1) * TILESIZE - 1, false);
    draw_set_color(c_white);
	
	var _hitEnemies = ds_list_create();
	collision_rectangle_list(_hitTileX * TILESIZE, _hitTileY * TILESIZE, (_hitTileX + 1) * TILESIZE -1, (_hitTileY + 1) * TILESIZE -1, objEntity, false, true, _hitEnemies, false);
	if (ds_list_size(_hitEnemies) > 0) {
		for (var i = 0; i < ds_list_size(_hitEnemies); i++) {
			var _target_instance = _hitEnemies[| i];
			if (instance_exists(_target_instance)) {
				with (_target_instance) {
					var _damageDealt = 10;
					var _hpBefore = hp;
					hp -= _damageDealt;
					var _hpAfter = hp;
					show_debug_message("Hit " + object_get_name(object_index) + ": HP Before = " + string(_hpBefore) + ", Damage = " + string(_damageDealt) + ", HP After = " + string(_hpAfter));
				}
			}
			//more if statements based on ways to use attack
		}
	}
	ds_list_destroy(_hitEnemies);
    canAttack = false;
    alarm[0] = game_get_speed(gamespeed_fps) * 0.3;
}